# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/).

## [Unreleased]

### Added

- `users/alberth/nixos.nix`: set zsh as alberth's default login shell
  (`users.users.alberth.shell = pkgs.zsh`) and enable it at the system level
  (`programs.zsh.enable = true`) so it is listed in `/etc/shells`
- `home/shell/atuin.nix`: enable `programs.fish` and `programs.zsh` so that
  `enableFishIntegration` and `enableZshIntegration` inject atuin init into
  shell startup files (later moved to `users/alberth/home.nix`)

### Changed

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
