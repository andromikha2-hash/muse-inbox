---
name: memory
description: Memory rules from Anthropic's research — what to save, what not to save, and the dreaming pass that corrects memory.
---

# Memory

Source: Anthropic, "The components of agent memory", published Nov 6, 2026:
https://www.anthropic.com/research/components-of-agent-memory

Memory is knowledge Claude gains from experience and retains between
sessions, saved as context it can read later. It is not weight changes,
not in-conversation learning, and not compaction.

## What to save

Save only what a future session would need and could not re-derive
cheaply from the repo:

- Tested rules, with how you know they are true.
- Plans and current goals, in one place.
- Failures, plus the theory of what went wrong and the test that
  confirmed it — this is how a learning loop closes.
- Traps discovered along the way, with the evidence.

A memory entry is: the rule + how it was verified + what trap it avoids.
An untested guess is labelled untested, never written as a fact.

## What NOT to save

- State that can be read off the screen or the repo on the next turn
  (current file contents, where the player is on the map, how much
  money is in the account).
- Everything, just in case. In Anthropic's Pokémon Red test, Sonnet 3.7
  wrote 413 memory files across 225 folders and earned 1 badge; Fable 5
  wrote 9 files + one `global.md` dashboard and earned 4 badges. A
  detailed record goes stale and costs time to comb through.

## How to steer it

Tell Claude what memory is for, not a fixed rule for how to use it.
Fixed rules like "record only failures" hurt the stronger models in
Anthropic's tests. For stronger models, freedom to judge salience beats
a preset rule. Older/weaker models benefit most from explicit steering:
prompt them to read memory before answering, and to test their theories.

## The dreaming pass (after a job, before the next session)

Dreaming is offline reflection: replay the session transcript/logs and
use that idle compute to organise memory. Run it after verification,
not during the build:

1. **Check** each new note against the transcript/logs. A note that was
   wrong from the start, or that drifted as the code changed, will be
   trusted by a later session — catch it here.
2. **Correct** what is wrong, quoting the transcript/log evidence.
   (In the Pokémon test, dreaming caught a wrong PokéCenter location
   and the agent then reached Cerulean City; the uncorrected run never
   got there.)
3. **Prune** what is stale, duplicated, or no longer relevant.
4. **Promote** what is durable to the top layer of `MEMORY.md`, and
   push detail down, leaving links behind.
5. **Fill gaps**: fix links to missing pages, add an index if one is
   needed, merge duplicates.

## Keep the top layer small

Claude Code loads only the first 200 lines / 25KB of `MEMORY.md` into
every session. That header is an index: current goal, next steps, and
where to find the detail. If it grows past that, dreaming's job is to
shrink it — move detail down the hierarchy, keep links.

## When a wiki helps (and when it doesn't)

A linked wiki/index helps when a question needs information across many
documents, or judgment/math across sources — in one test, wiki + search
scored 87% vs 73% for search alone. It does not help when the answer is
retrievable from a single document by text search. And a wiki can grow
larger than the documents themselves, abstracting nothing — prune it
when it does.

## Experience log (`omega/experience.md`)

Per-job lessons with evidence live in `experience.md`, not in `MEMORY.md`.
Memory holds tested rules; the log holds what broke, what fixed it, and
the evidence. Procedure (untested end to end; see the log's first entry):

1. Before a job, read the last five entries in `experience.md` for traps.
2. After the verification loop, the boss writes one entry using the
   template in that file (job, what broke, what fixed it, evidence, date).
3. Cap at 20 entries. Summarise older entries into `MEMORY.md` as tested
   rules, or drop them. Never push `MEMORY.md` past 200 lines / 25KB.

This idea is borrowed from Harness² (arXiv:2610.14224, gains unreplicated
[UNVERIFIED]). Harness² itself is not installed and does not run on Claude Code.
