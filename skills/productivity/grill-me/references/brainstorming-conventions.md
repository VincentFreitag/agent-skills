# Brainstorming conventions

The output convention `grill-me` writes to. Bundled with the skill so it works in any repo.

> If the host repo already has its own `brainstorming/README.md`, **that one wins** — read it
> and follow it instead of this file.

## Where it lives

```
brainstorming/<YYYY-MM-DD>-<slug>/
```

- `<YYYY-MM-DD>` — the date the idea was started.
- `<slug>` — short kebab-case name (e.g. `taxonomy-onboarding-v2`).
- Collision on the same day for a *different* idea → append `-2`, `-3`. Same idea continuing →
  reuse the folder.

Example: `brainstorming/2026-08-11-pricing-model/`

This is committed to git and permanent — it is **not** disposable like a scratch dir. The
thinking has to survive the session.

## What's in a folder

No fixed checklist — gather whatever is relevant to the idea. Every folder has at least an
`idea.md` anchor note (problem, goals, constraints, current thinking). Beyond that it may hold
the plan, research notes, references, sketches, draft tool/workflow outlines, sample data, or
open questions.

## Lifecycle

Track `status:` in each `idea.md`:

- `draft` — just started, still forming.
- `active` — being worked on.
- `graduated` — turned into a real SOP, workflow doc, skill, or shipped implementation.
- `archived` — parked, kept for reference.

## Graduation

An idea graduates when it stops being a question and becomes a repeatable procedure. Where it
graduates *to* depends on the host repo — a `workflows/*.md` SOP, a new skill, an ADR, a
ticket. Always leave a graduation-path stub in `idea.md` even when the destination is unknown,
so the handoff is obvious to whoever picks it up later.
