{
  description = "A flake for NixOS and nix-darwin, with Determinate Nix";

  inputs = {
    # Stable Nixpkgs (use 0.1 for unstable)
    nixpkgs.url = "https://flakehub.com/f/NixOS/nixpkgs/0";
    # Stable nix-darwin (use 0.1 for unstable)
    nix-darwin = {
      url = "https://flakehub.com/f/nix-darwin/nix-darwin/0";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # Determinate 3.* module
    determinate = {
      url = "https://flakehub.com/f/DeterminateSystems/determinate/3";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager/release-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    catppuccin-bat = {
      url = "github:catppuccin/bat";
      flake = false;
    };
    # mac-app-util: Create app trampolines for /Applications/Nix Apps/ (system-level)
    # Used ONLY at darwin level for environment.systemPackages apps.
    # Home-manager apps use copyApps instead (see hosts/macbook-m4/home.nix).
    mac-app-util = {
      url = "github:hraban/mac-app-util";
      # Consolidate all input overrides in a single attrset
      # - nixpkgs: use our root nixpkgs
      # - systems: use our consolidated darwin-only systems
      # - treefmt-nix: transitive dependency, prevent duplicate nixpkgs in flake.lock
      # - cl-nix-lite: WORKAROUND for gitlab.common-lisp.net Anubis anti-bot protection
      #   See: https://github.com/hraban/mac-app-util/issues/39
      inputs = {
        nixpkgs.follows = "nixpkgs";
        treefmt-nix.inputs.nixpkgs.follows = "nixpkgs";
        cl-nix-lite.url = "github:r4v3n6101/cl-nix-lite/url-fix";
      };
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      home-manager,
      mac-app-util,
      ...
    }@inputs:
    let
      username = "alberth";
      userName = "Alberth Matos";
      userEmail = "alberth@matos.cc";
      specialArgs = { inherit username userName userEmail; };
    in
    {
      darwinConfigurations = {
        codex = inputs.nix-darwin.lib.darwinSystem {
          specialArgs = specialArgs // {
            hostname = "codex";
          };
          system = "aarch64-darwin";
          modules = [
            # Add the determinate nix-darwin module
            inputs.determinate.darwinModules.default
            # Apply the modules output by this flake
            self.darwinModules.determinateNixConfig

            ./hosts/macos/codex

            # mac-app-util: Creates trampolines for system-level apps (/Applications/Nix Apps/)
            mac-app-util.darwinModules.default

            home-manager.darwinModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;

              home-manager.extraSpecialArgs = inputs // specialArgs;
              home-manager.users.${username} = import ./users/${username}/home-macos.nix;
            }
          ];
        };
      };

      # nix-darwin module outputs
      darwinModules = {
        # Determinate Nix configuration
        determinateNixConfig = import ./modules/macos/determinate-nix-core.nix;

        # Add other module outputs here
      };

      nixosConfigurations = {
        gammu = inputs.nixpkgs.lib.nixosSystem {
          inherit specialArgs;
          system = "x86_64-linux";
          modules = [
            ./hosts/linux/gammu
            ./users/${username}/nixos.nix

            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;

              home-manager.extraSpecialArgs = inputs // specialArgs;
              home-manager.users.${username} = import ./users/${username}/home-linux.nix;
            }
          ];
        };
        xadrez = inputs.nixpkgs.lib.nixosSystem {
          inherit specialArgs;
          system = "aarch64-linux";
          modules = [
            ./hosts/linux/xadrez
            ./users/${username}/nixos.nix

            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;

              home-manager.extraSpecialArgs = inputs // specialArgs;
              home-manager.users.${username} = import ./users/${username}/home-linux.nix;
            }
          ];
        };
      };
      # Nix formatter
      #
      # This applies the formatter that follows RFC 166, which defines a standard format:
      # https://github.com/NixOS/rfcs/pull/166
      #
      # To format all Nix files:
      # git ls-files -z '*.nix' | xargs -0 -r nix fmt
      # To check formatting:
      # git ls-files -z '*.nix' | xargs -0 -r nix develop --command nixfmt --check
      #
      formatter = nixpkgs.lib.genAttrs [ "aarch64-darwin" "x86_64-linux" "aarch64-linux" ] (
        system: inputs.nixpkgs.legacyPackages.${system}.nixfmt
      );
    };
}
