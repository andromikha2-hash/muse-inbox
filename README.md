# muse-inbox — the Claude ↔ Muse bus, with the Omega setup built in

One repo, three jobs:

1. **The bus** — fast two-way handoffs between Claude Code (Andro's PC)
   and Muse (cloud). `inbox/` is Claude → Muse, `outbox/` is Muse →
   Claude. Muse polls the commits Atom feed every 5 seconds; Claude
   runs `watch-muse.sh` on the PC for the same. Typical handoff: ~5 s.
2. **The Omega setup** — `omega/` is the full Omega Pack v2 (Sonnet
   boss, Opus for hard, Sonnet for normal, Haiku for easy, verifier
   matched to builder, verification loop, memory skill from Anthropic's
   research). Any task that arrives on the bus and involves code is run
   through Omega routing by Claude. See `omega/README.md`.
3. **Shared context** — `context/ANDRO.md` is the standing rules both
   agents work from: money approval, prompt-engineering standard,
   verification loop, memory rules, trading guards, security. Read it
   before doing any task on the bus.

## Layout

```
muse-inbox/
├── README.md            — this file
├── context/
│   └── ANDRO.md         — standing rules for both agents
├── omega/               — Omega Pack v2 (copy into a project to use it)
│   ├── OMEGA_ORCHESTRATOR.md
│   ├── CLAUDE.md
│   ├── MEMORY.md
│   └── .claude/agents/ + .claude/skills/
├── inbox/               — tasks for Muse (one file per task)
│   └── README.md        — task format
├── outbox/              — replies from Muse (one file per reply)
│   └── README.md        — reply format
└── watch-muse.sh        — Claude-side watcher: prints Muse's replies
```

## Task format (inbox/<id>.md)

```markdown
# Task for Muse
From: Claude Code
To: Muse
Created: 2026-11-07 23:55 PT
Difficulty: normal
Task: [one clear sentence]
Context: [self-contained — Muse cannot see your local files unless
  you commit them here or paste them in]
Done means: [one testable check]
Reply to: outbox/<id>-reply.md
```

Replies (`outbox/<id>-reply.md`) use the same shape, with sections:
What changed / Verification result / What still fails / Memory written.

## Setup

Claude: paste `FOR_CLAUDE.md` (in the bridge folder, not this repo)
into Claude Code. It creates this repo, copies in `omega/` and
`context/`, and starts the watcher.

Muse: already watching. Hook `claude-inbox` polls every 5 s. Muse
pushing replies needs a fine-grained GitHub token (Contents
read/write, this repo only) via the secure flow; until then Muse
replies in the main chat.

## Security

Public repo by design, so Muse can poll it without a token. Never put
passwords, API keys, tokens, payment details, or dates of birth in any
file here. Muse asks Andro before any money movement, message, purchase,
booking, deletion, or seller contact.
