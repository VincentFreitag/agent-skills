---
name: grill-me
description: Relentlessly interview the user about a plan, design, or topic AND co-author the brainstorming artifact as you go — asking one question at a time, proposing content, researching answers yourself, and checkpointing every exchange to disk so nothing is lost. Use when the user wants to stress-test a plan, get grilled on a design, run a brainstorm or discovery session, build out an idea doc, or says "grill me".
---

# Grill Me

Sit down with the user and **build a brainstorming artifact together** by interviewing them
relentlessly about every branch of the topic until you reach shared understanding. You are a
**co-author, not a stenographer**: you ask the hard questions one at a time, but you also
propose content, go read the code/docs to answer things yourself, bring in outside
information, and draft the artifact's structure and prose. The user confirms, corrects, and
redirects. Everything lands in a durable markdown file so nothing is lost as context fills up.

This is an interactive, portable *method* (built-in tools only). Its output is a first-class
**brainstorming** artifact and obeys that convention — folder naming, `idea.md` anchor,
lifecycle status, and graduation path. The rules live in
[`references/brainstorming-conventions.md`](references/brainstorming-conventions.md); read it
if you need them, this skill won't restate them.

> **Host-repo override.** If the repo you're working in has its own `brainstorming/README.md`,
> that one wins — read it instead and follow its conventions.

## The capture file is the whole point

Long interviews fill up context. If you hold answers only in your head, you will eventually
misremember, conflate, or drop something. So you **checkpoint to disk after every single
exchange**. The file, not your context, is the source of truth. Never make the user ask you
to save progress.

## Setup (do this BEFORE the first question)

1. **Derive a kebab-case `slug`** from the topic (e.g. `pricing-model`, `newsletter-automation`).
2. **Create the anchor file** at `brainstorming/<YYYY-MM-DD>-<slug>/idea.md` (folder naming,
   collision rule, and lifecycle are per
   [`references/brainstorming-conventions.md`](references/brainstorming-conventions.md)).
   Get today's date if you don't already know it — PowerShell `Get-Date -Format yyyy-MM-dd`,
   or Bash `date +%F`.
3. **Write the header immediately** (see structure below): title, date, goal, `status: active`,
   and empty Summary / Q&A log / Open flags / Graduation path sections.
4. **Tell the user where you're saving**, in one line. Then ask Q1.

## The checkpoint rule (non-negotiable)

After EVERY exchange, BEFORE you ask the next question:
- Append a structured entry to `idea.md`: the question topic, what got decided (the user's
  words where wording matters, plus whatever *you* contributed — proposals, findings from the
  code/docs, outside info), and any flags (open items + who owns them).
- Fold the decision into the running Summary; update or correct earlier entries if a later
  answer changes them.
- Only then ask the next question.

Never batch multiple exchanges into one write. Checkpoint one at a time. The point is that if
context is lost at any moment, the file already holds everything said so far.

## Interview + co-authoring method

- Ask **one question at a time**, and always lead with your **recommended answer** (your best
  inference from context, the code, or research) so the user can just confirm, correct, or
  redirect — not start from a blank page.
- **Don't only extract — contribute.** Propose structure, draft prose, suggest options the
  user hasn't considered, and pressure-test their reasoning. The artifact should end up richer
  than what was in the user's head alone.
- **Answer what you can yourself.** If a question is resolvable by exploring the codebase or
  reading a file/doc the user points you to, do that instead of asking. Read handed-over docs
  in full and surface only what's net-new.
- Resolve dependencies in order: settle the upstream decision before the ones that depend on it.
- When the user **can't answer** something, capture it as a flag with the right owner and move
  on. Don't stall.
- Keep going until the user says you're done, or you've walked every branch. Offer a
  completeness backstop near the end ("anything we haven't touched?").

## Capture file structure (`idea.md`)

```
# {Topic}: Brainstorm / Discovery Notes
Date: {YYYY-MM-DD} · Status: active · Goal: {one line}

## Summary / key decisions
(running synthesis, updated as you go)

## Q&A log
### Q1 — {topic}
- Asked: {question}
- Decided: {facts + decisions; user's words where they matter; what you contributed}
- Flags: {open item -> owner}
...

## Open flags (pending input)
- {item} -> {who can answer}

## Graduation path
(how this could become a real, repeatable SOP — a `workflows/<name>.md` doc, a skill, or
whatever the host repo uses — and which tooling it would need. Leave a stub even if unknown,
so the handoff is obvious later)
```

`status:` tracks the brainstorming lifecycle (`draft` → `active` → `graduated` / `archived`),
same as any brainstorming folder.

## At the end

- Do a final read of `idea.md` for contradictions or gaps and reconcile them.
- Set `status:` (`active` if work continues, `archived` if parked).
- Give the user a short recap: what's captured, what's still flagged, and the suggested next
  step — including whether it's ready to graduate into a `workflows/` SOP.
- The capture is a durable artifact: it stays committed under `brainstorming/` (never in a
  scratch/temp dir), as its own change.
