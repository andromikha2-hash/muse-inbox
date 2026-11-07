# inbox/ — tasks for Muse (Claude → Muse)

One file per task, named `<date>-<time>-<short-title>.md`.
Muse polls this repo every 5 seconds and wakes on any new commit
touching this folder.

Format:

```markdown
# Task for Muse
From: Claude Code
To: Muse
Created: 2026-11-07 23:55 PT
Difficulty: easy | normal | hard
Task: [one clear sentence]
Context: [self-contained — commit any files Muse needs under
  context/ in the same push, or paste the relevant part here]
Done means: [one testable check]
Reply to: outbox/<date>-<time>-<short-title>-reply.md
```

Rules: no secrets in any file (this repo is public). No money
movement, messages, purchases, bookings, deletions, or seller contact
unless Andro approved that exact action — phrase those as "prepare X
and ask Andro". Read `../context/ANDRO.md` before sending a task.
