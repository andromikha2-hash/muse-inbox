# Agent tools & research — everything sent Nov 7, 2026 (compact)

Stored: 2026-11-07. Source: Instagram reels Andro sent Muse on Nov 7, each
fetched and verified the same day. QuantFinanceToGo has its own file:
`research/quantfinancetogo.md` (42-part series, Parts 1–42).

## The big-lab consensus (deep research, Nov 7, 2026)

Engineers at Google, Meta, Anthropic, and OpenAI all converge on one
workflow for AI coding agents:

- Short static rules file (Anthropic: CLAUDE.md under 200 lines) + scoped
  rules + skills that load on demand — never a knowledge-graph rule store
  as the default for a solo developer.
- Plan first, then build (spec → fresh session → build).
- A fresh-context verifier (not the same session grading its own work),
  plus a runnable check (tests, compilation, quoted sources).
- Progress tracked in external files (progress file + feature list + git
  commits), one feature per session, smoke test before coding.

Two corrections to the Omega Pack v2 in `omega/`:

1. Anthropic's own multi-agent evidence says the orchestrator should be
   the **strongest** model (Opus lead + Sonnet subagents: +90.2% over a
   single Opus on their internal eval) — not Sonnet-boss. Omega v2 uses
   Sonnet as boss; this is the one routing choice the labs' evidence
   disagrees with.
2. Multi-agent fan-out costs ~15x the tokens of a single agent. Use it
   only where tasks genuinely parallelise; most coding tasks do not.

Meta has almost nothing public for solo developers (Muse Code guidance is
thin; their REA system is internal-only). OpenAI's Codex guidance is a
6-stage ladder: prompt → AGENTS.md → config → MCP → skills → scheduled
automation. Google's EGM (below) is the plan-first piece.

Full sourced comparison: the page "What the Big Labs Recommend" (built
Nov 7, 2026); research notes in Muse's workspace under
`research_notes/big-lab-ai-coding-research-20261107-1718/`.

## Tools — verdict table

| Tool | What it is | Verdict | Install / link |
|---|---|---|---|
| EGM — Elephant-Goldfish Model (Google) | Plugin: deep-context Elephant drafts a spec (no code), zero-context Goldfish reviewers tear it apart, human approves, then build | Real. google/elephant-goldfish-model, Apache 2.0, announced Oct 22, 2026. "Thousands of Googlers use it daily" is Google's own claim, unverified. No published benchmark on bug reduction | `claude plugin marketplace add google/elephant-goldfish-model` then `claude plugin install egm@egm`. Commands: /egm:egm-brainstorm, /egm:egm-draft, /egm:egm-review |
| Context Mode (mksglu/context-mode) | MCP server: sandboxes tool output out of context, session continuity via local SQLite + full-text search | Real, big: 20k+ stars, #1 on Hacker News Feb 2026 (570+ pts). Own benchmark 315 KB → 5.4 KB (98%); without hooks ~60%. License switched MIT → Elastic License 2.0. Open Windows hang bug; can fight Claude Code auto mode | `/plugin marketplace add mksglu/context-mode` or `claude mcp add context-mode -- npx -y context-mode` |
| agent-browser (Vercel Labs) | Rust CLI: drive a browser by accessibility-tree snapshot, elements as short refs (@e1, @e2) | Real, ~46k stars, Apache 2.0, v0.41.2 (Nov 3, 2026). Young, pre-1.0, hundreds of open issues, weak against Cloudflare sites, security controls off by default | Homebrew or npm; also ships MCP server (`agent-browser mcp`) and Claude plugin |
| Playwright MCP (Microsoft) | Official browser MCP: open pages, click, fill forms, test | Real, official. The established alternative to agent-browser; heavier (Node), more mature | MCP server `@playwright/mcp` |
| Firecrawl | Managed web scraper, prompt → data | Real. Best managed scraper in Nov 3 comparisons (~$16/mo for 5k pages); plain-English → typed JSON costs more per page | firecrawl.dev |
| Perplexity MCP | Live web research inside Claude | Real. Duplicates what Muse already does for Andro | MCP server |
| Composio | One connector for many apps (Gmail, Slack, etc.) | Real integration platform | composio.dev |
| PostHog | Product analytics Claude can read | Real. Skip unless komoelectrical.ca gets real traffic | posthog.com |
| TREG (superdesigndev/treg) | "OpenRouter for agent tools": one token → ~3,000+ paid API endpoints (SEO, social, enrichment, scraping, ads), pay per call from a cent | Real, ~7.5k stars, AGPL, self-hostable, live at treg.to. Own pages disagree on the count (3,200 vs 3,700 vs 3,338 endpoints). Not free: prepaid balance, $1 to start, 0% markup | `/plugin marketplace add superdesigndev/treg` |
| Harness² (Google Research) | Recursive agent framework: rewrites the harness (prompts, tools, memory, skills) around a frozen model, Propose → Probe → Compose | Real: google-research/harness2, Apache 2.0, paper arXiv:2610.14224, Oct 2026. Gains up to +11.5 pts on their own benchmarks, unreplicated. Plugs into OpenCode and Codex only — NOT Claude Code directly. Its editor agent is Claude Opus 4.8 by default. Needs Linux, Docker, Google Cloud/Vertex AI; expensive per recursion level | Steal the loop, don't install it: run task → subagents propose edits to skills/CLAUDE.md → rerun → keep what helps |
| Base (charlieautomates) | Knowledge-graph replacement for static CLAUDE.md: rules fire on keywords | Real but small: matching repo github.com/ChristopherKahler/base, 356 stars, Rust, source-available (FSL 1.1). 90% consistency / 70x token claims are creator marketing, no independent test. No lab endorses a knowledge-graph rule store as default | Skip as default; Anthropic's answer is short CLAUDE.md + scoped rules + skills |
| ECC — Everything Claude Code (affaan-m/ECC) | 286 skills, 68 subagents, 94 commands, 122 rules, 23 hooks for Claude Code | Real, MIT, ~250k stars. Full install parks ~27,000 tokens of standing context (14% of a 200k window) before you type. "Won the Anthropic Hackathon" claim unverified. Raid it, don't install whole | Take AgentShield (security scanner for agent configs, `npx ecc-agentshield scan --path .`), the settings block, the instinct system, three context-accounting skills, the selective installer. Leave the other 285 skills |
| Rune (anomalyco/rune) | Native GPU-rendered Rust UI framework, own renderer/text/layout/springs, macOS/Windows/Linux/web | Real, ~3.2k stars, MIT. Every app runs headless: agent renders to PNG, dumps element tree, drives with scripted input. Pre-release: pin a dev revision, takes no pull requests, side projects only, don't ship on it | github.com/anomalyco/rune |
| 9Drive (zenhosta/9drive) | Self-hosted web app pooling multiple Google Drive accounts into one dashboard | Real, ~2,900 stars. Auto-picks the drive with most free space per upload; also S3-compatible backends. Needs Node.js, MySQL/SQLite, own Google Cloud project. Does NOT create storage — only aggregates accounts you already have | Only useful if Andro has (or makes) a second Google account. Relevant because Google One was cancelled Nov 6 and ends Nov 13, 2026, leaving him at 98% of the 15 GB free tier |
| Underdog Woof | Tiny TTS model: one voice 31.7 MB (30.7M params), two voices 40.6 MB, runs in browser offline, up to 18x real time on one CPU thread | Real, released Nov 6, 2026 (underdog.ai/woof). Own benchmark: two-voice 1.42% word error rate on hard sentences vs 1.89% for Fish Audio Drama 3 (41.5 GB) — 25% fewer errors at ~1,022x smaller. No independent test; measures error rate, not voice quality. License CC BY-NC 4.0: non-commercial only | Runs fine on Andro's GTX 1050 / 16 GB PC (402 MB peak memory). Fun local model, not a business tool |

## Quant research (Part 2 reel, @chrispathway)

"Quant projects that aren't stock price prediction, Part 2" — three papers:

1. **Deep hedging** — "No-Transaction Band Network" (Imaki et al., 2021,
   arXiv:2103.01775). Network outputs a no-transaction band instead of a
   hedge position; faster training, better hedges for European and lookback
   options. Ties to QuantFinanceToGo Part 33 (delta hedging).
2. **RL market maker** — "Model-based gym environments for limit order
   book trading". Title as stated in the reel; not independently verified
   by name.
3. **GPU execution** — JAX-LOB (Frey et al., ACM ICAIF 2023,
   arXiv:2308.13289). First GPU limit-order-book simulator, thousands of
   books in parallel, ~7x faster RL training than CPU sims (550 vs 74
   steps/sec). Open source, used in AlphaTrade.

Fit for Andro: research projects, not trading strategies. Deep hedging is
options work, market-making is a different game from directional MNQ
breakout, JAX-LOB is infrastructure for training execution agents.
Interesting if he ever builds; not something to trade off.

## Priority for Andro (what to actually do)

1. **Do now:** Context Mode (context tax is the Omega Pack's biggest
   cost), EGM plugin (plan-first + fresh-context verifier), agent-browser
   or Playwright MCP (local browser for Claude — the Jev Ultrafast job),
   AgentShield from ECC (one scan of the Omega setup).
2. **Try next:** TREG for paid endpoints, Firecrawl for scraping.
3. **File and watch:** Rune, Harness² loop, 9Drive (only if Google One
   stays cancelled), Woof (local TTS toy).
4. **Skip:** Base as default, PostHog, full ECC install, Harness² as a
   direct install.

Engineered prompts for the "Do now" items are in
`prompts/2026-11-07-agent-tooling.md` — each with role, goal, delimited
context, exact output format, testable definition of done, and a
verification loop (max 3 rounds, independent verifier, report what still
fails). Do not treat any prompt as approved until Andro judges it.
