# CLAUDE.md

This repo is a **skill library**, not an application. Its contents are instructions for
agents, so almost every change here changes how some other project's agent behaves.

## Before you touch anything

Read [CONTRIBUTING.md](CONTRIBUTING.md). It holds the layout rules, the frontmatter contract,
and the portability checklist — all of it binding, not advisory.

## The one rule that matters

**A skill must work when copied into a repo you have never seen.** Projects import copies of
these folders into their own `.claude/skills/`. Anything reaching outside the skill folder —
a `../../../` link, a project name, an assumed script or directory — is broken on arrival, and
it breaks silently: the agent follows a dead pointer and improvises.

When a skill genuinely needs a convention the host repo might also have (a `brainstorming/`
layout, a docs pipeline, a brand file), bundle a sane default in `references/` and add a
**host-repo override** note: if the target repo has its own version, that one wins.

## Working here

- Editing a skill? Re-run the portability checklist on it, not just on new files.
- Adding a skill? Three places must stay in sync: the folder, the catalog table in
  `README.md`, and the `skills` array in `.claude-plugin/plugin.json`.
- Changing `scripts/install.*`? Both scripts must stay behaviourally identical — most of the
  team is on Windows, the CI-ish paths are POSIX.
- Do not add dependencies. No npm, no Python, no build step. The library is markdown plus two
  install scripts, and that is what makes it importable anywhere.

## What this repo is not

Not a place for project-specific procedure. If something only makes sense against one repo's
tooling or domain, it belongs in that repo as a workflow doc. Say so rather than generalising a
skill until it is useless.
