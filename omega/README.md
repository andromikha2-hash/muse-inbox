# Claude Code — Omega setup v2 (ready to paste)

Rebuilt Nov 6, 2026 from your correction to v1. v1 had Opus 5.5 as the boss
and Haiku 5.5 doing all the building. v2 flips that: **Sonnet 5.5 orchestrates,
Opus 5.5 does only the hard work, Sonnet 5.5 does normal implementation,
Haiku 5.5 does easy/mechanical work.** It also adds Anthropic's memory
research ("The components of agent memory", published Nov 6, 2026:
https://www.anthropic.com/research/components-of-agent-memory).

Short answer from the original conversation, kept here: Muse cannot connect
to Claude Code — there is no Claude connector, and Muse is not Claude Code.
This pack is the build instead: copy it into a project and run it in
Claude Code.

## Why v2 is different

Opus as boss wastes the expensive model on coordination — reading summaries,
delegating, tracking steps. Haiku as builder fails on hard code, then you
pay for rework loops. Total cost is price x turns to get it *correct*, not
price per call.

One documented case of this exact fix: restructuring a pipeline from an
Opus orchestrator to a Sonnet orchestrator with an Opus writer and Haiku
searchers cut end-to-end token cost by roughly 60% and improved output.

## Routing (v2)

| Role | Model | When |
|---|---|---|
| Orchestrator / boss | Sonnet 5.5 | Plans, delegates, reviews. Writes no production code. |
| Researcher | Haiku 5.5 | Search, grep, summarise, find files/patterns. |
| Builder — normal | Sonnet 5.5 | Most implementation. |
| Builder — hard | Opus 5.5 | Architecture, complex refactors, tricky bugs, security-sensitive code. |
| Verifier — normal | Sonnet 5.5 | Re-runs tests, checks the definition of done. |
| Verifier — hard | Opus 5.5 | Verifies Opus-built work. A verifier must be at least as strong as the builder it checks. |
| Easy / mechanical | Haiku 5.5 | Simple edits, formatting, test runs, boilerplate. |

Rule: route by difficulty, not by habit. If a step is hard, escalate the
*agent*, not the prompt. Never rewrite a prompt to lower the bar.

## Prices (labelled, check before you trust them)

Per million tokens, input / output, from Anthropic's published rate card
as reported Oct 2026 (secondary sources; verify at claude.com/pricing):

- Haiku 5.5: $0.10 / $0.50 (prompts up to 100K tokens; $0.50 / $2.50 above that)
- Sonnet 5.5: $2 / $10
- Opus 5.5: $4 / $20

So Sonnet is half the price of Opus, and Haiku is 40x cheaper than Opus
on input. The reel's "$4 vs $0.10" line was actually the Opus-vs-Haiku
*input* prices — true on that one number, misleading as a whole-job
saving, because output costs 5x input on every model and rework loops
dominate the bill.

## Install (2 minutes)

1. Copy the `.claude/` folder in this pack into the root of your project.
2. Copy `CLAUDE.md` into the project root (or merge it into your existing
   `CLAUDE.md`).
3. Copy `MEMORY.md` into the project root if the project has none yet —
   keep its top section short, it is the index, not the archive.
4. In Claude Code, paste the orchestrator prompt from
   `OMEGA_ORCHESTRATOR.md`, filling in the `[PLACEHOLDERS]`.
5. Run one small job first (e.g. a single function + its test) before a
   big job, so you can judge the routing on your machine.

## What's in here

- `OMEGA_ORCHESTRATOR.md` — the copy-ready Sonnet planner prompt, built
  to your prompt standard: role, goal, delimited context, exact output
  format, constraints, testable definition of done, difficulty routing,
  memory read/write, and a verification loop (generate → independently
  verify → fix → re-verify, max 3 rounds, report what still fails rather
  than weakening a check).
- `.claude/agents/researcher.md` — Haiku: research only, no code changes.
- `.claude/agents/builder.md` — Sonnet: normal implementation only.
- `.claude/agents/builder-opus.md` — Opus: hard implementation only.
- `.claude/agents/verifier.md` — Sonnet: independent verification, fixes nothing.
- `.claude/agents/verifier-opus.md` — Opus: verification for Opus-built work.
- `.claude/skills/verification-loop/SKILL.md` — the shared verification-loop rule.
- `.claude/skills/memory/SKILL.md` — the memory rules, from Anthropic's
  research: what to save, what not to save, and the dreaming pass.
- `CLAUDE.md` — project-level rules Claude Code reads automatically.
- `MEMORY.md` — template for the project's memory top layer (short index).

## Memory, from Anthropic's research

- **Less is more.** In Pokémon Red, Sonnet 3.7 wrote 413 memory files and
  earned 1 badge; Fable 5 wrote 9 files + one `global.md` and earned 4.
  Save tested rules, plans, failures + theories, and traps — not state
  that can be read off the screen/repo anyway.
- **Close the loop.** A memory entry is a rule + how you know it's true +
  what trap it avoids. Untested guesses are labelled untested.
- **Don't over-steer.** Tell Claude what memory is for, not a fixed rule
  like "record only failures" — that hurt the stronger models in testing.
- **Dreaming corrects.** After a job, check notes against the transcript/
  logs, fix what's wrong, prune what's stale, promote what's durable to
  the top layer. Keep the top layer small: Claude Code loads only the
  first 200 lines / 25KB of `MEMORY.md`.
- Full detail in `.claude/skills/memory/SKILL.md`.

## Honest caveats

- **Prices change.** Verify at claude.com/pricing before hard-coding
  anything. No price is hard-coded in the agent files.
- **Auto-compaction at 40–60% is the reel's claim, unverified here.**
- **Your GTX 1050 doesn't matter for this.** Claude Code runs through
  Anthropic's API in the cloud, not on your PC.
- **Nothing here bypasses authentication or safeguards.** All agents work
  only on the project you point them at, with your own authorised
  Claude Code access.

## Your call next

Judge the orchestrator prompt first — it's the deliverable, not a polished
answer. If it passes your standard, use it for a real small job; if it
doesn't, say what's wrong with it and I'll research the gap instead of
guessing a new structure.
