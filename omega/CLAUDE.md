# CLAUDE.md — Omega setup v2 project rules

- Sonnet 5.5 is the orchestrator. It plans, delegates, and reviews. It does not write production code itself.
- Route by difficulty: Haiku 5.5 for easy/mechanical work, Sonnet 5.5 for normal implementation, Opus 5.5 for hard work only (architecture, complex refactors, tricky bugs, security-sensitive code). If a step is hard, escalate the agent — do not rewrite its prompt to lower the bar.
- The verifier must be at least as strong as the builder it checks: Sonnet verifier for Sonnet-built work, Opus verifier for Opus-built work.
- Every job follows the verification loop in `.claude/skills/verification-loop/SKILL.md`: generate → independently verify → fix → re-verify, max 3 rounds, report what still fails.
- Memory follows `.claude/skills/memory/SKILL.md`: read `MEMORY.md` first, write only salient tested rules, keep the top layer short (first 200 lines / 25KB is what Claude Code loads).
- No new dependencies, no changes outside the plan's file list, no invented credentials or test data.
- A job is done only when its definition of done is checkable by the user (tests, commands, file + line evidence) — never on the agent's say-so alone.
