# MEMORY.md — template (keep the top short)

This is the top layer of the project's memory. Claude Code loads only
the first 200 lines / 25KB of this file into every session, so this
section is an index, not the archive. Detail lives in linked files
below it. See `.claude/skills/memory/SKILL.md` for the rules.

## Current goal

- [ONE LINE: what this project is doing right now]

## Next steps

- [ ] [Next step, checkable]
- [ ] [Next step, checkable]

## Tested rules

- [Rule] — verified by [test command / file + line]. Trap it avoids: [one line]
- [Add only rules a future session could not re-derive cheaply. Label untested guesses as untested.]

## Traps

- [Trap found, with evidence — what went wrong and what to do instead]

## Index

- [Link to detail files, e.g. `docs/architecture.md`, `notes/decisions.md`]
- `experience.md` — per-job log (what broke, fix, evidence); newest 20 entries. Procedure in `.claude/skills/memory/SKILL.md`.
