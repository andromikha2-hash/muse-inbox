# Test EGM + fresh-context verifier on one real job: install REA in Claude Code

Sent 2026-11-12 by Andro's instruction ("send all"): run this test FIRST, then run
Prompt 2 (Context Mode install + measured savings) from
prompts/2026-11-07-agent-tooling.md after reporting back. One job at a time,
in order — do not run both in parallel.

## Task for Claude

Test the EGM plugin and the fresh-context verifier on ONE real job. The job:
install REA (Reverse Engineer Anything, morluto/rea) in Claude Code on Andro's
Windows PC, and prove it works on a target that needs no extra engine.

## Steps

1. EGM design-first (Omega step 1a): run the EGM slash commands on the install
   plan BEFORE changing anything — /egm:egm-brainstorm, /egm:egm-draft,
   /egm:egm-review — and keep the reviewed plan as the plan you execute.
2. Pre-check, stop if it fails: `node -v` must be 22.23.4+ on the 22.x line,
   24.22.1+ on 24.x, or 26.12.1+ (live README floor, re-checked 2026-11-09;
   the older 22.19+/24.11+ floor no longer applies). If Node is missing or on
   an unsupported line (23, 25, prerelease), STOP and report that instead of
   forcing the install.
3. Dry run first: `npx rea-agents setup --client claude_code --dry-run`,
   show what it would change, then run the real setup. Setup registers
   `mcpServers.rea` in ~/.claude.json and installs the
   `reverse-engineer-anything` skill in ~/.claude/skills. It keeps backups
   of existing config — verify the backup exists.
4. Scope limit for this job: JS/Electron or .NET targets ONLY. Those need no
   engine. Do NOT install Ghidra in this job — Windows Ghidra support is
   experimental, it needs JDK 21 + GHIDRA_INSTALL_DIR, and Hopper/IDA are
   paid. If the first target needs native decompilation, pick a different
   target and say so.
5. First test: point REA at one JS/Electron app or .NET assembly Andro owns
   (or a small open-source JS app if he names none) and have it explain one
   feature with evidence. Lawful use only, own software only.
6. Verification (fresh-context verifier, per the rule added in Prompt 1):
   an independent verifier pass in fresh context on the installed result —
   not just re-reading the files. Report what the verifier checked and what
   still fails, if anything.

## Report back in inbox/

What changed / Verification result / Memory written / What still fails.
Standing rules in context/ANDRO.md win on any conflict. Routing stays as-is
for this test (Sonnet boss) unless Andro says otherwise — this job does not
decide the Sonnet-vs-Opus question.

## After this test: Prompt 2

Once the report for this test is in inbox/, run Prompt 2 (Context Mode install
+ measured savings) from prompts/2026-11-07-agent-tooling.md, same report
format in inbox/. Prompts 3–6 stay on hold until Andro decides.

## Sources

- Reel analysis 2026-11-08: REA morluto/rea, 443,554 stars, MIT,
  `npx rea-agents setup`, Dylaan's pick, most-liked repo mention (20 likes).
  Re-verified 2026-11-09: 445,850 stars, 110,051 forks, MIT, latest npm
  release rea-agents 6.8.0 (Oct 25, 2026). Live README: analysis runs
  locally; static JS/.NET inspection needs no engine; Windows native
  Ghidra support is experimental.
- REA install docs (checked 2026-11-08 via web search, re-checked live
  README 2026-11-09): Node 22.23.4+/24.22.1+/26.12.1+ required; Ghidra
  12.1.x + JDK 21 for native, Windows support experimental; JS/Electron/.NET
  need no engine.
- Prompt 1 status 2026-11-08: EGM installed (egm@egm v0.1.1) but untested —
  slash commands never run, no verifier pass, nothing tested on a real job.
