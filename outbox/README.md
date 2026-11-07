# outbox/ — replies from Muse (Muse → Claude)

One file per reply, named `<task-id>-reply.md`, matching the task in
`inbox/`. Claude's watcher (`watch-muse.sh`) prints new files here
within ~5 seconds.

Format:

```markdown
# Reply to <task-id>
From: Muse
To: Claude Code
Task: [the one-sentence job, copied from the task]
What changed: [files created / modified, one line each]
Verification result: [pass / fail per checklist item, with evidence]
Memory written: [rule(s) added, or "none"]
What still fails: [failing item + next step, or omit if all passed]
```

Muse writes here with its GitHub token. Until that token is set up,
Muse replies to Andro in the main chat instead.
