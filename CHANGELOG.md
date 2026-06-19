# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/).

## [Unreleased]

### Added

- `flake.nix`: added `nix-darwin`, `determinate`, and `mac-app-util` flake
  inputs (replacing the old `darwin`/`nixpkgs-darwin` inputs), and wired up
  `darwinConfigurations.codex` with the Determinate nix-darwin module,
  `mac-app-util`, and home-manager
- `flake.nix`: added a top-level `darwinModules.determinateNixConfig` output
  (imports `modules/macos/determinate-nix-core.nix`) and a `formatter` output
  (`nixfmt`, per RFC 166) for `aarch64-darwin`, `x86_64-linux`, and
  `aarch64-linux`
- `modules/macos/nix-core.nix`: shared nix-darwin Nix settings (experimental
  features, substituters, trusted public keys)
- `modules/macos/system.nix`: shared nix-darwin system defaults (24-hour
  clock, TouchID for sudo, zsh)
- `modules/macos/host.nix`: templated hostname/computer-name/NetBIOS-name
  module, parameterized by a `hostname` argument
- `modules/macos/user.nix`: declares the primary macOS user account and adds
  them to `nix.settings.trusted-users`
- `modules/macos/apps.nix`: nix-darwin `environment.systemPackages` and
  Homebrew (`taps`/`brews`/`casks`) configuration
- `modules/macos/determinate-nix-core.nix`: enables Determinate Nix
  (`determinateNix.enable = true`) with custom settings written to
  `/etc/nix/nix.custom.conf`
- `hosts/macos/codex/default.nix`: imports the new `modules/macos/*` modules
  and `modules/common`
- `home/macos/default.nix`: placeholder module for macOS-specific
  home-manager config (currently empty)
- `users/alberth/home-macos.nix`: macOS home-manager entry point — imports
  `home/common` and `home/macos` only (no Linux-only desktop modules)
- `README.md`: documented `darwin-rebuild switch --flake .#codex` as the
  deploy command for the nix-darwin host, alongside the existing
  `nixos-rebuild` instructions
- `AGENTS.md`: noted that Linux hosts use standard Nix while macOS hosts use
  Determinate Nix
- `home/common/programs/tealdeer.nix`: added `tealdeer` configuration
- `modules/common/shell.nix`: added `cowsay`, `fortune`, `fzf`, `htop`, `ripgrep`, `tealdeer`, `tmux`, `wget`, `yazi`, `zoxide`
- `modules/linux/system.nix`: added `ghostty.terminfo` to `environment.systemPackages` to provide terminfo for `ghostty`
- `users/alberth/nixos.nix`: set zsh as alberth's default login shell
  (`users.users.alberth.shell = pkgs.zsh`) and enable it at the system level
  (`programs.zsh.enable = true`) so it is listed in `/etc/shells`
- `home/shell/atuin.nix`: enable `programs.fish` and `programs.zsh` so that
  `enableFishIntegration` and `enableZshIntegration` inject atuin init into
  shell startup files (later moved to `users/alberth/home.nix`)
- `flake.nix`: added `nixpkgs-darwin` and `darwin` (nix-darwin) flake inputs,
  and a `darwinConfigurations.codex` output for an initial nix-darwin host
  skeleton
- `hosts/macos/codex/default.nix`: populated the previously empty nix-darwin
  host skeleton with `system.stateVersion = 6`

### Changed

- `users/alberth/home.nix` split per platform: renamed to
  `users/alberth/home-linux.nix` (used by `gammu`/`xadrez`, unchanged
  content) and added `users/alberth/home-macos.nix` (used by `codex`) so the
  macOS host no longer pulls in Linux-only desktop modules
  (`home/linux/i3`, `home/linux/rofi`, `home/linux/fcitx5`)
- `flake.nix`: `nixosConfigurations.gammu`/`xadrez` no longer include
  `determinate.nixosModules.default` — Linux hosts use standard NixOS Nix
  management (`modules/linux/system.nix`'s `nix.settings`/`nix.gc`), only
  macOS uses Determinate Nix
- `flake.nix`: removed the now-unused `determinate` destructured output
  argument (only `inputs.determinate.darwinModules.default` is referenced)
- `users/alberth/home.nix`: moved `programs.fish.enable` and `programs.zsh.enable`
  here from `home/shell/atuin.nix` — shell choice is user-specific, not
  application-specific
- `AGENTS.md`: fixed nix-darwin (was incorrectly reversed as `darwin-nix`)
- `AGENTS.md`: fixed heading (was incorrectly titled `CLAUDE.md`)
- `AGENTS.md`: added "Where changes belong" section documenting the purpose of
  `users/`, `home/`, `hosts/`, and `modules/`, with an instruction to ask rather
  than assume when placement is unclear
- `AGENTS.md`: strengthened changelog instructions — always update on every change,
  and check git log for any previously unlogged commits when updating
- `hosts/gammu/` moved to `hosts/linux/gammu/`; updated `flake.nix` module path
  and fixed `hosts/linux/gammu/default.nix` relative imports of `modules/`
  (now `../../../modules/...`) to account for the extra directory depth
- `hosts/xadrez/` moved to `hosts/linux/xadrez/`; updated `flake.nix` module path
  and fixed `hosts/linux/xadrez/default.nix` relative imports of `modules/`
  (now `../../../modules/...`) to account for the extra directory depth
- `modules/` moved to `modules/linux/`; updated `hosts/linux/gammu/default.nix`
  and `hosts/linux/xadrez/default.nix` imports of `system.nix`, `no-gui.nix`,
  and `i3.nix` to `../../../modules/linux/...`
- `home/` split into `home/common/` (cross-platform config: shell, atuin,
  starship, git, generic CLI packages/programs) and `home/linux/` (Linux-only
  config: i3, rofi, fcitx5, browsers, media, xdg). `home/programs/common.nix`
  was divided between `home/common/programs/common.nix` (generic packages and
  `programs.*` options) and `home/linux/programs/common.nix` (Linux-only
  packages and `services.syncthing`/`services.udiskie`)
- `users/alberth/home.nix`: updated imports to the new `home/common` and
  `home/linux/{fcitx5,i3,programs,rofi}` paths after the `home/` split
- `home/linux/programs/default.nix`: removed a dangling `./git.nix` import
  left over from the `home/` split — git config now lives under
  `home/common/programs/`, already pulled in via the `home/common` import
- `flake.nix`: fixed `darwinConfigurations.codex` module path from
  `./hosts/codex` to `./hosts/macos/codex` to match the host's new location
- `home/common/shell/core.nix`: made `home.homeDirectory` platform-aware
  (`/Users/${username}` on Darwin via `pkgs.stdenv.isDarwin`, otherwise
  `/home/${username}`) now that this module is shared with the nix-darwin host

### Fixed

- `flake.nix`: moved `darwinModules` out of `darwinConfigurations` to be a
  top-level flake output — it was nested inside `darwinConfigurations`,
  so `self.darwinModules.*` couldn't resolve, and `nix flake show`/tooling
  tried to evaluate it as if it were a system configuration
- `flake.nix`: removed the `self.darwinModules.base` reference — no such
  module was ever defined; `hosts/macos/codex` already pulls in everything
  it needs via its own `imports`
- `flake.nix`: fixed `darwinModules.determinateNixConfig`'s import path,
  which pointed at the nonexistent `modules/macos/determinate-nix-config.nix`
  (the real file is `modules/macos/determinate-nix-core.nix`)
- `flake.nix`: fixed the `codex` home-manager module block, which set bare
  `specialArgs`/`users.${username}` instead of
  `home-manager.extraSpecialArgs`/`home-manager.users.${username}` — the
  former would have written the home-manager config into the real
  `users.${username}` system-user option instead of activating home-manager
- `flake.nix`: added `hostname = "codex"` to `codex`'s `specialArgs`, since
  `modules/macos/host.nix` requires a `hostname` argument that was never
  supplied
- `hosts/macos/codex/default.nix`: changed `modules = [...]` to
  `imports = [...]` — `modules` is not a valid nix-darwin/NixOS option name
- `hosts/macos/codex/default.nix`: fixed relative import paths from
  `../../modules/macos/...` to `../../../modules/macos/...` — the host file
  is three directories deep (`hosts/macos/codex/`), so two `../` resolved to
  the nonexistent `hosts/modules/macos/...`
- `modules/macos/determinate-nix-core.nix`: fixed a syntax error (stray
  trailing semicolons after closing braces) that broke evaluation
- `modules/macos/determinate-nix-core.nix`: dropped the unused `config`,
  `pkgs`, and `lib` module arguments (flagged by `deadnix`) — none were
  referenced in the module body
- Repo-wide `deadnix` cleanup of other unused module arguments it flagged:
  `home/linux/fcitx5/default.nix` (`config`, `pkgs`),
  `home/linux/programs/media.nix` (`config`),
  `home/linux/programs/browsers.nix` (`pkgs`, `config`),
  `home/linux/rofi/default.nix` (`pkgs`, `config`),
  `home/linux/i3/default.nix` (`pkgs`, `config`),
  `users/alberth/home-macos.nix` (`pkgs`),
  `users/alberth/home-linux.nix` (`pkgs`),
  `modules/macos/system.nix` (`pkgs`),
  `modules/linux/base-gui.nix` (`lib`, `username`, `userName`),
  `modules/linux/no-gui.nix` (`pkgs`, `lib`, `username`, `userName`), and
  `hosts/linux/{gammu,xadrez}/hardware-configuration.nix` (`pkgs`) — the
  latter two are nixos-generate-config-managed files normally left
  untouched, so this cosmetic fix will be reverted if they're regenerated
- `modules/macos/nix-core.nix`: removed a duplicate, invalid
  `determinateNixConfig = { determinateNix = {...}; }` attribute (not a real
  nix-darwin option; duplicated `modules/macos/determinate-nix-core.nix`)
- `modules/macos/nix-core.nix`: removed `nix.gc.automatic`/`nix.gc.options`,
  which hard-failed the `nix.gc.automatic requires nix.enable` assertion
  since Determinate Nix force-sets `nix.enable = false`; Determinate manages
  its own garbage collection
- `modules/macos/nix-core.nix`: dropped the now-unused `lib`/`config`
  module arguments
- `README.md`: added a missing blank line after the "How to install
  nix-darwin and Deploy this Flake?" heading, fixing a `markdownlint`
  MD022 violation that blocked the pre-commit hook

## [2026.06.18] - 2026-06-18

### Added

- `flake.nix`: initial basic flake with nixpkgs input
- `flake.nix`: added home-manager input and wired it into the NixOS configuration
- `flake.nix`: added `catppuccin-bat` flake input
- `flake.nix`: converted to a multi-host flake supporting `gammu` and `xadrez`
- `home/`: modular home-manager configuration split across `core.nix`, `programs/`, `shell/`, `i3/`, `rofi/`, and `fcitx5/`
- `home/programs/common.nix`: common user packages including wine, tealdeer, bat, eza, fastfetch, and others
- `home/programs/browsers.nix`: browser package configuration
- `home/programs/git.nix`: git program configuration
- `home/programs/media.nix`: media package configuration
- `home/programs/xdg.nix`: XDG mime-type and default application configuration
- `home/shell/default.nix`: shell configuration for fish and zsh
- `home/shell/common.nix`: shared shell aliases and environment variables
- `home/shell/starship.nix`: starship prompt configuration
- `home/shell/atuin.nix`: atuin shell history sync with fish/zsh integration, auto-sync every 5 minutes, prefix search mode
- `home/i3/`: i3 window manager config, keybindings, i3blocks config, and status bar scripts
- `home/rofi/`: rofi launcher theme configs (arc dark, powermenu, keyhint, rofidmenu)
- `home/fcitx5/`: fcitx5 input method configuration
- `hosts/gammu/`: host-specific configuration and hardware-configuration.nix for gammu
- `hosts/xadrez/`: host-specific configuration and hardware-configuration.nix for xadrez
- `modules/system.nix`: shared NixOS system module (locale, fonts, networking, user accounts, SSH, etc.)
- `modules/i3.nix`: i3-specific NixOS module (xserver, xrdp, display manager, packages)
- `modules/base-gui.nix`: new module for GUI base config — fonts, PipeWire/audio, ghostty, udev rules (extracted from `system.nix`)
- `modules/no-gui.nix`: minimal headless NixOS module for non-GUI hosts
- `users/alberth/home.nix`: alberth's home-manager entry point
- `users/alberth/nixos.nix`: alberth's NixOS user account definition
- `AGENTS.md`, `CLAUDE.md`: project instructions for LLM coding agents
- `.commitlintrc.yaml`, `.markdownlint-cli2.yaml`, `.markdownlint.json`, `.markdown-link-check.json`, `.pre-commit-config.yaml`: repo tooling and linting configuration
- `scripts/check-markdown-links.py`: markdown link checker script

### Changed

- `configuration.nix`: set default user shell to zsh, added neovim/git/zsh system packages, configured user account and groups
- `configuration.nix`: enabled Nix flakes and nix-command experimental features
- `configuration.nix`: switched to latest Linux kernel (`linuxPackages_latest`)
- `configuration.nix`: referenced `hardware-configuration.nix` by absolute path (`/etc/nixos/`)
- `home.nix`: replaced `neofetch` with `fastfetch`
- `home.nix`: migrated git config from `programs.git.userName`/`userEmail` to `programs.git.settings.user.{name,email}`
- `home.nix`: added tealdeer home-manager configuration
- `modules/system.nix`: set a default password for the user account
- `modules/i3.nix`: replaced `i3-gaps` with `i3` package; moved `displayManager` config out of the `xserver` block; added xrdp service
- `modules/i3.nix`: renamed deprecated packages to current nixpkgs names
- `modules/system.nix`: replaced `noto-fonts-emoji` with `noto-fonts-color-emoji`
- `home/programs/common.nix`: replaced deprecated `wineWowPackages` with `wineWow64Packages`; removed deprecated `programs.ssh.enable`
- `users/alberth/home.nix`: migrated git user config to `settings.user.{name,email}`; added atuin to shell modules
- `hosts/gammu/default.nix`: switched gammu from GUI (`i3`) to headless (`no-gui`) module
- All `.nix` files: reformatted with `nixfmt-rfc-style` (nixfmt 1.3.1)

### Fixed

- `configuration.nix`: disabled `system.copySystemConfiguration` (unsupported with flakes)
- `hosts/xadrez/`: renamed from `hosts/xadres` — typo in directory name caused flake evaluation failure
- `modules/i3.nix`: removed stale `lightdm` reference
- `flake.nix`: fixed indentation in the `xadrez` let-block

### Removed

- `hardware-configuration.nix`: removed from root and added to `.gitignore` (host-specific, not tracked)
- `configuration.nix`, `home.nix`: removed legacy monolithic config files after refactor to multi-host flake structure
- `.gitignore`: removed after hardware configs were committed under `hosts/`
