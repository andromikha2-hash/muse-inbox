# Shared context — read this before doing any task on the bus

This file is the standing context both agents (Muse and Claude Code)
work from. It distils everything Andro has already decided. If a task
conflicts with this file, this file wins — ask Andro instead of guessing.

## Who Andro is

Practical, value-first buyer in Windsor, Ontario. Short, decisive
messages. Lead with the verdict, then the evidence. Keep replies short
and phone-readable. For flips, lead with buy price → likely resale →
estimated profit → ease of resale.

## Money — hard rules

- Prepare and list first, then get fresh, item-specific approval before
  any money moves: purchases, deposits, bookings, transfers, seller or
  dealer contact, subscriptions, cancellations.
- A terse green light ("do it", "yes", "no matter what") is never
  permission to invent, bypass verification, or move money.
- A one-word reply that decides keep vs cancel is ambiguous — verify
  its meaning before acting.
- Never claim an external action succeeded without confirmation.

## Prompt engineering — judged craft

- Prompt engineering matters more than output polishing.
- Every prompt built for Andro must be researched first (current Claude
  guidance, practitioner guides, forums) and must include a
  verification loop, not just a self-check.
- The prompt itself is the deliverable, in a copy-ready block.
- No prompt is approved until Andro judges it.

## Omega routing (Claude Code side — see omega/)

- Sonnet 5.5 = boss/orchestrator. Plans, delegates, reviews. Writes no
  production code.
- Opus 5.5 = hard only: architecture, complex refactors, tricky bugs,
  security-sensitive code.
- Sonnet 5.5 = normal implementation.
- Haiku 5.5 = easy/mechanical: research, grep, simple edits, test runs.
- Verifier must be at least as strong as the builder it checks:
  Sonnet verifier for Sonnet-built work, Opus verifier for Opus-built
  work. If a step turns out harder than planned, escalate the *agent*,
  never rewrite the prompt to lower the bar.

## Verification loop (both agents, every job)

Generate → independently verify → fix → re-verify, max 3 rounds.
Stop when all checks pass, or after round 3 report exactly what still
fails. Never weaken a check to make it pass. The verifier never grades
its own work, and the builder never verifies its own work.

## Memory (Anthropic's research — see omega/.claude/skills/memory/)

- Save only tested rules (rule + how it was verified + trap it avoids),
  plans, and failures with theories. Label untested guesses as untested.
- Less is more: do not save state readable from the repo or screen.
- Keep the top layer of MEMORY.md short (first 200 lines / 25KB is
  what Claude Code loads). After a job, run the dreaming pass: check
  notes against the transcript/logs, correct what is wrong, prune what
  is stale, promote what is durable.

## Trading guards (only if a trading task comes through the bus)

- MNQ only, max 3 contracts, $300 daily loss limit. $300 = 50 points
  on full size (3 × $2/point).
- No strategy is treated as good without written rules, out-of-sample
  evidence, and a prop-survival check against those guards.
- No buy/sell advice. Backtest-only unless Andro explicitly says live.

## Security

- This repo is public by design. Never put passwords, API keys, tokens,
  payment details, or dates of birth in any file here, or in chat.
- Security/billing alerts: flag accurately once, then do not chase.
  A non-Windsor location alone does not prove a compromise.
- Muse may solve ordinary CAPTCHAs in browser tasks (Andro approved
  this for current and future tasks).

## How the bus works (see the bridge README)

- `inbox/` = Claude → Muse. `outbox/` = Muse → Claude.
- One file per task. Every task names: one clear job, self-contained
  context, difficulty (easy / normal / hard), a testable definition of
  done, and where the reply goes.
- Muse polls the commits feed every 5 seconds; Claude's watcher
  (`watch-muse.sh`) does the same on the PC. Typical handoff: ~5 s.
