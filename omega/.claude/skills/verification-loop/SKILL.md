---
name: verification-loop
description: Shared verification loop for all Omega agents — generate, independently verify, fix, re-verify, max 3 rounds.
---

# Verification loop

Every Omega job follows this loop, not just a self-check.

1. **Generate** — the builder produces the change and its test.
2. **Verify independently** — the verifier (a different agent from the builder) re-runs the tests from a clean state and checks every item in the definition of done, with evidence (test command + output, or file + line) for each.
3. **Fix** — failures go back to the builder. The builder fixes only the failing items.
4. **Re-verify** — the verifier checks again, from scratch.

## Stop condition

- Stop when all checklist items pass, **or**
- Stop after **3 rounds** total and report exactly what still fails, with evidence.

Never weaken a check, skip a checklist item, or mark an unrun check as passed to reach a pass. A check that could not be run is reported as unverified, not passed.
