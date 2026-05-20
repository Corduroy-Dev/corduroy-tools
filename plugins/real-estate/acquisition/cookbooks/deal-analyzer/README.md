# Deal Analyzer — managed-agent template

## Overview

End-to-end real-estate deal intake: OM analysis, rent-roll diligence, market snapshot, model review, IC memo. Same source as the [`deal-analyzer`](../../agents/deal-analyzer) Cowork / Claude Code plugin — this directory is the Managed Agent cookbook for `POST /v1/agents`.

## Deploy

```bash
export ANTHROPIC_API_KEY=sk-ant-...
../../scripts/deploy-managed-agent.sh deal-analyzer
```

(Note: the `deploy-managed-agent.sh` script lives in the financial-services side of the repo from upstream; verify path before running.)

## Steering events

See [`steering-examples.json`](./steering-examples.json) for example `event:` strings.

## Security & handoffs

- **Read-only data agents** (researcher, underwriter) have no write tools.
- **memo-writer is the only leaf with Write access.** All produced markdown / file output flows through this single agent. This is the same write-isolation pattern used by `pitch-agent` in the financial-services side.
- **Untrusted inputs:** OMs and rent rolls from brokers / sellers are treated as evidence to test, not as facts. The agent flags pattern-detection findings (fake-occupancy patterns, too-good-to-be-true assumptions, IRR manipulation) explicitly rather than silently accepting seller numbers.

## Subagents

- `researcher` — reads OM, rent roll, market context; returns structured JSON
- `underwriter` — audits the financial model; returns structured findings
- `memo-writer` — assembles the IC memo; only leaf with Write

## What this cookbook is NOT

Not a full transaction-execution pipeline. The output is a partner-ready intake packet, not signed letters of intent, financing applications, or closing documents.
