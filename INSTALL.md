# Installing Corduroy Plugins

You've received the Corduroy plugin bundle as either a marketplace zip (`corduroy-plugins-v0.1.0.zip`) for Claude Code installs, or a directory of per-plugin zips (`corduroy-plugins-v0.1.0-cowork/`) for Cowork installs, or both. Pick the path that matches how your team uses Claude.

## Verify the download (optional but recommended)

If you received a `SHA256SUMS` file alongside the artifacts:

```bash
sha256sum -c SHA256SUMS
```

All files should report `OK`. If any line says `FAILED`, request a re-send before installing.

---

## Option A — Claude Code (CLI / IDE)

**Prerequisites:** Claude Code installed and authenticated. The `/plugin` command requires Claude Code v2.0 or later. Check with `claude --version`.

1. **Extract the zip to a stable folder** somewhere outside iCloud/Dropbox/OneDrive sync paths (those can interfere with file watching):

   ```bash
   mkdir -p ~/corduroy-plugins
   unzip corduroy-plugins-v0.1.0.zip -d ~/corduroy-plugins
   ```

2. **Add the marketplace** in any Claude Code session:

   ```
   /plugin marketplace add ~/corduroy-plugins
   ```

3. **Install the plugins you want.** Start with `financial-analysis` (it carries the shared modeling skills and all data connectors); add agents and verticals from there.

   ```
   /plugin install financial-analysis@corduroy
   /plugin install pitch-agent@corduroy
   /plugin install earnings-reviewer@corduroy
   /plugin install gl-reconciler@corduroy
   # ...and so on. See README.md for the full list.
   ```

   Or, interactively: type `/plugin` to open the plugin browser, find the `corduroy` marketplace, and pick plugins from the list.

4. **Use the plugins.** Slash commands (`/comps`, `/dcf`, `/earnings`, `/ic-memo`, …) become available immediately. Skills fire automatically when their triggers match. Agent plugins are available via Cowork dispatch when running inside Cowork.

### If you move the folder later

The marketplace add records the absolute path you used. If you move or delete `~/corduroy-plugins`, future `/plugin install` and `/plugin marketplace update corduroy` calls will fail (already-installed plugins keep working from cache). To recover:

```
/plugin marketplace remove corduroy
/plugin marketplace add <new-path>
```

Then reinstall any plugins you'd uninstalled.

### Updating to a new release

When you receive a new zip:

```bash
# Extract on top of the existing folder
unzip -o corduroy-plugins-v0.X.Y.zip -d ~/corduroy-plugins
```

Then in Claude Code:

```
/plugin marketplace update corduroy
/plugin update pitch-agent@corduroy   # repeat per installed plugin, or use the UI
```

---

## Option B — Cowork (Claude.ai desktop)

**Prerequisites:** Your organization must have both **Cowork** and **Skills** enabled. You need **org admin** permissions to upload plugins. End users see plugins via **Customize → Browse plugins** once an admin has uploaded them.

You'll be uploading the per-plugin zips from the `corduroy-plugins-v0.1.0-cowork/` directory. Cowork accepts one zip at a time, 50 MB max per zip.

1. **Extract the Cowork bundle:**

   ```bash
   unzip corduroy-plugins-v0.1.0-cowork.zip   # or however it was delivered
   ```

   You should see ~20 files named `corduroy-<plugin-name>-v0.1.0.zip`.

2. **Open Claude desktop** and navigate to **Organization settings → Plugins**.

3. **Click "Add plugins" → "Upload a file"** and drag in (or browse to) one of the `corduroy-*-v0.1.0.zip` files.

4. **Repeat for each plugin** you want to make available. We recommend starting with:

   - `corduroy-financial-analysis-v0.1.0.zip` (the core dependency)
   - One or two agents that match your workflow (e.g., `corduroy-pitch-agent-v0.1.0.zip`, `corduroy-earnings-reviewer-v0.1.0.zip`)

5. **Click "Upload"** to add the uploaded plugins to a new private marketplace inside your org.

6. **End users install the plugins** via **Customize → Browse plugins → (your private marketplace)** in their own Cowork session. Skills become available via `/` or `+` in conversations.

### Updating in Cowork

For new releases, upload the newer `corduroy-<plugin>-v0.X.Y.zip` files. Cowork manages versions per plugin entry.

---

## Troubleshooting

| Symptom | Fix |
|---|---|
| `/plugin marketplace add` says "marketplace.json not found" | Make sure you extracted to a folder that contains `.claude-plugin/marketplace.json` directly inside it. The path you pass to `add` should be the folder, not the zip. |
| Claude Code says "/plugin not found" | Update Claude Code to v2.0+ (`claude --version`). |
| Cowork upload fails | Verify the zip is under 50 MB and is a valid zip (`unzip -t <file>.zip`). Each per-plugin zip is well under the limit — if it's failing, you may have grabbed the wrong file. |
| MCP data connectors return auth errors | Most connectors require a subscription or API key from the provider (Daloopa, S&P Global, FactSet, etc.). Contact your Corduroy engagement lead to provision these against your existing vendor relationships. |
| A plugin doesn't show up after install | Run `/plugin list` to confirm it's there. If yes but commands aren't appearing, restart the session. |

---

## Support

This is a private distribution to Corduroy customers. For installation help, plugin tuning, or new-workflow scoping, contact your Corduroy engagement lead or `mmoore@corduroyintelligence.com`.
