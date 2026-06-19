# Nix Configuration

This repository is home to the nix code that builds my systems.

## Why Nix?

Nix allows for easy to manage, collaborative, reproducible deployments. This
means that once something is setup and configured once, it works forever. If
someone else shares their configuration, anyone can make use of it.

## How to install NixOS and Deploy this Flake?

After installed NixOS with `nix-command` & `flake` enabled, you can deploy this
flake with the following command:

```bash
sudo nixos-rebuild switch --flake .#xadrez
```

## How to install nix-darwin and Deploy this Flake?

After installed [Determinate Nix](https://docs.determinate.systems/?phid=019edc7b-acc2-787e-8dbb-13c9624490bc) enabled, you can deploy this
flake with the following command:

```bash
sudo darwin-rebuild switch --flake .#codex
```
