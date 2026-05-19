# Corduroy Plugins — Maintainer Guide

This file orients Corduroy engineers and Claude Code sessions working in this repository. It supersedes the upstream `anthropics/financial-services` developer guide.

This repository is a private derivative of [`anthropics/financial-services`](https://github.com/anthropics/financial-services) (Apache 2.0). See [`NOTICE`](./NOTICE) and [`MODIFICATIONS.md`](./MODIFICATIONS.md) for attribution and the scope of changes.

## What this is

A Claude plugin marketplace hosted at `github.com/Corduroy-Dev/corduroy-plugins` (public):

- `.claude-plugin/marketplace.json` — the catalog, name `corduroy`, owner Corduroy Intelligence
- 20 plugins under `plugins/agent-plugins/`, `plugins/vertical-plugins/`, `plugins/partner-built/`, plus the root-level `claude-for-msft-365-install/`
- 10 managed-agent cookbooks under `managed-agent-cookbooks/` (ride along as reference for customers wanting headless deployment)

Customers install by pasting the GitHub URL into Claude Code (`/plugin marketplace add Corduroy-Dev/corduroy-plugins`) or Cowork (Customize → Browse plugins → Personal → + → Add marketplace from GitHub). Offline zip bundles produced by `scripts/build-bundle.sh` are still available for air-gapped customers.

## Repository layout

```
.claude-plugin/marketplace.json      # the catalog (name: corduroy)
plugins/
  agent-plugins/<slug>/              # named workflow agents (self-contained)
    .claude-plugin/plugin.json
    agents/<slug>.md
    skills/                          # bundled copies, synced from vertical-plugins/
  vertical-plugins/<vertical>/       # FSI verticals — skill sources, commands, MCPs
    .claude-plugin/plugin.json
    commands/
    skills/
    .mcp.json
  partner-built/{lseg,spglobal}/     # partner plugins (KEEP their LICENSE files)
managed-agent-cookbooks/<slug>/      # Managed Agent cookbooks (one per named agent)
claude-for-msft-365-install/         # admin tooling for the M365 add-in
scripts/
  bump-versions.sh                   # version bumper — single source of truth
  build-bundle.sh                    # produces customer zips
  verify-bundle.sh                   # gates delivery (run before shipping)
NOTICE                               # Apache 2.0 §4(c) attribution — DO NOT REMOVE
MODIFICATIONS.md                     # Apache 2.0 §4(b) modifications notice
LICENSE                              # Apache 2.0 (upstream) — DO NOT REMOVE
plugins/partner-built/spglobal/LICENSE  # S&P Global's own Apache 2.0 — DO NOT REMOVE
```

## Editing plugins

1. Edit the file in place. Markdown changes take effect immediately for any installed plugin once the customer runs `/plugin update <name>@corduroy`.
2. If you edit a skill in `plugins/vertical-plugins/<vertical>/skills/<skill>/`, propagate to any agent that bundles it. The upstream had a `sync-agent-skills.py` script; for v0.1.0 we don't ship that automation — copy by hand and check `find plugins/agent-plugins -name 'SKILL.md' -path '*<skill-name>*'` to find the bundled copies.
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

**License preservation:** Never delete `LICENSE`, `NOTICE`, `MODIFICATIONS.md`, or `plugins/partner-built/spglobal/LICENSE`. `verify-bundle.sh` enforces this.

## What's deliberately NOT in here

- No `.github/` workflows. No `.githooks/`. The upstream's pre-commit version-bump enforcement is replaced by `bump-versions.sh` being the only sanctioned bump path.
- No `scripts/check.py` / `validate.py` / `orchestrate.py` / `sync-agent-skills.py` from upstream are wired into CI. They're kept in `scripts/` for local use; before re-bundling any of them, audit with `rg 'anthropic|piccolella' scripts/`.

## Pointers

- Customer-facing install instructions: [`INSTALL.md`](./INSTALL.md)
- Marketing/agent overview: [`README.md`](./README.md)
- The Corduroy product working directory (this isn't it): `~/Work/usul-vault/corduroy/` — see its `AGENTS.md` for the broader operating context.
