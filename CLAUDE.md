# Corduroy Plugins — Maintainer Guide

This file orients Corduroy engineers and Claude Code sessions working in this repository. It supersedes the upstream `anthropics/financial-services` developer guide.

This repository is a private derivative of [`anthropics/financial-services`](https://github.com/anthropics/financial-services) (Apache 2.0). See [`NOTICE`](./NOTICE) and [`MODIFICATIONS.md`](./MODIFICATIONS.md) for attribution and the scope of changes.

## What this is

A Claude plugin marketplace hosted at `github.com/Corduroy-Dev/corduroy-plugins` (public). The repo is **domain-scoped** so adding new industry verticals later is just a new subdirectory.

- `.claude-plugin/marketplace.json` — the catalog (name `corduroy`), with `category` + `tags` per plugin
- 18 plugins as of v0.2.0: 17 under `plugins/financial-services/` (10 agents, 7 verticals, 10 managed-agent cookbooks) and 1 under `plugins/shared/` (the M365 installer)

Customers install by pasting the GitHub URL into Claude Code (`/plugin marketplace add Corduroy-Dev/corduroy-plugins`) or Cowork (Customize → Browse plugins → Personal → + → Add marketplace from GitHub). Offline zip bundles produced by `scripts/build-bundle.sh` are still available for air-gapped customers.

## Repository layout

```
.claude-plugin/marketplace.json      # the catalog (name: corduroy)
plugins/
  financial-services/                # domain dir — first vertical we ship
    agents/<slug>/                   # workflow agents (self-contained)
      .claude-plugin/plugin.json
      agents/<slug>.md
      skills/                        # bundled copies, synced from ../verticals/
    verticals/<vertical>/            # FSI verticals — skill sources, commands, MCPs
      .claude-plugin/plugin.json
      commands/
      skills/
      .mcp.json
    cookbooks/<slug>/                # Managed Agent cookbooks (one per agent)
      agent.yaml                     # references ../../agents/<slug>/
      subagents/*.yaml
  shared/                            # cross-domain tooling
    claude-for-msft-365-install/     # admin tooling for the M365 add-in
scripts/
  bump-versions.sh                   # version bumper — single source of truth
  build-bundle.sh                    # produces customer zips
  verify-bundle.sh                   # gates delivery (run before shipping)
NOTICE                               # Apache 2.0 §4(c) attribution — DO NOT REMOVE
MODIFICATIONS.md                     # Apache 2.0 §4(b) modifications notice
LICENSE                              # Apache 2.0 (upstream) — DO NOT REMOVE
```

## Adding a new domain

```bash
mkdir -p plugins/<domain>/{agents,verticals,cookbooks}
# Author plugins under those dirs with their own .claude-plugin/plugin.json.
# Add marketplace.json entries with category: "<domain>" + relevant tags.
# bump-versions.sh, build-bundle.sh, verify-bundle.sh are path-agnostic
# (find walks the whole tree), so no script changes needed.
```

## Editing plugins

1. Edit the file in place. Markdown changes take effect immediately for any installed plugin once the customer runs `/plugin update <name>@corduroy`.
2. If you edit a skill in `plugins/<domain>/verticals/<vertical>/skills/<skill>/`, propagate to any agent that bundles it: `find plugins/<domain>/agents -path "*<skill-name>*" -name SKILL.md` to find the bundled copies.
3. Run `claude plugin validate .` to schema-check the marketplace and every plugin.json.

## Cutting a release

```bash
./scripts/bump-versions.sh 0.1.1     # bumps every plugin.json + marketplace.json
./scripts/build-bundle.sh             # produces offline zips (marketplace + per-plugin Cowork)
./scripts/verify-bundle.sh            # gates the zips — exits non-zero on any failure
git add -A && git commit -m "Release v0.1.1"
git tag v0.1.1
git push origin main --tags
```

The GitHub push is what makes the release live for customers — Claude Code/Cowork pull from `Corduroy-Dev/corduroy-plugins`. The zip artifacts are kept for air-gapped delivery; upload them as GitHub release assets if customers want a stable download URL.

**Versioning rule:** `version` lives **only** in each `.claude-plugin/plugin.json`. Don't add a per-plugin `version` to `marketplace.json` entries — when both are set, plugin.json silently wins, which masks the marketplace value. `bump-versions.sh` is the single canonical bumper.

**License preservation:** Never delete `LICENSE`, `NOTICE`, or `MODIFICATIONS.md`. `verify-bundle.sh` enforces their presence in the bundle.

## What's deliberately NOT in here

- No `.github/` workflows. No `.githooks/`. The upstream's pre-commit version-bump enforcement is replaced by `bump-versions.sh` being the only sanctioned bump path.
- No `scripts/check.py` / `validate.py` / `orchestrate.py` / `sync-agent-skills.py` from upstream are wired into CI. They're kept in `scripts/` for local use; before re-bundling any of them, audit with `rg 'anthropic|piccolella' scripts/`.

## Pointers

- Customer-facing install instructions: [`INSTALL.md`](./INSTALL.md)
- Marketing/agent overview: [`README.md`](./README.md)
- The Corduroy product working directory (this isn't it): `~/Work/usul-vault/corduroy/` — see its `AGENTS.md` for the broader operating context.
