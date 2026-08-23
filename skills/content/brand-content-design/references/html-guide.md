# HTML Page Guide

Content-type guide for generating branded HTML pages and landing pages from a
project's `brand-philosophy.md`. Distilled from the source plugin's `html-generator`
skill, adapted for this workspace: output goes through the built-in **Artifact** tool
(self-contained, inline CSS/JS), not through Node icon scripts or Drupal conversion.

## The Critical Understanding

HTML page creation is **design-system-driven composition**, not template filling.
Every section should feel crafted by a senior designer — intentional, distinctive,
memorable. The standard: work that makes the viewer stop scrolling. Bold, never generic.

**Input**: the project's `brand-philosophy.md` (+ a chosen visual style from
`style-constraints.md`). **Output**: a single self-contained `.html` file, published
via Artifact.

> When the deliverable is an Artifact, also load the `artifact-design` skill for
> calibration, and `dataviz` when the page contains charts. This guide governs the
> brand/style layer; those skills govern Artifact-specific craft.

## Design Thinking (before writing any HTML)

1. **Absorb the brand philosophy** — colors, typography, imagery, voice.
2. **Pick + read the style** — one of the 13 styles in `style-constraints.md`; obey its
   enforcement block (whitespace %, word/element limits, layout, type weights).
3. **Load tokens** — brand colors/fonts/spacing become CSS custom properties in `:root`.
4. **Plan differentiation** — ask "Could this page belong to any brand?" If yes, push
   harder. Name the ONE thing someone will remember (a dramatic type scale, a surprising
   color moment, an unexpected layout break). If you can't name it, it's not distinctive.
5. **Match complexity to the vision** — maximalist styles need elaborate code; minimal/
   refined styles need restraint and precise spacing. Intentionality over intensity.

## Brand Integration

### Design Tokens → CSS Custom Properties
Map brand values to `:root` — never hardcode:
- **Colors** — `--color-primary`, `--color-secondary`, `--color-accent`, `--color-bg`,
  `--color-bg-alt`, `--color-text`, `--color-text-muted`
- **Type** — `--font-heading`, `--font-body`, a `--font-size-*` scale
- **Spacing** — `--space-xs` … `--space-2xl`
- **Layout** — `--max-width`, `--border-radius`
- **Interaction** — `--timing-*`, `--easing-default`

### Color Dominance
Dominant colors with sharp accents beat timid, evenly-distributed palettes. `--color-primary`
leads (headings, CTAs, active nav); `--color-accent` punctuates (links, hover, highlights);
`--color-bg`/`--color-text` do the quiet structural work. If the palette feels "even," push
the primary harder or pull the secondary back.

### Fonts
Artifacts run under a strict CSP that blocks external hosts — **Google Fonts `<link>` will
not load**. Use the brand's fonts if they are web-safe / system-available, otherwise choose
a close system-stack fallback and note it. Never default everything to Inter/Roboto/Arial
unless the brand specifies them. Exploit the full weight range; make headlines dramatically
larger than body (3×–6×).

## Craft Rules

- **Typography as art** — contrasting heading/body pairing, weight contrast (300–900),
  generous body line-height (1.6–1.8), tight headlines (1.0–1.2). Anti-convergence: don't
  reuse the same font choices across different pages.
- **Spatial composition** — controlled asymmetry over dead symmetry; overlap/layering;
  establish a grid then break it for key moments; generous negative space; occasional
  full-bleed sections.
- **Atmosphere** — multi-stop gradient meshes, subtle noise/grain, CSS geometric patterns,
  layered `box-shadow` depth, alternating section backgrounds for rhythm.
- **CSS-first interactivity** — prefer CSS (`transform`/`opacity` transitions, `<details>`
  accordions, `scroll-snap`, `@keyframes`). Add minimal vanilla JS only when the style needs
  it (scroll reveals via IntersectionObserver). Focus the motion budget on ONE high-impact
  moment per page.
- **Images** — Claude can't generate images; use CSS gradient placeholders with `aspect-ratio`
  and an HTML comment showing the real-image swap. Never ship `<img src="missing.jpg">`.

## Accessibility (MANDATORY)
- Semantic HTML5 (`header`/`nav`/`main`/`section`/`article`/`footer`); h1→h2→h3, no skips
- Skip-to-content link; `:focus-visible` on all interactive elements
- WCAG AA contrast (4.5:1 normal, 3:1 large text)
- `@media (prefers-reduced-motion: reduce)` disables animations
- `<html lang>` and viewport meta (the Artifact skeleton handles some of this — verify)

## Anti-Patterns (NEVER)
- CSS frameworks (Bootstrap/Tailwind/Foundation) or external JS (jQuery/React/Alpine) in output
- External stylesheets/fonts/images/fetch — the Artifact CSP blocks them; inline everything
- Walls of text (respect the style's per-section word limits)
- Generic "AI slop" — overused gradients, cliché layouts, stock-photo aesthetics
- Pixel units for type (use rem/em); single weight throughout; uniform sizing

---

*Distilled from camoa/claude-skills `html-generator` (MIT). Drupal-SDC convertibility
metadata and the Lucide Node icon script from the source are intentionally omitted; this
port targets self-contained Artifacts.*
