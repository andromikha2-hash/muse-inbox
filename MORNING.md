# Morning check — for Claude Code (read this first each morning)

You are Claude Code on Andro's PC. Every morning, before starting work,
read this repo in this order. It is the single place where everything
Muse has built and everything Andro has decided lives. You do not need
to talk to Muse — just read here.

## 1. Read the standing rules (2 minutes)

`context/ANDRO.md` — money approval, prompt standard, verification
loop, memory rules, trading guards, security. This wins over any task
if they clash.

## 2. Check for new tasks from Muse

`outbox/` — anything new since yesterday? Each file is one reply or
task from Muse, in the standard format (What changed / Verification
result / Memory written / What still fails). If a file says it needs
Andro, tell him — do not act on it yourself.

## 3. Check for anything Andro left for you

`inbox/` — tasks Andro or Muse left here. One file per task, with a
difficulty (easy / normal / hard) and a testable definition of done.

## 4. Use the Omega setup for code work

`omega/` — the Omega Pack v2. Copy it into a project as `.claude/` +
`CLAUDE.md` + `MEMORY.md` (see `omega/README.md`), then run jobs
through it: Sonnet 5.5 boss, Opus 5.5 hard only, Sonnet 5.5 normal,
Haiku 5.5 easy, verifier matched to the builder, verification loop
(max 3 rounds), memory pass after. The orchestrator prompt is
`omega/OMEGA_ORCHESTRATOR.md`.

## 5. New research and prompts (Nov 7, 2026)

`research/agent-tools-2026-11-07.md` — compact verdicts on every tool
Andro sent on Nov 7 (EGM, Context Mode, agent-browser, Playwright,
Firecrawl, TREG, Harness², Base, ECC, Rune, 9Drive, Underdog Woof,
quant papers), plus the big-lab consensus and the two corrections to
the Omega routing (Opus should lead; multi-agent costs ~15x tokens).
`research/quantfinancetogo.md` — the 42-part Quant Finance series.
`prompts/2026-11-07-agent-tooling.md` — six copy-ready engineered
prompts for the "do now" items (EGM + fresh-context verifier, Context
Mode, agent-browser test job, Harness² experience log, AgentShield
raid, TREG vs Firecrawl analysis). Each has a verification loop.
Run them one at a time, in order, and report back per prompt. Do not
treat any prompt as approved until Andro judges it.

## 6. Write back what you did

- Finished work: reply in `inbox/<task-id>-reply.md` with What changed
  / Verification result / Memory written / What still fails.
- Durable rules you learned: add them to `context/ANDRO.md` (tested
  rules only — rule + how it was verified + trap it avoids), and keep
  it short.
- Commit and push everything before you stop, so the morning after
  starts from the latest state.

## What "everything" means

This repo is the record: the Omega setup, the standing rules, the
bridge itself, and every task and reply that passes through it. If
something matters and it is not here, it does not exist yet — write
it here.
