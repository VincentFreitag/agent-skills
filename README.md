# Agent Skills

Our shared library of agent skills. Skills live here once, get imported into individual
projects, and improvements flow back here instead of dying in whichever repo they were written
in.

A **skill** is a folder with a `SKILL.md` (plus optional `references/`, templates, scripts).
The agent reads the frontmatter `description` to decide when to reach for it. Skills are plain
markdown — they work in Claude Code, and largely in any agent that supports the format.

Structure and philosophy borrow from [mattpocock/skills](https://github.com/mattpocock/skills):
small, composable, adaptable skills rather than a framework that owns your process.

## Catalog

| Skill | Category | Invocation | Use when |
|---|---|---|---|
| [`fable-mode`](skills/engineering/fable-mode/SKILL.md) | engineering | model-invoked | A task has many layers — dependent steps, unknowns that could change the approach, debugging where the first theory may be wrong — or it keeps stalling. Loads a five-gate task loop. Skip for trivial edits. |
| [`frontend-design`](skills/engineering/frontend-design/SKILL.md) | engineering | model-invoked | Build web components, pages, or applications. Pushes for a bold, cohesive aesthetic direction and production-grade code instead of generic "AI slop" defaults (Inter/Roboto, purple gradients, predictable layouts). |
| [`grill-me`](skills/productivity/grill-me/SKILL.md) | productivity | user-invoked | Stress-test a plan or run a discovery session. Interviews you one question at a time and co-authors `brainstorming/<date>-<slug>/idea.md`, checkpointing after every exchange. |
| [`skill-builder`](skills/productivity/skill-builder/SKILL.md) | productivity | model-invoked | Build a new skill, optimize or audit an existing one, or troubleshoot a skill that isn't triggering. Runs a discovery interview before writing files and checks frontmatter/content against official Claude Code conventions. |
| [`storm-research`](skills/productivity/storm-research/SKILL.md) | productivity | user-invoked | Multi-perspective, citation-verified research briefing → self-contained HTML in `storm-reports/`. Five expert lenses, contradiction map, adversarial peer review. Overkill for a simple lookup. |
| [`brand-content-design`](skills/content/brand-content-design/SKILL.md) | content | user-invoked | Branded visual output — HTML/landing pages, stage decks, LinkedIn carousels, color palettes — driven by a repo-local `brand/brand-philosophy.md`. Owns the brand, not consulting decks. |
| [`slide-writing`](skills/content/slide-writing/SKILL.md) | content | model-invoked | Build, restructure or review a consulting-grade deck — steerco pack, board deck, pre-read, one-pager. Owns message, storyline, action titles, layout, chart logic and QA; consumes `brand-content-design`'s `brand/` files for the visual frame. |

## Importing into a project

Two ways in, mirroring the two philosophies: **copy** files you own and edit, or **subscribe**
to a managed bundle that updates when we ship. Pick one — doing both leaves you with every
skill twice.

### 1. Copy (per-skill, editable, any agent)

Clone the library once, anywhere:

```bash
git clone https://github.com/InnoHubHH/Agent-Skills.git ~/dev/Agent-Skills
```

Then, **from the target project's root**:

```powershell
# Windows / PowerShell
~\dev\Agent-Skills\scripts\install.ps1 -List
~\dev\Agent-Skills\scripts\install.ps1 fable-mode, grill-me
```

```bash
# macOS / Linux / Git Bash
~/dev/Agent-Skills/scripts/install.sh --list
~/dev/Agent-Skills/scripts/install.sh fable-mode grill-me
```

Skills land in `.claude/skills/<name>/` as ordinary files. Useful flags: `--all` / `-All`,
`--force` / `-Force` (overwrite on update), `--target` / `-Target` (install somewhere else).

Every import is recorded in `.claude/skills/.innohub-skills.lock` — skill, library commit,
date — so you can tell what version a project is running and what has drifted. Commit that
file.

Then restart the agent session so it picks the skills up.

### 2. Subscribe (Claude Code plugin, auto-updating)

```
/plugin marketplace add InnoHubHH/Agent-Skills
/plugin install innohub-skills@innohub
```

This installs **all** skills as a managed, read-only bundle. Refresh with
`/plugin marketplace update`. Best for projects that just want the standard set and no local
edits. (Requires access to this private repo.)

## Contributing a skill back

The whole point of the library is that improvements accumulate here rather than in one
project. If you write or sharpen a skill in a project, port it back —
see [CONTRIBUTING.md](CONTRIBUTING.md) for the layout rules, the portability checklist, and
what makes a skill worth adding at all.

## Provenance

Skills here were first written in or adapted for other repos and then generalised:

- `fable-mode`, `grill-me`, `storm-research` — written for the LightOS repo.
- `brand-content-design` — ported (MIT) from
  [camoa/claude-skills](https://github.com/camoa/claude-skills), then reworked.

Porting means the project-specific coupling was removed. See CONTRIBUTING.md → *Portability
checklist*.
