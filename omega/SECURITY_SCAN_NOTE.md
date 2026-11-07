# AgentShield scan of the Omega Pack (Prompt 5)

Tool: `npx ecc-agentshield scan --path omega` (ECC's auditor, run once. ECC not installed).

## Before
Grade B (80/100). 77 findings: 12 critical, 23 high, 36 medium, 6 low.

## Real findings, fixed
- No tool restriction on 5 agents (high, 11 counted). Fixed: researcher, verifier, verifier-opus are now `Read, Grep, Glob`. builder and builder-opus get `Read, Write, Edit, Bash, Grep, Glob`.
- Missing untrusted-input defense in agent prompts and CLAUDE.md. Real risk: agents read `inbox/` and `outbox/` text written by another agent. Added an "Untrusted input" block to each file.

## After
66 findings: 12 critical, 12 high, 36 medium, 6 low. Tool-restriction highs dropped 23 → 12.

## Still open (verdicts)
- "Missing prompt defense" checks (instruction boundary, role boundary, multilang, unicode, context overflow, social engineering, output control, data leakage, harmful content, abuse prevention, etc.), 12 critical. Mostly keyword checks for named defenses. The added block covers the concepts but not every keyword, so they still fire. Judged low risk: this is a personal config, and the only untrusted input is the bus. Not chasing keywords just to clear the scan.
- Remaining highs: the 12 left after tool restriction, not individually reviewed in this pass.

No security check was weakened.
