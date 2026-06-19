{ ... }:
{
  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 6;

  imports = [
    ../../../modules/macos/nix-core.nix
    ../../../modules/macos/system.nix
    ../../../modules/macos/host.nix
    ../../../modules/macos/user.nix
    ../../../modules/macos/apps.nix
    ../../../modules/common
  ];
}
