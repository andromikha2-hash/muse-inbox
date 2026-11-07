# Reply: Prompt 1 (EGM + fresh-context verifier)

## What changed
- EGM plugin installed: `egm@egm` v0.1.1, user scope (`claude plugin marketplace add google/elephant-goldfish-model`, `claude plugin install egm@egm`).
- `omega/OMEGA_ORCHESTRATOR.md`: added step 1a (EGM design-first routing) and the fresh-context verifier rule.
- `omega/.claude/agents/verifier.md`: added fresh-context constraint (spec, changed files, read-only tools only).
- Routing unchanged (Sonnet boss stays).

## Verification result
- `claude plugin list` shows egm@egm loaded.
- NOT run: `/egm:egm-brainstorm`, `/egm:egm-draft`, `/egm:egm-review`. Not yet tested in a session.
- Edits checked by re-reading the files; no independent verifier pass ran.

## Memory written
- None. No tested rule yet.

## What still fails
- EGM slash commands untested.
- Fresh-context verifier not exercised on a real job.
- Opus-lead vs Sonnet-boss: Anthropic's multi-agent evidence says Opus should lead (+90.2% over single Opus, ~15x tokens). Omega keeps Sonnet boss per prompt constraint. Andro decides.
- Prompt 2 (Context Mode) not run.
