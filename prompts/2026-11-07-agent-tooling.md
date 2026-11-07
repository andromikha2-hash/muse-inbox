# Engineered prompts — agent tooling, Nov 7, 2026

How to use this file: each prompt is a copy-ready block for Claude Code.
Paste one at a time. Do not treat any prompt as approved until Andro
judges it. Every prompt ends with a verification loop (max 3 rounds,
independent verifier, report what still fails rather than weakening a
check). Context for all prompts: `research/agent-tools-2026-11-07.md`
in this repo, plus `omega/` (Omega Pack v2) and `context/ANDRO.md`
(standing rules). Unverified claims are labelled [UNVERIFIED] in the
context blocks.

---

## Prompt 1 — Add the Elephant-Goldfish plugin and a fresh-context verifier to the Omega Pack

```
You are a senior Claude Code setup engineer writing for Andro, a solo
developer who runs Claude Code with the Omega Pack v2 (Sonnet boss,
Opus for hard code, Sonnet for normal code, Haiku for easy work,
verifier matched to the builder, verification loop max 3 rounds).

<goal>
Add Google's Elephant-Goldfish Model (EGM) plugin to the Omega Pack so
plan-first work runs through it, and add a fresh-context verifier step
to the orchestrator.
</goal>

<context>
- EGM repo: github.com/google/elephant-goldfish-model, Apache 2.0,
  announced Oct 22, 2026. Elephant (deep context) drafts a spec and
  writes no code; Goldfish (zero-context reviewers) tear the spec apart;
  the human approves; then code is built to the spec.
- Install: `claude plugin marketplace add google/elephant-goldfish-model`
  then `claude plugin install egm@egm`. Commands: /egm:egm-brainstorm,
  /egm:egm-draft, /egm:egm-review.
- Claim "thousands of Googlers use it every day" is Google's own
  marketing [UNVERIFIED]. No published benchmark proves how much it
  reduces bugs [UNVERIFIED].
- Anthropic's own multi-agent evidence says the orchestrator should be
  the strongest model (Opus lead + Sonnet subagents, +90.2% over a
  single Opus on their internal eval, ~15x tokens). The Omega Pack
  currently uses Sonnet as boss. Do NOT change the routing in this
  prompt — flag the disagreement in your output instead.
- The Omega Pack lives in omega/ in this repo: README.md,
  OMEGA_ORCHESTRATOR.md, CLAUDE.md, MEMORY.md, .claude/agents/,
  .claude/skills/.
</context>

<instructions>
1. Install the EGM plugin in Claude Code and confirm it loads.
2. Edit omega/OMEGA_ORCHESTRATOR.md: for any job needing design
   decisions before implementation, route through EGM first
   (brainstorm → draft → review → human approval) before any builder
   starts. Small clear bug fixes skip EGM and use the normal workflow.
3. Add a fresh-context verifier step: the verifier runs in a fresh
   subagent with only the spec, the changed files, and read-only tools
   (Read, Grep, Glob), never the build conversation. It must run the
   runnable check (tests or compilation) itself and quote the evidence.
4. Keep CLAUDE.md under 200 lines. Do not add a knowledge-graph rule
   store.
</instructions>

<constraints>
- Do not change model routing (Sonnet boss stays). Do not install the
  full ECC pack. Do not weaken any existing verification rule to make
  a check pass. Nothing is paid for or installed outside Claude Code
  without Andro approving it first.
</constraints>

<output_format>
1. What changed (file + section, one line each).
2. Verification result (EGM commands run, verifier output quoted).
3. Memory written (tested rules added to omega/MEMORY.md).
4. What still fails (exact list, or "none").
5. One paragraph: the Opus-lead vs Sonnet-boss disagreement, in plain
   words, so Andro can decide it later.
</output_format>

<done>
EGM installs and its three commands run; the orchestrator routes
design work through EGM and small fixes around it; the verifier step
is a fresh subagent with read-only tools that runs the check itself;
CLAUDE.md stays under 200 lines.
</done>

<verification_loop>
After building, run an independent verifier pass (a different agent
than the builder) against the <done> checklist above, using the
runnable checks, not opinion. Fix every failure, then re-verify. Max
3 rounds. Stop when all checks pass, or stop after 3 rounds and report
exactly what still fails. Do not weaken a check to make it pass.
</verification_loop>
```

---

## Prompt 2 — Install Context Mode and verify the context savings

```
You are a Claude Code performance engineer writing for Andro, a solo
developer whose sessions compact too fast because tool output floods
the context window.

<goal>
Install Context Mode in Claude Code and prove, with measured numbers,
how much context it actually saves on a real job.
</goal>

<context>
- Repo: github.com/mksglu/context-mode, by Mert Köseoğlu. MCP server
  + hooks. Tool calls run in a sandboxed subprocess; raw output never
  enters context, only a summary. Session events (edits, git ops,
  tasks, errors, decisions) are logged to local SQLite and retrieved
  by full-text search after compaction.
- Project's own benchmark: 315 KB → 5.4 KB (98% reduction); without
  hooks ~60% [UNVERIFIED — project numbers, measures bytes kept out,
  not task quality].
- 20k+ stars, #1 on Hacker News Feb 2026 (570+ pts). License switched
  MIT → Elastic License 2.0 (source-available). Known issues: open
  Windows hang bug, can fight Claude Code auto mode.
- Install: `/plugin marketplace add mksglu/context-mode`, or
  `claude mcp add context-mode -- npx -y context-mode`.
- Andro's PC: Windows, GTX 1050, 16 GB RAM. The Windows hang bug
  matters here — test for it explicitly.
</context>

<instructions>
1. Install Context Mode in Claude Code.
2. Run one realistic job twice on the same task (a small research +
   code job): once without Context Mode, once with it. Record context
   used at each step from the stats command (`/context-mode:ctx-stats`
   or equivalent).
3. Test the Windows hang explicitly: run a long session and report
   whether it hangs.
4. Record the measured savings in a short note in the project, and add
   a one-line install note to the Omega Pack README if the savings hold.
</instructions>

<constraints>
- Do not claim the project's 98% figure as your own result — report
  only what you measured. Do not change any Omega Pack routing. No
  telemetry leaves the machine (Context Mode has none — verify that
  claim by reading its code, don't repeat it blindly).
</constraints>

<output_format>
1. Install result (commands run, errors if any).
2. Measured table: | Job | Context without | Context with |
   Savings |, using the stats command output.
3. Windows hang test: pass / fail, with what happened.
4. What still fails (exact list, or "none").
</output_format>

<done>
Context Mode is installed; the same job measured with and without it
shows a real saving (or an honest "no saving" if that is what the
numbers say); the Windows hang test has a pass/fail answer; the note
is written.
</done>

<verification_loop>
A different agent than the builder re-runs the measurement once from
the stats output and checks it against the <done> list. Fix failures,
re-verify, max 3 rounds. Stop when all checks pass, or after 3 rounds
report exactly what still fails. Do not weaken a check to make it pass.
</verification_loop>
```

---

## Prompt 3 — Local browser automation: agent-browser + the Jev test job

```
You are a browser-automation engineer writing for Andro, a solo
developer who wants Claude Code on his PC to drive a real browser,
because Muse in the cloud cannot.

<goal>
Set up agent-browser on this PC, then run one real web job with it
and report exactly what worked and what did not.
</goal>

<context>
- agent-browser: github.com/vercel-labs/agent-browser, Rust CLI,
  Apache 2.0, ~46k stars, v0.41.2 (Nov 3, 2026). Opens a page, reads
  it as an accessibility-tree snapshot with short refs (@e1, @e2),
  acts on refs, repeats. Snapshot ~200–400 tokens vs 3,000–5,000 for
  a full DOM dump. Install via Homebrew or npm; also ships an MCP
  server (`agent-browser mcp`) and a Claude plugin.
- Caveats [UNVERIFIED in Andro's environment, reported by reviewers]:
  very young, pre-1.0, hundreds of open issues, weak against
  Cloudflare-protected sites, security controls off by default.
- Alternative: Playwright MCP (Microsoft, official, heavier, more
  mature). Jev Ultrafast (browser-use/jev-ultrafast) is a full agent
  that picks its own actions; agent-browser is the tool such an agent
  drives. Do not install Jev in this prompt.
- Andro's PC: Windows. Test on Windows explicitly.
</context>

<instructions>
1. Install agent-browser on this PC and confirm `agent-browser open`
   and `agent-browser snapshot` work.
2. Run the test job: search Google Flights for a Toronto → Cancun
   flight, Dec 28, 2026, 8 adults, and report the cheapest option
   found, with the price and where it came from.
3. Then try one Cloudflare-protected site and report whether it
   worked or failed, exactly as observed.
4. Write the result as a short note: what worked, what failed, and
   whether agent-browser or Playwright MCP is the better next step.
</instructions>

<constraints>
- Never put API keys or logins in any file in this repo (it is public).
  Do not book or buy anything. Do not pay for anything. Report prices
  as observed, with the time checked.
</constraints>

<output_format>
1. Install result.
2. Test job result: cheapest flight, price, source, time checked.
3. Cloudflare test: pass / fail, exactly what happened.
4. Recommendation: agent-browser or Playwright MCP, in one sentence,
   with the reason.
5. What still fails (exact list, or "none").
</output_format>

<done>
agent-browser is installed and working on this PC; the Google Flights
test returned a real price from a real page; the Cloudflare test has
a pass/fail answer; the recommendation is written.
</done>

<verification_loop>
A different agent than the builder re-checks the flight price against
the live page and the install commands against the repo README. Fix
failures, re-verify, max 3 rounds. Stop when all checks pass, or after
3 rounds report exactly what still fails. Do not weaken a check to make
it pass.
</verification_loop>
```

---

## Prompt 4 — Add a Harness²-style experience log to the Omega Pack

```
You are a Claude Code setup engineer writing for Andro, a solo
developer whose Omega Pack already has a memory skill and a
verification loop, and who wants the loop to learn from each job.

<goal>
Add a Harness²-style experience log to the Omega Pack: after each job,
record what broke, what fixed it, and the evidence — so the next job
starts smarter.
</goal>

<context>
- Harness² (Google Research + Northwestern, Oct 2026, paper
  arXiv:2610.14224) is a recursive agent framework that rewrites the
  harness (prompts, tools, memory, skills) around a frozen model in a
  Propose → Probe → Compose loop. After each task, an Experience
  Reflector writes an experience.md file recording the weakness, what
  fixed it, and the evidence. Its gains (up to +11.5 points on their
  own benchmarks) are unreplicated [UNVERIFIED].
- Harness² plugs into OpenCode and Codex only, NOT Claude Code. Do
  not install it. This prompt steals only the experience-log idea.
- The Omega Pack already has .claude/skills/memory/SKILL.md (Anthropic
  dreaming pass) and a verification loop skill. The experience log must
  fit those, not duplicate them: memory holds tested rules; the
  experience log holds per-job lessons with evidence.
- Anthropic's guidance: keep the injected top layer small; Claude Code
  loads only the first 200 lines / 25 KB of MEMORY.md as an index.
</context>

<instructions>
1. Add an `experience.md` template to the Omega Pack (one entry per
   job: job, what broke, what fixed it, evidence, date).
2. Add one step to omega/OMEGA_ORCHESTRATOR.md: after the verification
   loop, the boss writes one experience entry, and before starting a
   job the boss reads the last five entries for traps to avoid.
3. Cap the log: keep the newest 20 entries in the file; older entries
   are summarised into MEMORY.md as tested rules or dropped.
4. Test it on one small job end to end and show the entry it wrote.
</instructions>

<constraints>
- Do not grow MEMORY.md past its 200-line / 25 KB top-layer limit.
  Do not install Harness². Do not change model routing.
</constraints>

<output_format>
1. What changed (file + section, one line each).
2. The test job's experience entry, quoted in full.
3. Memory written.
4. What still fails (exact list, or "none").
</output_format>

<done>
The template exists; the orchestrator reads the last five entries
before a job and writes one after; the log caps at 20 entries; the
test job produced a real entry with evidence.
</done>

<verification_loop>
A different agent than the builder checks the template, the cap, and
the test entry against the <done> list. Fix failures, re-verify, max
3 rounds. Stop when all checks pass, or after 3 rounds report exactly
what still fails. Do not weaken a check to make it pass.
</verification_loop>
```

---

## Prompt 5 — Raid ECC: take AgentShield only, scan the Omega setup

```
You are a security reviewer writing for Andro, a solo developer who
wants the one useful piece out of the giant Everything Claude Code
pack, without paying its context cost.

<goal>
Extract AgentShield from ECC, run it once against the Omega Pack, and
report what it finds.
</goal>

<context>
- ECC (Everything Claude Code, affaan-m/ECC, MIT, ~250k stars): 68
  agents, 286 skills, 94 commands, 122 rules, 23 hooks. A full install
  parks ~27,000 tokens of standing context (14% of a 200k window)
  before you type — measured on v2.2.1, not by the repo itself.
  Recommendation: raid it, don't install it whole.
- AgentShield is ECC's security auditor for agent configurations. It
  ships inside ECC and as its own npm package `ecc-agentshield`.
  Run: `npx ecc-agentshield scan --path .`
- The Omega Pack lives in omega/ in this repo. Do not install ECC.
  Do not copy any other ECC skill or agent in this prompt.
</context>

<instructions>
1. Run AgentShield once against the Omega Pack directory.
2. For each finding, say whether it is real or a false positive, with
   the evidence (file + line).
3. Fix the real findings in the Omega Pack. Do not fix anything by
   weakening a security rule.
4. Write the result as a short note in the Omega Pack (findings,
   fixes, false positives).
</instructions>

<constraints>
- Do not install ECC. Do not copy ECC skills or agents. Do not weaken
  any security check to make it pass. Do not change model routing.
</constraints>

<output_format>
1. Scan result (findings, one line each, with file + line).
2. Real vs false positive, with evidence.
3. Fixes applied.
4. What still fails (exact list, or "none").
</output_format>

<done>
AgentShield ran once against the Omega Pack; every finding has a real
/ false-positive verdict with evidence; real findings are fixed; the
note is written.
</done>

<verification_loop>
A different agent than the builder re-runs the scan and checks the
verdicts against the <done> list. Fix failures, re-verify, max 3
rounds. Stop when all checks pass, or after 3 rounds report exactly
what still fails. Do not weaken a check to make it pass.
</verification_loop>
```

---

## Prompt 6 — Analysis: TREG vs Firecrawl for Andro's scraping need

```
You are a tooling analyst writing for Andro, a solo developer who
asked (Nov 3, 2026) which scraper actually works best for websites
and Reddit/X, and who now has two new candidates to compare.

<goal>
Decide, with numbers, whether TREG or Firecrawl is the better scraper
for Andro's actual use — and say what the use actually is.
</goal>

<context>
- TREG (superdesigndev/treg, AGPL, ~7.5k stars, live at treg.to):
  one token → ~3,000+ paid API endpoints (SEO, social, enrichment,
  scraping, ads), pay per call from a cent, prepaid balance, $1 to
  start, 0% markup. Its own pages disagree on the count (3,200 vs
  3,700 vs 3,338 endpoints) [UNVERIFIED — use the range, not one
  number].
- Firecrawl: managed scraper, ~$16/mo for 5k pages in Nov 2026
  comparisons; plain-English prompt → typed JSON costs more per page
  (~$0.02/page vs ~$0.004/page) [UNVERIFIED — secondary-source prices,
  re-check before any purchase].
- Andro's Nov 3 question was never narrowed: it is still unknown
  whether he wants specific subreddits, X search results, or
  product/competitor pages. Do not guess the use case — state what is
  still unknown and give the decision for each of the three uses.
- Reddit: PRAW + official API for coders; Apify Reddit Scraper for
  no-code. X: hardest; official API pay-per-use, Apify Tweet Scraper
  V2 ~$0.40/1,000 tweets, Bright Data ~$1.50/1,000 records. Scraping
  LinkedIn/Upwork/Instagram hits login walls and ToS bans.
</context>

<instructions>
1. For each of the three uses (subreddits, X search, product /
   competitor pages), price one realistic month of use under TREG and
   under Firecrawl, using current prices from their own sites.
2. Name the winner for each use, with the dollar difference.
3. State what is still unknown (which use Andro actually wants) and
   what one question would settle it.
</instructions>

<constraints>
- Do not present secondary-source prices as current — re-check both
  sites and quote the price you actually saw, with the date. Do not
  buy or sign up for anything. Do not recommend scraping that violates
  a site's ToS without saying so plainly.
</constraints>

<output_format>
1. Price table: | Use | TREG (1 month) | Firecrawl (1 month) |
   Winner |, with prices as actually seen and the date checked.
2. One sentence per use: why that one wins.
3. The one question that would settle which use Andro wants.
4. What still fails (exact list, or "none").
</output_format>

<done>
All three uses have a priced comparison from prices actually checked
today; each has a named winner with a dollar difference; the open
question is stated.
</done>

<verification_loop>
A different agent than the builder re-checks both prices against the
live sites and the table against the <done> list. Fix failures,
re-verify, max 3 rounds. Stop when all checks pass, or after 3 rounds
report exactly what still fails. Do not weaken a check to make it pass.
</verification_loop>
```
