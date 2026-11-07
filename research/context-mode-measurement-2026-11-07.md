# Context Mode measurement, 2026-11-07

Scope: Prompt 2 of prompts/2026-11-07-agent-tooling.md. Machine: Andro's Windows 11 PC. Only what was measured here is reported. The project's own 98% figure is not used as a result.

## 1. Install result

- Not installed by me. The `context-mode` plugin v1.0.169 was already loaded in this environment. I ran no `/plugin marketplace add` or `claude mcp add` command.
- `ctx_doctor` output (quoted):
  - `context-mode v1.0.169 outdated -> v2.1.5 available. Upgrade: /ctx-upgrade`
  - `[OK] Runtimes: 5/11 (45%) javascript, shell, python, go, rust`
  - `[WARN] Performance: NORMAL, install Bun for 3-5x speed boost`
  - `[OK] Server test: PASS`
  - `[OK] FTS5 / SQLite: PASS, native module works`
  - `[OK]` PreToolUse and SessionStart hooks configured; all 6 hook scripts PASS
- I did not upgrade to v2.1.5. This is the older version, and the numbers below apply to v1.0.169 only.
- `ctx_stats` output (quoted): `No measurable redirect activity captured yet` for this chat. Lifetime figure: `5.7 MB kept out ... across 219 projects since Oct 10, 2026`. That lifetime number is the tool's own self-report and I did not verify it.

## 2. Measured table

Job: list the plugin's own install folder (6,463 files) and report the file count plus the top 5 extensions by total size. This is a small inspection job, not the full research + code job the prompt asks for.

| Job | Context without (bytes into context) | Context with (bytes into context) | Savings |
|---|---|---|---|
| File inventory of the context-mode plugin folder | 836,221 | 102 | 99.99% by bytes (836,119 of 836,221 kept out) |

Raw output quoted:
- Raw file listing, measured inside the sandbox via `ctx_execute`: `RAW_BYTES=836221 files=6463`
- What entered context: `RAW_BYTES=836221 files=6463 top5=.node:34727424, .js:30317753, .exe:23080960, .ts:17291663, .c:9508567` (102 bytes by `wc -c`)

Caveats, all of which weaken the number:
- "Without" is not a real second run. I did not put 836 KB into context. It is the size of the raw listing that `ctx_execute` measured, so it is what a plain Bash `find`/`Get-ChildItem` would have returned.
- Bytes, not tokens. Task quality was not compared.
- One job, one run. Not the two-session A/B of a full research + code task that the prompt asks for.
- The hook-based savings were not isolated. The stats command showed no redirect activity for this chat, so I have no `ctx_stats` before/after delta. Not verified.
- This subagent session is not a clean baseline for a "without Context Mode" run.

## 3. Windows hang test

NOT VERIFIED. A long-running session test could freeze Andro's PC, and I will not risk that from an unattended agent. In the short time this session ran, the following all worked without a hang: `ctx_doctor`, `ctx_stats`, and one `ctx_execute` that shelled out to PowerShell over a 6,463-file recursive listing. That is evidence of no immediate hang, not a pass or fail for the hang bug.

## 4. Telemetry check (code read, v1.0.169 cache)

I grepped the plugin folder, skipping node_modules.
- No match for `posthog`, `mixpanel`, `sentry` or `telemetry` in `cli.bundle.mjs`, `hooks/session-loaders.mjs` or `hooks/cache-heal-utils.mjs`. A broader `analytics` grep did match some files (e.g. `bin/statusline.mjs`). I did not read those, so this is not a full audit.
- Outbound URLs found in the `.mjs` files:
  - `registry.npmjs.org/context-mode/latest`, a version check
  - `raw.githubusercontent.com/BerriAI/litellm/.../model_prices_and_context_window.json`, a pricing table fetch
  - `https://context-mode.com/insight`, an optional dashboard opened on request through the `ctx_insight` tool, described in code as "the hosted analytics layer"
  - `bun.sh/install` and various vendor pricing pages (these are links in strings and docs; I did not check whether code fetches them)
- So the claim "no telemetry" is only partly confirmed. I found no usage-reporting calls in the files I checked, but the plugin does make version and pricing network requests, and it has an optional hosted dashboard. A full audit of server.bundle.mjs is not done.

## 5. What still fails or is not done

- Full two-run (without / with) research + code job: not done.
- Windows hang test: not verified.
- `ctx_stats` before/after delta for a job: not obtained.
- Upgrade to v2.1.5: not done.
- Full telemetry audit: not done.
- Omega Pack README install line: not added. The savings did not meet the "if the savings hold" bar on a single weak proxy measurement, and the rules for this task forbid editing outside research/.
- Verification round (different agent re-checks from stats output): not run. I only re-checked that the quoted raw lines match the table: 836,221 and 102 bytes.
