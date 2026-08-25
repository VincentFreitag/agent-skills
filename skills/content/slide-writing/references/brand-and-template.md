# Brand and template handling

A deck that looks like the client's deck is trusted before a word is read.
Resolve the visual system before laying anything out.

**This skill does not own the brand.** The brand is owned by the
**`brand-content-design` skill** and lives in the `brand/` files it produces.
This document is about *finding, reading and obeying* that output — not about
deriving a look. If a colour, font, size, grid value or logo rule is missing
here, the answer is in `brand/`, or it has to be created by
`brand-content-design`. Never fill the gap by inventing.

---

## Step 1 — search, do not ask

```bash
# 1. the brand-content-design contract
ls brand/brand-philosophy.md brand/brand.tokens.json 2>/dev/null
ls brand/assets/logos brand/assets/fonts 2>/dev/null
ls brand/*build-guide*.md brand/tools/ 2>/dev/null

# 2. anything else that could govern the look
find . -maxdepth 4 \( -iname 'brand-philosophy.md' -o -iname '*.tokens.json' \
  -o -iname '*.potx' -o -iname '*styleguide*' -o -iname '*guidelines*' \
  -o -iname 'theme*.json' \) 2>/dev/null

# 3. is a .pptx a real file or a flattened text extract?
file some-deck.pptx        # must say "Microsoft PowerPoint" or "Zip archive"
```

Classify what you find:

| Found | Status | Do |
|---|---|---|
| `brand/brand-philosophy.md` + `brand.tokens.json` | **The contract** | Read both fully. This governs |
| A build guide beside them | Production layer | Follow literally for layouts, placeholders, components, QA |
| A real `.potx` / `.pptx` template | Structure | Build from it |
| A guideline PDF/DOCX with no `brand/` output | Raw source | Read it, then have `brand-content-design` turn it into the contract |
| A `.pptx` that is plain text | **Nothing** | No design information at all. Say so; ask for the real file |
| Nothing | No brand | Offer Brand Init (below) before falling back to neutral |

Exactly one design source → proceed. More than one → **Step 3**.

---

## Step 2 — read the brand-content-design output

Two files, both mandatory reading before any layout work.

### `brand/brand.tokens.json` — the machine values

Expect (names vary by project, the shapes do not):

| Key | Use in a deck |
|---|---|
| `color.*` | Every fill, rule, text and series colour. Note per-colour constraints such as `onDarkOnly` / `onLightOnly` / `textUse: false` |
| `contrast.pass` / `contrast.fail` | The legal and illegal text-on-background pairs. Treat `fail` as hard-forbidden |
| `font.heading` / `font.body` / `font.bodyBold` | Family names, theme refs, files, fallbacks, and any `neverSynthesize` flag |
| `typeScale.*` | The size for every named element, plus its minimum |
| `grid.*` | Canvas, margins, title/body/footer bands, column widths, logo geometry |
| `chart.seriesOrder` / `chart.forbidden` | Chart palette order and banned effects |
| `logoGradient` or similar | Usually **logo-only** — never a fill, text or chart style |

### `brand/brand-philosophy.md` — the rules

Carries what JSON cannot: colour polarity rules, light/dark rhythm, icon and
imagery discipline, "Always / Never" lists, voice and vocabulary. The Never list
is the one most often violated by generated decks — read it before you write the
build script, not after the review.

**The verbal layer binds too.** Where the file states voice, vocabulary, banned
words, sentence rules or punctuation conventions, they govern every string that
lands on a slide — titles, bullets, callouts, table cells, chart annotations,
footnotes — not just marketing copy. A deck that is on-palette and off-voice
still reads as someone else's. Where the brand's language rules and this skill's
title grammar disagree, the brand wins on *form* (punctuation, tone, vocabulary)
and this skill wins on *substance* (the title states a finding, quantified, in one
sentence). They rarely collide.

### Map the brand onto the working roles

A brand defines eight to twenty colours. A slide uses three. Reduce:

| Role | Take from the brand |
|---|---|
| `INK` | Darkest neutral / body-text colour |
| `MUTED` | Mid grey, or ink at ~60% — only if the brand allows it as a text colour |
| `HAIRLINE` | Lightest grey; table rules, gridlines |
| `PANEL` | Subtle background tint for header rows |
| `PRIMARY` | Structural colour and main data series |
| `TINTS` | Up to three secondary colours or tints for further series |
| `ACCENT` | **One** highlight colour. If the brand names a signature colour, that is it |
| `POSITIVE` / `NEGATIVE` | Only if the brand defines semantic colours; used only semantically, never as decoration |

**Record the mapping in your reply** before building 30 slides on a wrong accent:

```
Tier B — brand: <name> (brand/brand-philosophy.md, updated <date>)
CANVAS   <w × h + unit>          GRID   margins <…>, content band <…>
FONT     heading <…> / body <…> / emphasis <…>
INK <…>  MUTED <…>  HAIRLINE <…>  PANEL <…>
PRIMARY <…>  TINTS <…>  ACCENT <…>  (legal on: light / dark / both)
FORBIDDEN  <pairs from contrast.fail, banned effects, logo misuse>
```

### Polarity is the trap

Many brands hold colours that are legal on only one background — a signature
colour that passes contrast on dark and fails on white, and a second colour the
other way round. Two consequences for slide work:

1. **The accent changes with the background.** The same "highlight this bar"
   instruction resolves to a different hex on a dark slide than on a light one.
   Decide per slide, from the brand's contrast table, not once for the deck.
2. **Light and dark are chosen in blocks**, not per slide — dark dividers and
   dark key-message pages separate runs of light content pages. Follow the
   brand's rhythm rule if it states one.

---

## Step 3 — several designs found → ask

**Never pick, never merge.** List them and ask with `AskUserQuestion`, giving
each option enough for the user to choose without opening files: palette
character, fonts, apparent owner, date, and whether it looks current or
superseded.

Counts as "several designs", all requiring the question:

- two or more `brand-philosophy.md` files;
- an "Alternative Palettes" section inside one philosophy file — those are
  *candidate designs the brand skill generated*, not extra colours to use;
- a brand offering light and dark deck modes where either would be defensible;
- several templates with different masters;
- a guideline and a template that **disagree** on a colour or font;
- several visual styles in `brand-content-design`'s `style-constraints.md`.

Does **not** count, and must not trigger a question: several artefacts of the
*same* identity at different precedence levels — philosophy file, build guide,
source template, a Word or web styleguide for the same brand. Step 1's
classification table and the precedence list in `SKILL.md` §4.2 resolve those
silently.

Then stop and wait. If the user has no view, recommend one with a one-line reason
and still get confirmation. Re-skinning later is not a find-and-replace: palette
choices propagate into chart series, table headers, every highlight, and every
light/dark decision in the deck.

**Write the answer down** — in the deck spec and as a header comment in the build
script:

```python
# Design: brand/brand-philosophy.md (house brand 2025), light mode, confirmed by user 2026-08-19.
```

---

## Step 4 — no brand at all

Do not improvise one. In order:

1. **Offer Brand Init.** `Skill: brand-content-design` — its Brand Init flow
   extracts a brand from a URL, PDF, site or existing template, or interviews the
   user, then writes `brand/brand-philosophy.md`, `brand/brand.tokens.json` and
   `brand/assets/`. Ten minutes there saves re-skinning the whole deck later.
2. **If the user declines**, use the Tier N neutral system in `SKILL.md` and say
   explicitly in your reply that the deck is unbranded and how to fix that.
3. **If a raw guideline exists but no `brand/` output** (a PDF, a Word
   styleguide, a corporate site), read it and either run Brand Init against it or
   hand-write the token block above from it. Do not skim it for two colours and
   call that the brand.

---

## Step 5 — the template, for structure

A real template is authoritative for masters, layouts, placeholder geometry,
footer and logo placement. Verify it is a real file first (`file`, or that it
opens as a ZIP). Then inventory it:

```bash
python - <<'PY'
from pptx import Presentation
prs = Presentation("template.pptx")     # a .potx must be rewritten first — see build-and-production.md
print(prs.slide_width, prs.slide_height)
for i, l in enumerate(prs.slide_layouts):
    print(i, l.name, [(p.placeholder_format.idx, p.placeholder_format.type) for p in l.placeholders])
PY
```

If the brand ships a build guide, its layout table and placeholder indices are
already verified — use them instead of re-deriving. Map every storyline slide to
a **named layout**, not to coordinates, and note which placeholder takes which
content. Layout names are sometimes untranslated or odd; go by index and the
guide's mapping, not by guessing from the name.

---

## Partial brand information

| You have | Do |
|---|---|
| `brand/` contract + template, agreeing | Ideal. Tokens from the contract, structure from the template |
| Contract + template disagreeing | Contract wins on colour and type; template still supplies layouts, footer and logo. State the conflict |
| Contract only, no template | Build from scratch on the contract's grid and type scale |
| Brand rules that specify layout | Follow them over this skill's grid — they are the client's, the grid is a default |
| Colours only | Use them for primary/accent; keep neutral greys and the Tier N type scale; say what is missing |
| Logo only | Place per its clear-space and minimum-size rule, one corner, one size, every slide |
| Font only | Use it; if it is unavailable in the environment, substitute the nearest metric-compatible face and **say which** |
| Old deck, no template | Extract tokens from the deck; match title position and footer geometry |
| Two brands (client + firm) | Client brand governs the deck; firm mark small in the footer or on the cover only |

---

## Fonts

Corporate faces are usually absent from the machine that renders your QA images.

```bash
fc-list : family | sort -u | grep -i "arial\|helvetica\|calibri\|georgia"   # linux/mac
powershell -c "[Reflection.Assembly]::LoadWithPartialName('System.Drawing'); (New-Object System.Drawing.Text.InstalledFontCollection).Families | % Name" | grep -i "<brand font family>"
```

Rules:

- Build from the template and the file will carry the right font names even if
  your preview substitutes. **Say which font the file specifies and which one the
  preview used**, so nobody is surprised by reflow.
- Install the brand's OTF/TTF from `brand/assets/fonts/` when you can — the QA
  render is only trustworthy with the real metrics.
- Embed fonts on save where the format supports it, and check the flag survived a
  "Save as".
- Never synthesize a weight the family does not have.

---

## Colour discipline against a brand palette

- One **primary** for structure and the main data series.
- Up to three **tints** for secondary series.
- One **accent**, used once per slide, for the thing that matters — resolved
  against the slide's background per the brand's contrast table.
- Greys for everything that recedes.
- Semantic colours only if the brand defines them, and only semantically.
- Set colour through **theme slots** where the brand exposes them, so a theme
  update propagates.
- Never use a logo gradient, or any logo-only asset, as a fill, text or chart
  style.
