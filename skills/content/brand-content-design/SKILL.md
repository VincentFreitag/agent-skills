---
name: brand-content-design
description: Create branded visual content (HTML/landing pages, presentations, LinkedIn carousels, color palettes) with the project's own visual identity. Use when the user says "create presentation", "make slides", "make carousel", "LinkedIn carousel", "create HTML page", "landing page", "build web page", "design system", "brand init", "extract brand", "color palette", "alternative colors", "infographic", "brand assets", or wants any on-brand visual output. Reads `brand/brand-philosophy.md`.
allowed-tools: Read, Glob, Grep, Write, Bash, AskUserQuestion, Artifact, Skill
user-invocable: true
---

# Brand Content Design

Create branded visual content with a **consistent visual identity** for whatever project this
skill is installed into. Ported (MIT) from
[camoa/claude-skills](https://github.com/camoa/claude-skills) and reworked into a
single-project layout: the repo you're in *is* the project, and its brand lives at
`brand/` in the repo root.

## Core idea: the brand lives in a plain file

```
brand/
├── brand-philosophy.md     # the identity (colors, type, voice, principles)
├── brand.tokens.json       # machine-readable mirror (colors + font fallbacks)
└── assets/                 # logos (PNG/JPG), fonts (.ttf/.otf)
```

**Discipline (binding):** `brand-philosophy.md` is a *hand-authored, version-controlled asset*,
in the same class as a repo's coding-convention docs. Edit it directly with `Write`/`Edit` and
commit it. If the host repo has a generated knowledge base (a `.brain/`, a docs pipeline, an
index that must be written through a script), `brand/` is **not** part of it — never route
this file through that tooling, and never list it in such an index.

## Three-layer system

Apply these layers, in order, for every piece of content:

1. **Brand Philosophy** — `brand/brand-philosophy.md`. Load the visual DNA (colors,
   typography, imagery) and verbal DNA (voice, tone, vocabulary). If it doesn't exist yet, run
   the **Brand Init** flow below first.
2. **Content-Type Guide** — from this skill's `references/`:
   - HTML pages → `references/html-guide.md`
   - Presentations → `references/presentations-guide.md`
   - Carousels → `references/carousels-guide.md`
3. **Visual Style** — one of 13 styles in `references/style-constraints.md`. Obey its
   enforcement block (whitespace %, word/element limits, layout, type weights, allowed
   components). `references/output-specs.md` gives dimensions/format/typography minimums.

## Flows

Pick the flow that matches the request. Each flow = read the layers, then produce.

### Brand Init — stand up the brand identity
Use when `brand/brand-philosophy.md` doesn't exist yet. **Run this first in a fresh project** —
every other flow reads the file it produces. Skip it once the file is there.
1. Gather the identity. Two paths:
   - **Extract** from a source the user provides (a URL, existing site, PDF, or pasted
     guidelines) — pull colors (hex), fonts, logo description, voice.
   - **Interview** — ask for the essentials with `AskUserQuestion` (primary/secondary/
     accent colors, heading+body fonts, voice in 3 words, always/never principles).
2. Scaffold `brand/{brand-philosophy.md, assets/}` from `references/brand-philosophy-template.md`
   (via `Write` — it's a plain repo asset). Validate text-color contrast to WCAG AA.
3. Ask the user to drop logo/fonts into `assets/`. Note: SVG isn't supported by PPTX/PDF
   raster outputs — keep a PNG/JPG copy.
4. Commit as its own change (e.g. `brand: init visual identity`).

### HTML page / landing page  ← fully supported via built-in tools
1. Read `brand/brand-philosophy.md` + `references/html-guide.md` + chosen style.
2. Also load the `artifact-design` skill (calibration) and `dataviz` if the page charts data.
3. Build a single self-contained `.html` (inline CSS/JS, brand tokens in `:root`) and
   publish it with the **Artifact** tool. Honor the Artifact CSP: no external fonts/CSS/JS.

### Presentation (slides) / LinkedIn carousel / branded .docx  ← design-only, no binary export
**Binary export (PDF/PPTX/.docx) is deliberately not bundled with this skill.** It would need a
Playwright + python-docx toolchain that most host projects don't want as a dependency. So:
1. Read `brand/brand-philosophy.md` + the matching content-type guide + style +
   `references/output-specs.md` (1920×1080 slides, 1080×1350 LinkedIn / 1080×1080 IG carousels)
   and author each slide/card as a standalone, self-contained HTML file in a scratch dir.
2. Tell the user the export step isn't wired — hand back the HTML files (openable directly, or
   printable to PDF from a browser). If binary export becomes a recurring need in that project,
   add the toolchain there and extend this flow locally.

### Color palette
Read `references/color-palettes.md`. Generate derived (color-theory) or mood-based
alternatives from the brand's colors, show swatches with hex, and — if the user keeps
one — append it under "Alternative Palettes" in `brand/brand-philosophy.md`.

## What was intentionally left out of this port

Kept lean so it drops into any repo without dragging conventions along. Omitted from the
source plugin:
- Its 19 slash-commands, own `CLAUDE.md`, and hooks (they would fight the host repo's
  conventions).
- The Node `infographic-generator` / Lucide icon script. HTML output uses the
  **Artifact** tool instead.
- Drupal-SDC convertibility metadata in components.
- PDF/PPTX/.docx export tooling (Python + Playwright) — see the flow above.

## References (bundled)
- `references/brand-philosophy-template.md` — scaffold for the identity
- `references/style-constraints.md` — 13 visual styles with hard-limit enforcement blocks
- `references/color-palettes.md` — color theory + palette generation
- `references/presentations-guide.md` — Presentation Zen slide guidance
- `references/carousels-guide.md` — LinkedIn/Instagram carousel guidance
- `references/html-guide.md` — branded HTML/landing-page craft (Artifact-targeted)
- `references/output-specs.md` — dimensions, formats, typography minimums, safe zones

---

*Adapted from camoa/claude-skills (MIT). Style knowledge based on Presentation Zen and
international design aesthetics.*
