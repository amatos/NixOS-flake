# AGENTS.md

This file provides guidance to LLM agents when working with code in this repository.

## What this is

This repo represents a Nix flake configuration for my personal NixOS (26.05) and
nix-darwin setups.

Configuration for individual hosts are stored in `hosts/`, which reference
modular configurations in `modules/`.

Home-manager configuration is stored in `users/`, which reference modular
configurations in `home/`.

## Where changes belong

- **`users/<name>/`** — user-specific configuration (e.g. which modules a user
  imports, personal settings like name/email, shell choices). Changes that are
  specific to a particular user live here.
- **`home/`** — application-focused, reusable home-manager modules (e.g. atuin
  settings, shell aliases, program configuration). These should be generic enough
  to be imported by any user.
- **`hosts/<hostname>/`** — host-specific NixOS configuration (e.g.
  hardware-configuration.nix, host-level overrides). Changes that apply only to
  a particular machine live here.
- **`modules/`** — shared NixOS system modules reused across hosts.

If it is unclear which of the above a change belongs to, **do not assume — ask
before making the change**.

## Git commit messages

Commit messages follow the [Conventional Commits](https://www.conventionalcommits.org/)
specification. The summary line should be prefixed with a type (`feat`, `fix`, `docs`,
`chore`, `refactor`, etc.), and the body should use a succinct bulleted list to describe
what changed:

```shell
<type>[optional scope]: brief summary

- path/to/file: what changed and why
- path/to/other/file: what changed and why
```

## Changelog

`CHANGELOG.md` follows the [Keep a Changelog](https://keepachangelog.com/en/1.1.0/) format.
Always update it whenever you make a change to the repository. Add entries under the
`## [Unreleased]` section, using `### Added`, `### Changed`, `### Fixed`, or `### Removed`
sub-headings as appropriate. Each entry should name the affected file and briefly explain
what changed and why.

Whenever updating the changelog, also check the git log for any committed changes that are
not yet reflected in `CHANGELOG.md`, and add entries for those as well.

When committing manually, use a tool like [commitizen](https://github.com/commitizen-tools/commitizen)
(`cz commit`) to ensure commit messages and changelog entries stay consistent and useful.
