# Installing Corduroy Plugins

The Corduroy plugin marketplace is hosted at **`github.com/Corduroy-Dev/corduroy-tools`**. Both Claude Code and Cowork install from the same source — paste one URL, all 20 plugins become available.

---

## Option A — Claude Code (CLI / IDE)

**Prerequisites:** Claude Code v2.0 or later (`claude --version` to check).

1. **Add the marketplace** in any Claude Code session:

   ```
   /plugin marketplace add Corduroy-Dev/corduroy-tools
   ```

2. **Install the plugins you want.** Start with `financial-analysis` (it carries the shared modeling skills and all data connectors); add agents and verticals from there.

   ```
   /plugin install financial-analysis@corduroy
   /plugin install pitch-agent@corduroy
   /plugin install earnings-reviewer@corduroy
   /plugin install gl-reconciler@corduroy
   # …and so on. See README.md for the full list.
   ```

   Or interactively: type `/plugin` to open the plugin browser, find the `corduroy` marketplace, and pick plugins from the list.

3. **Use the plugins.** Slash commands (`/comps`, `/dcf`, `/earnings`, `/ic-memo`, …) become available immediately. Skills fire automatically when their triggers match.

### Updates

Claude Code refreshes marketplaces in the background. To pull updates manually:

```
/plugin marketplace update corduroy
/plugin update pitch-agent@corduroy   # per installed plugin
```

To pin to a specific release rather than tracking `main`:

```
/plugin marketplace add Corduroy-Dev/corduroy-tools@v0.1.0
```

---

## Option B — Cowork (Claude.ai desktop)

Each Cowork user adds the marketplace to their own Personal tab — no org admin required.

1. **Open Claude desktop** and switch to the **Cowork** tab.
2. Click **Customize** in the left sidebar.
3. Click **Browse plugins**.
4. Select the **Personal** tab.
5. Click the **+** button and select **Add marketplace from GitHub**.
6. Enter the repository URL: **`https://github.com/Corduroy-Dev/corduroy-tools`**
7. Once added, you'll see all 20 Corduroy plugins in the browser. Install the ones you need — start with **`financial-analysis`** (the core dependency), then add agents and verticals based on your workflow.

End users see installed plugins' skills via `/` or the **+** button inside conversations.

### Org-wide install (optional, requires admin)

If your org wants every member to get the plugins automatically rather than each user adding the marketplace themselves, an org admin can wire it up:

1. **Organization settings → Plugins → Add plugin → GitHub**
2. Enter `Corduroy-Dev/corduroy-tools`
3. End users see the plugins in their **Browse plugins** view without adding anything manually.

> Note: org-wide GitHub-sourced marketplaces in Cowork normally require a private repo. Public-repo support for org-level marketplaces varies — if your admin hits a "public repos aren't allowed" message, fall back to the Personal-tab flow above (works for every individual user).

---

## Updates

Both Claude Code and Cowork pick up new releases automatically. To pull manually:

- **Claude Code:** `/plugin marketplace update corduroy` then `/plugin update <name>@corduroy`.
- **Cowork:** plugins refresh in the background; restart the desktop app if a refresh isn't reflecting.

---

## Offline / air-gapped install

If your environment can't reach GitHub directly, request the offline bundle (`corduroy-tools-v0.1.0.zip` + `corduroy-tools-v0.1.0-cowork.zip`) from your Corduroy contact. The offline path:

- **Claude Code:** `unzip` to a stable path, then `/plugin marketplace add <path>`.
- **Cowork:** unwrap the Cowork bundle, then **Organization settings → Plugins → Add plugins → Upload a file** for each plugin you need (requires org admin role and Cowork+Skills enabled).

---

## Troubleshooting

| Symptom | Fix |
|---|---|
| `/plugin not found` in Claude Code | Update Claude Code to v2.0+ (`claude --version`). |
| `/plugin marketplace add` says "not found" | Confirm you have access to `github.com/Corduroy-Dev/corduroy-tools`. The repo is public — if `gh repo view Corduroy-Dev/corduroy-tools` fails from your shell, it's a local network/proxy issue. |
| MCP data connectors return auth errors | Most connectors require a subscription or API key from the provider (Daloopa, S&P Global, FactSet, etc.). Contact your Corduroy engagement lead to provision these against your existing vendor relationships. |
| A plugin doesn't show up after install | Run `/plugin list` to confirm it's there. If yes but commands aren't appearing, restart the session. |
| Cowork "Add marketplace from GitHub" doesn't appear | Personal-tab marketplaces require Cowork to be enabled for your account. If Cowork isn't enabled, contact your org admin or claude.ai support. |

---

## Support

For installation help, plugin tuning, or new-workflow scoping, contact your Corduroy engagement lead or `mmoore@corduroyintelligence.com`.
