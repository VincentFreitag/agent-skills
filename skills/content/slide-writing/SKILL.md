---
name: slide-writing
description: Turn content into best-in-class consulting-grade slides and decks. Use whenever the user wants to build, draft, restructure, review, or critique a slide, deck, presentation, pre-read, steerco pack, board pack, or one-pager — and whenever they mention action titles, storyline, MECE, pyramid principle, exec summary, or a chart for a slide. Also use when a deck must follow a client's or firm's brand. All brand, colour, typography and template decisions are delegated to the brand-content-design skill and the brand/ files it produces; this skill owns the thinking (message, storyline, layout, chart logic) and the production discipline (grid, hierarchy, build, QA).
---

# Slide Writing — consulting grade

Produce slides a partner would put in front of a CEO. Two things must be true at
once: the **thinking** is right (one message, answer first, titles tell the
story) and the **craft** is right (grid, hierarchy, palette, no jitter).
Most output fails on the second. This skill fixes both.

**Division of labour, binding:** this skill decides *what goes on the slide and
why*. The **`brand-content-design` skill and the `brand/` files it produces**
decide *what it looks like* — colours, fonts, type sizes, grid, logo, layouts,
visual style. Never invent a look, never re-derive a palette, never override a
brand token. When this skill's defaults collide with a brand, see
[Two design tiers](#two-design-tiers).

## Modes

| Mode | Trigger | Output |
|---|---|---|
| **Architect** | "build a deck on X", "structure this into slides" | Storyline: numbered action titles + archetype per slide, confirmed before building |
| **Build** | "make the deck", "turn this into slides" | An actual `.pptx` (or the precise slide spec if the medium is text) |
| **Review** | "critique this deck", a pasted slide or screenshot | Three-part feedback (see `references/qa-and-review.md`) |
| **Single slide** | "put this on a slide" | One slide, fully specified |

Default to **Architect first** for anything over 3 slides. Never skip to Build
with an unapproved storyline — rebuilding 20 slides because the argument was
wrong is the most expensive failure mode there is.

## Order of operations (do not reorder)

1. **Audience and decision.** Who reads it, what do they decide, how long do
   they have? A 5-slide pre-read for a steerco is not a 40-slide workshop pack.
2. **Governing thought.** One sentence that is the answer to their question.
   Everything in the deck supports it or is cut.
3. **Storyline.** Write every action title, in order, before any slide exists.
   Read them alone: they must be the whole argument. Fix here, not later.
4. **Brand.** Resolve the visual system *before* laying anything out — see
   [Step 4](#step-4-in-detail-brand-resolution). Layout choices depend on the
   palette, the type scale and the canvas.
5. **Archetype per slide.** Map each title to a layout from
   `references/layout-library.md`, then onto a **real brand layout** if the
   brand supplies one. Vary them; a deck of one layout is a report.
6. **Build.** Charts first, then supporting text, then polish.
7. **QA.** Render to images and look. Non-negotiable.

## Step 4 in detail: brand resolution

**The brand is not this skill's to invent. It is `brand-content-design`'s
output, and this skill consumes it.**

### 4.1 Look, don't ask

Asking "do you have brand guidelines?" when they are sitting in the folder
wastes a turn and signals you did not look. Search first:

```bash
# the brand-content-design contract — primary source
ls brand/brand-philosophy.md brand/brand.tokens.json 2>/dev/null
ls brand/assets/logos brand/assets/fonts 2>/dev/null
ls brand/*build-guide*.md brand/tools/ 2>/dev/null      # optional build layer

# fallbacks, only if the contract is absent
find . -maxdepth 4 \( -iname 'brand-philosophy.md' -o -iname '*.tokens.json' \
  -o -iname '*.potx' -o -iname '*styleguide*' -o -iname '*guidelines*' \) 2>/dev/null
```

### 4.2 Precedence

1. **`brand/brand-philosophy.md` + `brand/brand.tokens.json`** — the
   `brand-content-design` output. **Authoritative for colour, typography, type
   scale, grid, logo and usage rules.** Read both: the `.json` carries machine
   values, the `.md` carries the rules and the reasoning behind them.
2. **A build guide beside them** (e.g. `brand/powerpoint-build-guide.md`) —
   authoritative for *production*: layout catalogue, placeholder indices,
   component recipes, brand QA checklist. Follow it literally.
3. **A real `.potx` / `.pptx` template** — authoritative for masters, layouts,
   footer geometry, logo placement. Build *from* it, never beside it.
4. **An existing deck from the same client** — extract tokens and match.
5. **Nothing found** — do **not** improvise a brand. Offer to run
   `brand-content-design`'s Brand Init flow first (`Skill: brand-content-design`),
   which produces items 1–2 in one pass. Only if the user declines, or the deck
   is explicitly brand-free, fall back to the
   [neutral consulting system](#palette) — and **say so in your reply**.

Anything the brand files state about the **frame** wins over anything in this
skill. This skill fills the gaps they leave — and they always leave gaps, because
a brand guideline governs identity, not argumentation. Inside the content band
their placeholder sizes are defaults rather than law; see
[Frame and field](#frame-and-field).

### 4.3 Several designs found → ask, never merge

If discovery turns up **more than one design**, stop and ask which governs.
Silently picking one produces a deck that is confidently wrong about the
client's identity, which is worse than an unbranded deck. Merging two is worse
still. This applies to all of:

- several `brand-philosophy.md` files (different clients, or old vs. new);
- an **"Alternative Palettes"** section inside one philosophy file;
- a brand with **light and dark modes**, or several deck moods, where the deck
  could legitimately run either way;
- several templates (`.potx`/`.pptx`) with different masters;
- a brand guideline and a template that **disagree** on colour or type;
- several visual styles offered by `brand-content-design`'s
  `references/style-constraints.md`.

**Not** several designs, so do not ask: several files describing the *same*
identity at different precedence levels — a philosophy file, its build guide, the
template it was extracted from, a Word or web styleguide for the same brand.
Precedence (4.2) resolves those. Ask only when two sources describe **different
identities**, or when one source offers a genuine **choice** (alternative
palettes, light/dark modes, style options).

Ask with `AskUserQuestion`, one question, options described well enough to
choose without opening files:

```
Three design sources found — which governs this deck?

  1  brand/brand-philosophy.md          Current house brand: green/blue polarity, two custom faces.
  2  brand/brand-philosophy.legacy.md   Older palette, Arial. Looks superseded.
  3  client-x/guidelines.pdf            Client brand — governs if the deck is client-facing.
```

Then **stop and wait**. Palette choices propagate into chart series, table
headers and every highlight; re-skinning afterwards is not a find-and-replace.
If the user does not know, recommend one and say why — but still get
confirmation. A directory of sibling preset themes is a *menu inside one
source*, not competing brands: present its options as choices, and still ask.

**Record the choice** in the deck spec and as a header comment in the build
script, so a later session does not re-litigate it.

Full workflow, token mapping, partial brands and font fallbacks:
`references/brand-and-template.md`.

⚠️ **A text extract is not a template.** If a `.pptx` appears in project
knowledge as plain text (no XML, no theme), it carries zero design information —
mine it for structure and wording, never for brand. A real template opens as a
ZIP (`file x.pptx` says "Microsoft PowerPoint" or "Zip archive").

## Two design tiers

The skill runs in one of two tiers. Establish which one you are in at step 4 and
say so in your reply.

| | **Tier B — brand-governed** | **Tier N — neutral** |
|---|---|---|
| When | A brand-content-design output, guideline or template exists | No brand, and Brand Init was declined or is out of scope |
| **The frame** — canvas, margins, title/content/footer bands, palette and its contrast rules, type families, logo, master layouts | **From the brand files** | This skill's defaults below |
| **The field** — everything inside the content band: message, storyline, archetype, chart logic, text sizing, density, QA | **This skill**, driven by the content | This skill |

### Frame and field

A brand governs the **frame**: canvas size, margins, the title / content / footer bands, the
palette and its contrast rules, the type families and their traps, the logo, and the master
layouts. Those are identity and physics, and they are absolute.

Inside the **field** — the content band — the brand's *numbers* are defaults, not law.
Corporate templates set their placeholder sizes for marketing and stage decks, where a page
carries four lines. Taking those sizes literally on a consulting page halves the argument it
can carry. Design the field from the content and the consulting standard, and stay above the
floor the brand states or, where it states none, above this skill's.

Where a brand file does not label its own numbers, classify them yourself: a size belonging to
a **fixed layout** (cover, divider, fact tile, quote, CTA, footer) is frame and is copied
verbatim. A size governing **free content** (standard title, body, bullets, table cells, chart
labels, sources) is field. State the classification in the deck spec so a later session does
not undo it.

### Conflict resolution in Tier B

| Collision | Resolution |
|---|---|
| Brand type scale (e.g. 28pt title / 20pt body) vs. this skill's (18–20 / 9–10) | **Ask: frame or field?** On a fixed brand layout the brand wins verbatim. In the content band its sizes are defaults — design from the content, never below the stated floor. Buy density by cutting or splitting, never by shrinking past the floor |
| Brand grid in cm vs. this skill's inch grid | **Brand wins.** Convert the archetype's proportions onto the brand grid |
| Brand palette vs. this skill's neutral palette | **Brand wins**, entirely. Map brand colours onto the working roles (`references/brand-and-template.md`) |
| Brand layout catalogue vs. this skill's archetypes | The archetype names the *shape*; the brand layout supplies the *slots*. Use the nearest brand layout; build free-form only on a layout the brand provides for that purpose (Title Only / Blank) |
| Brand says "no full-text slides"; the deck needs a dense assessment table | Both are right: that table is a **document page**. Keep it at or above the brand's minimum type size, or move it to the appendix at the brand's dense/appendix scale if one is defined. Never invent a smaller size |
| Brand guideline vs. template disagree on a colour or font | Guideline wins; the template still supplies layouts, footer and logo. **State the conflict** in your reply |
| Brand mandates a decoration (accent bar, coloured footer) this skill would call decoration | Brand wins. It is identity, not ornament |
| Content genuinely will not fit the brand grid at the brand minimum size | Split the slide or cut. Shrinking type, shaving margins or spilling into the footer band are all forbidden |

The one thing that never yields: **one message per slide, stated as an action
title.** No brand overrides the argument.

---

The rest of this file is the **Tier N** system — and the vocabulary used to
describe layouts in Tier B. In Tier B, read the numbers as *proportions* and take
the actual values from the brand tokens.

## The grid — 16:9, 13.333" × 7.5"

Tier N defaults. Consistency across slides matters more than the specific values.

| Band | y (in) | Contents |
|---|---|---|
| Kicker / tracker | 0.28 – 0.50 | Section label or `Kicker \|` prefix, 9pt, muted |
| Action title | 0.52 – 1.12 | 18–20pt semibold, **max 2 lines** |
| Content | 1.30 – 6.60 | Everything else |
| Footer | 6.75 – 7.22 | Footnotes and source, 7pt muted. Page-number corner left empty |

Horizontal: margins **0.5"** left and right → live width **12.333"**.
12 columns of **0.89"** with **0.15"** gutters.

Standard splits (x-origin, width):

- **8 / 4** — chart + observations, the workhorse: `(0.50, 8.17)` `(8.82, 4.01)`
- **6 / 6** — two-up comparison: `(0.50, 6.09)` `(6.74, 6.09)`
- **4 / 4 / 4** — three pillars: `(0.50, 4.01)` `(4.66, 4.01)` `(8.82, 4.01)`
- **3 × 4** — four steps/phases: `(0.50, 2.97)` `(3.62, 2.97)` `(6.74, 2.97)` `(9.86, 2.97)`

Vertical rhythm: 0.20" between related elements, 0.40" between groups. Never
place anything outside the bands. If content will not fit the content band, cut
content — do not shrink the band, the margins, or the type.

**Tier B:** take canvas, margins, title band, content band, footer band and
column widths from `brand.tokens.json` (`grid`) or the build guide. Keep the same
*ratios* — an 8/4 split is 8/4 of the brand's live width. Respect any "nothing
below y = X" footer rule the brand states.

### Page numbers stay out of the build

Never write a page number into a slide, and never place a text box that holds
one. Reserve the space the brand's grid gives the number, leave it empty, and
keep every other footer element clear of it. The user applies PowerPoint's own
slide-number field afterwards (`Insert > Header & Footer > Slide number > Apply
to All`), which renumbers itself when slides move, get inserted or get deleted.
A typed number goes stale on the first reorder and is then wrong in a document
nobody re-checks.

Same reason, same rule for cross-references: an agenda, contents or divider
slide names its sections without "p. 12" style pointers, and body copy refers to
"the sourcing section" rather than to a page.

## Type scale

One font family for the deck. Body text is **one size** everywhere.

| Element | Tier N size | Weight |
|---|---|---|
| Action title | 18–20 pt | Semibold |
| Kicker / tracker / section label | 9 pt | Regular, muted, sentence case |
| Column or block header | 11 pt | Bold |
| Body / bullets / cells | 9–10 pt | Regular |
| Chart data labels | 8–9 pt | Regular; bold the highlighted one |
| Footnote, source | 7 pt | Regular, muted |

Never below 8pt in Tier N (appendix may go to 7pt). Bold selectively — only the
words carrying the message, never whole sentences.

**Tier B:** use the brand's `typeScale` verbatim, including its minimum size, and
its heading/body/emphasis families exactly as named. Two traps that recur in
corporate brands, both worth checking in the brand file before styling any run:

- a heading face that ships in **one weight only** — pressing B or I synthesizes
  a fake, distorted cut;
- a "bold" body face that is a **separate family**, not a weight of the regular
  one — switch family, do not press B.

Where the brand exposes theme fonts (`+Headings` / `+Body`, `+mj-lt` / `+mn-lt`),
reference those rather than font names, so the deck survives a theme update.

## Palette

Three colours in active use per slide: **primary, accent, neutral.** The accent
appears on exactly one thing per slide — the data point or item that carries the
message. Everything else recedes to grey. Every colour must mean something.

**Tier B:** the brand supplies these roles. Reduce its full palette down to this
shape rather than using all of it, and obey any **polarity rule** it states —
many brands have colours that are legal only on light or only on dark
backgrounds; violating that fails contrast and reads as off-brand instantly.
Where the brand defines theme slots, set colour **through the slots**, not as raw
RGB. Where it defines a light/dark rhythm (dark dividers between light content
runs), follow it at block level, not slide by slide.

**Tier N fallback only:**

```
Ink            1A1A1A     body text, titles
Muted          6B6B6B     kickers, footnotes, secondary text
Hairline       D8DCE0     rules, table borders, gridlines
Panel          F2F4F6     header-row fills, subtle grouping
Primary        123B5C     charts, headers            (tints 3C6E92 / 7BA0BC / B9CEDD)
Accent         D2532A     the one highlight per slide
Positive       2E7D5B     favourable deltas only
Negative       B03A2E     unfavourable deltas only
```

Standard body text sits on the plain background. Coloured or dark fills are
reserved for **hierarchically superior text** — column headers, section headers —
and applied to every peer at that level or none. A fill behind ordinary text adds
ink without information. This holds in both tiers unless the brand's own layouts
do otherwise.

## Turning content into a design

Read the content and identify its **shape**, then pick the archetype. Full
catalog with slot specs and geometry in `references/layout-library.md`.

| Content shape | Archetype |
|---|---|
| A number moved / broke down | Waterfall + driver callouts |
| A trend over time, with reasons | Chart + observations (8/4) |
| N items compared on M dimensions | Assessment table (rows × dimensions) |
| A ranked or scored set | Table with Harvey balls or traffic lights |
| Two mutually exclusive paths | A-vs-B comparison with implications row |
| A sequence with dates | Timeline / roadmap with "we are here" |
| A sequence without dates | Chevrons or numbered steps |
| A whole decomposed into parts | Issue tree / driver tree |
| Two axes of choice | 2×2 matrix |
| A model the audience must hold | Framework / structure page (hub + spokes) |
| A set of recommendations | Initiative table (what / owner / impact / by when) |
| Open questions for the room | Question grid, flagged `For discussion` |

Vary archetypes across the deck. Three consecutive slides of the same layout
means the content was not actually analysed.

## Building the file

Full mechanics: `references/build-and-production.md`. Two paths, in preference
order:

- **Template-derived (always preferred when a template exists).** Start from the
  brand's `.potx`/`.pptx`, pick a real layout per storyline slide, fill its
  placeholders. Inherits masters, theme, fonts, footer and logo, and survives the
  client opening it in their own PowerPoint. `python-pptx` is the tool; if the
  brand ships a helper module (e.g. `brand/tools/*_deck.py`), use it rather than
  re-solving the template plumbing.
- **From scratch (`pptxgenjs` or `python-pptx`)** only when no template exists.
  Define palette and grid as constants at the top of the generator and reference
  them everywhere — never hard-code a coordinate twice.

**Precedence note.** Generic presentation guidance — including
`brand-content-design`'s `references/presentations-guide.md` (Presentation Zen)
and any installed `pptx` skill's "Design Ideas" — targets *stage* decks: huge
type, one idea per screen, imagery on every page. Consulting decks are read, not
projected: smaller action titles, dense text tables and data-only pages are
correct here. Where they conflict, **this skill wins on density, text volume and
layout; the brand files win on tokens and identity; the mechanical skill wins on
API footguns, validation and XML.** If a deck really is for a stage, say so and
raise the whole type scale one step — by cutting text, not by enlarging boxes.

## Reference files

Load on demand, not up front:

| File | Read when |
|---|---|
| `references/brand-and-template.md` | **Every deck, step 4** — brand resolution, token mapping, partial brands |
| `references/action-titles.md` | Writing or fixing any title; worked examples from real MBB decks |
| `references/layout-library.md` | Choosing or specifying a layout |
| `references/chart-craft.md` | Any slide with data |
| `references/deck-architecture.md` | Structuring a whole document |
| `references/build-and-production.md` | Writing the build script |
| `references/qa-and-review.md` | Before shipping, or when reviewing someone's deck |
| `Skill: brand-content-design` | No brand exists yet (Brand Init), or a palette/style decision is needed |

## Non-negotiables

1. One message per slide, stated in the action title as a full sentence.
2. Titles read alone tell the whole story.
3. Answer first — conclusion, then support, then evidence.
4. Every slide is a table: rows and columns, aligned to the grid.
5. Chart type derives from the comparison in the message, not the shape of data.
6. One accent colour, one job.
7. Brand tokens are consumed, never invented and never overridden — the frame is
   absolute. Several designs found → ask, never merge.
8. Source line on every slide with data; status sticker whenever numbers are not
   final (`Preliminary`, `Indicative`, `Illustrative`, `For discussion`).
9. Every bullet states something. A bullet carrying only a category or a bare noun is a
   label, not a finding — write the finding or delete the line.
10. A framework earns its place only by supporting the reader's decision. Never one for its
    own sake.
11. Render and look at every slide before declaring done.
