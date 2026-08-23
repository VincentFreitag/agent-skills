# Contributing a skill

## Does it belong here?

A skill earns a place in the library if it passes all three:

1. **Reusable** — it would be useful in at least two different projects. A procedure that only
   makes sense against one repo's tooling is that repo's workflow doc, not a library skill.
2. **Portable** — it needs only built-in agent tools, or tools it bundles itself. A skill that
   depends on a script living outside its own folder is not importable.
3. **Worth triggering** — the `description` describes a situation an agent can recognise. If
   you can't write that sentence, the skill has no reliable entry point.

A skill that fails #1 or #2 but is still good work stays in its home repo. Not everything needs
to be a library skill.

## Layout

```
skills/<category>/<skill-name>/
├── SKILL.md          # required — frontmatter + the instructions
├── references/       # optional — loaded on demand, keeps SKILL.md short
└── <templates, scripts, assets>
```

Categories in use: `engineering/`, `productivity/`, `content/`. Add a new one only when a skill
genuinely fits none of them — categories are for humans scanning the catalog, and the agent
never sees them.

`<skill-name>` is kebab-case and must be unique across the whole library, not just its
category — installed skills land in one flat `.claude/skills/` directory in the target project.

### `SKILL.md` frontmatter

```yaml
---
name: my-skill                 # matches the folder name
description: >                 # THE trigger. Third person, situation-first.
  Use when the user wants X, says "…", or needs Y. Describes when to reach
  for this, not just what it does.
allowed-tools: Read, Write     # optional — restrict what the skill may use
user-invocable: true           # optional — only reachable when typed as /my-skill
argument-hint: "[topic]"       # optional — shown in the slash-command UI
---
```

The `description` is the only part of a skill that is always in the agent's context. Everything
else is read after it decides to load the skill. Spend your effort there: name the *situation*
and the literal phrases a user would say.

Keep `SKILL.md` short enough to read in one go. Push detail into `references/` and point at it
from the body — the agent will follow the pointer when it needs it.

## Portability checklist

Run this before you commit. Every item is something that silently breaks once the skill is
copied into a different repo.

- [ ] **No relative escapes.** Nothing resolving above the skill folder — `../../../CLAUDE.md`
      dangles the moment the skill is installed elsewhere. Bundle it in `references/` instead.
- [ ] **No project names.** No LightOS, ChOS, VF-SecondBrain, no customer names. Say "the
      project" / "this repo" / "the host repo".
- [ ] **No project-specific tooling.** No `tools/brain-write.py`, no repo-specific scripts,
      no assumed folder like `.brain/` or `docs/work-packages/`. If the skill genuinely needs
      such a convention, bundle a default in `references/` and add a *host-repo override* note:
      if the target repo has its own version, that one wins.
- [ ] **No personal names** in trigger phrases. `when the user says`, not `when <name> says`.
- [ ] **Output paths are relative to the working directory** and the skill creates them if
      missing.
- [ ] **Attribution kept** where a skill was ported from someone else's work, with its licence.
- [ ] `grep -rniE 'lightos|chos|secondbrain|\.brain|\.\./\.\./' skills/<category>/<name>/`
      comes back clean (or every hit is deliberate and explained).

## Adding it

1. Put the folder in `skills/<category>/<name>/`.
2. Add a row to the catalog table in [README.md](README.md) — including whether it is
   user-invoked or model-invoked.
3. Add the path to the `skills` array in
   [`.claude-plugin/plugin.json`](.claude-plugin/plugin.json). **This is easy to forget**: skip
   it and the skill is importable by script but invisible to anyone using the plugin.
4. Test the import into a real project before pushing:
   ```bash
   ./scripts/install.sh --list          # your skill shows up, description reads right
   ./scripts/install.sh <name> --target /tmp/probe/.claude/skills
   ```
5. Open a PR. Conventional commit prefix — `feat(skills):`, `fix(skills):`, `docs:`.

## Changing an existing skill

Projects hold **copies**, not links, so a change here does not reach them until someone re-runs
the installer with `--force`. That is deliberate — no skill mutates under a running project.

The consequence: `.claude/skills/.innohub-skills.lock` in each project records the library
commit it imported. When you make a meaningful change, say so in the commit message so it is
findable later, and tell the projects that should pull it.
