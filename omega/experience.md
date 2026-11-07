# experience.md — per-job experience log (template)

One entry per finished job. Newest first. Keep at most 20 entries: when the
21st is added, summarise the oldest into `MEMORY.md` as a tested rule (with
its evidence) or drop it. Memory holds tested rules; this file holds
per-job lessons with evidence. An untested idea is labelled untested.

Entry format (copy this block, fill every field, no blanks):

## YYYY-MM-DD — [job, one line]
- **What broke:** [the weakness or failure, concrete]
- **What fixed it:** [the change, or "not fixed"]
- **Evidence:** [command + output, file + line, or verifier result]
- **Trap to avoid next time:** [one line, or "none"]

---

## 2026-11-07 — Add the experience-log files to the Omega Pack (setup job, not a full orchestrator run)
- **What broke:** The prompt asked for a step in `omega/OMEGA_ORCHESTRATOR.md`, but this job's file allow-list excluded that file, so the step could not be added.
- **What fixed it:** Not fixed. The read-last-five / write-one / cap-at-20 procedure is written in `.claude/skills/memory/SKILL.md` instead. The orchestrator step still needs adding by someone allowed to edit that file.
- **Evidence:** Allow-list in the job instructions named only `omega/MEMORY.md`, `omega/.claude/skills/memory/SKILL.md` and new files. `git status` is the check that no other omega file changed.
- **Trap to avoid next time:** Check the edit allow-list against the prompt's file list before starting. The orchestrator did not run this log end to end (untested).
