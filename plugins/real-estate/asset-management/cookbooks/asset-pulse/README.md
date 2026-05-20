# Asset Pulse — managed-agent template

## Overview

End-to-end real-estate portfolio review: variance / NOI bridge, property-issue scan across walkthroughs, lease portfolio status, refreshed 5-year capex plan, synthesized partner-ready narrative. Same source as the [`asset-pulse`](../../agents/asset-pulse) Cowork / Claude Code plugin — this directory is the Managed Agent cookbook for `POST /v1/agents`.

## Deploy

```bash
export ANTHROPIC_API_KEY=sk-ant-...
../../scripts/deploy-managed-agent.sh asset-pulse
```

(Note: the `deploy-managed-agent.sh` script lives in the financial-services side of the repo from upstream; verify path before running.)

## Steering events

See [`steering-examples.json`](./steering-examples.json) for example `event:` strings.

## Security & handoffs

- **Read-only data agents** (walkthrough-reader, variance-analyst) have no write tools.
- **narrator is the only leaf with Write access.** All produced markdown / report output flows through this single agent. Same write-isolation pattern used by `pitch-agent` / `deal-analyzer` and the financial-services agents.
- **LP-facing vs internal-only.** The narrator flags which items are LP-disclosable. Partner reviews before any LP-facing content goes out. The agent does NOT send LP communications directly.

## Subagents

- `walkthrough-reader` — reads property walkthroughs, maintenance logs, vendor data, leasing activity, abstracts new leases; returns structured findings
- `variance-analyst` — builds NOI bridges, refreshes capex schedule; returns structured analysis
- `narrator` — assembles the final partner-ready report; only leaf with Write

## What this cookbook is NOT

Not a property-management system. Doesn't replace the on-site walk, doesn't dispatch work orders, doesn't pay invoices. It augments asset-manager judgment with structured data analysis and pattern detection.
