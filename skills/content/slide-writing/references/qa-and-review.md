# QA and review

## Self-QA before shipping (required)

Render and look. After writing a generator you see what you intended, not what
rendered. Conversion commands are in `build-and-production.md`.

Then view every image, looking for these in order:

1. **Text overflow or clipping** — the most common and most visible defect
2. Overlapping elements; leader lines crossing text
3. Source or footer colliding with content above, or content spilling into the
   footer band
4. Ragged column bottoms in a multi-column layout
5. Elements closer than the grid's minimum gap, or margins under the brand's
6. Columns not aligned to the same x across slides
7. Title decoration positioned for one line where the title wrapped to two
8. Low-contrast text or icons
9. Leftover placeholder content — the template's own boilerplate included
10. Jitter — the same element at a different y on consecutive slides. Flip
    through the renders quickly; anything that moves and should not, jumps out

Fix, re-render the changed slides, stop. Do not chase perfection past the second
pass.

### Brand QA (Tier B only)

Run alongside the above, from the brand's own rules — the brand file's "Never"
list and any checklist in its build guide are the source. Generic version:

- [ ] Every slide sits on a real master layout; no free-floating rebuilds
- [ ] No colour outside the brand palette; colours set via theme slots where the
      brand exposes them
- [ ] No text/background pair from the brand's `contrast.fail` table
- [ ] No synthesized weight on a single-weight face; emphasis via the correct
      family
- [ ] Frame taken verbatim: canvas, margins, bands, palette, type families, logo
- [ ] Body text at or above the floor — the brand's stated one, or this skill's 9pt
      where the brand states none. Nothing shrunk below it to make content fit
- [ ] Logo on every content slide per its position, size and clear-space rule,
      undistorted, unrecoloured
- [ ] Logo-only assets (gradients, marks) not reused as fills or chart styles
- [ ] Light/dark used in blocks per the brand's rhythm, not slide by slide
- [ ] Accent colour: one element per slide, and legal on that background
- [ ] Footer text, confidentiality level and page numbers set; title slide
      exempt from numbering if the brand says so
- [ ] Fonts embedded on save (open once on a machine without them to be sure)
- [ ] Nothing below the brand's footer line
- [ ] Every string on the slide obeys the brand's voice, vocabulary and punctuation
      rules, including its banned words and characters

## The executive test

- Can a senior reader get the point in **10 seconds**?
- Does the title tell them what to think, or only what the page is about?
- Is there exactly one ask or conclusion?
- Could any element be deleted without losing the message? Delete it.
- **90-second rule:** a slide needing more than 90 seconds to read is too dense.
- **Squint test:** squint at it; the most important element must still dominate.
- Would you be comfortable if only the titles were read aloud?

## Reviewing someone else's deck

Three parts, in this order.

**1. Verdict.** Horizontal logic — do the titles alone tell the story? Vertical
logic — does each slide's content prove its own title? Does the deck fit the
meeting it is for? Two or three sentences, no hedging.

**2. Slide by slide.** For each: title quality against the action-title rules
(quote the original, then propose the rewrite), archetype fit, chart fit, and
polish defects. Skip slides that are fine — saying "slide 7 is good" and moving
on is more useful than manufacturing a comment.

**3. Top three fixes.** The three changes with the largest effect, ranked. This
is the part that gets acted on.

Keep brand findings separate from argument findings, and label them as such: a
palette violation and a broken storyline are fixed by different people at
different times. Never propose a visual "improvement" that contradicts the brand
files — if the brand mandates something you would not have chosen, that is not a
finding.

### Diagnostic passes

| Pass | What it catches |
|---|---|
| Titles-only read | Broken storyline, missing slides, redundant slides |
| Title–content match | Numbers in a title that are not on the page |
| Clothesline scan | Any slide with 5+ ungrouped parallel elements |
| Chart-fit | Chart type fighting the message's comparison type |
| Naked-chart scan | Missing unit, period, source, or direct labels |
| Density | 90-second rule, squint test |
| Consistency | Terms, colours, category order, number format drift |
| Brand conformance | The Tier B checklist above |
| Ctrl+F | Wrong client name from a copied deck, double spaces, mixed units |

## Document checklist

**Cover** — title, client name, date set to the meeting date, authors.
**Structure** — exec summary present, contents present, pyramid order.
**Titles** — full sentences, match content, ≤2 lines, numbers reconciled.
**Footer** — source on every data slide, footnotes explained where they appear,
page numbers, consistent footnote style.
**Formatting** — nothing out of bounds; recurring elements in identical
positions; one font family; one body size; bullets in groups of ≥2 with parallel
grammar, each one a statement rather than a category label; ≤3 colours per
slide; accent used once; coloured fills only behind hierarchically superior text;
consistent capitalisation and number punctuation.
**Brand** — the Tier B checklist, where a brand governs.
**File** — clean filename, no "Copy of", spell check run, no misleading alt text.

## The recurring failures

1. Topic labels instead of action titles
2. Title claims what the slide does not show, or numbers disagree
3. Clotheslines — 5+ ungrouped parallel items
4. Two messages on one slide
5. Chart type fighting the message
6. Naked charts — no unit, period, source or legend
7. Decoration over data — 3D, gradients, screenshots
8. Process narration ("we ran 15 interviews") presented as an insight
9. Drift across the deck — terms, order, formatting, colour meaning
10. Coloured fills behind ordinary body text
11. Paragraph-length bullets, or a list of one
12. Mixed fonts, many sizes, too many colours
13. Animation used to decorate rather than to sequence an argument
14. Category bullets — a line carrying only a noun or a label ("Costs", "Governance")
    instead of a statement about it
15. Frameworks that decorate — a 2x2 or a pyramid that does not change what the reader
    decides

And the last one, specific to generated decks: **a look invented instead of
consumed** — a palette, font or grid the generator chose because no one read the
brand files. It is the fastest of all of these to spot from across a room.

## Honest signalling

If numbers are provisional, sticker the slide (`Preliminary`, `Indicative`,
`Illustrative`, `For discussion`). If an estimate rests on an assumption,
footnote the assumption on the same page as the number. If a range is genuinely a
range, show both cases. Overstated precision is the fastest way to lose a room,
and the sticker costs nothing.

## Banned phrasings

Sweep the built deck for these before handing it over. They survive review
because each one reads fine in isolation.

| Pattern | Why it fails | Fix |
|---|---|---|
| "It is X, not Y" | half the words carry a negation that adds no evidence | write X alone |
| "not just X, but Y" | same tic wearing a different coat | write Y alone |
| "not the other way round" | the reader already inferred the direction | delete |
| "In this section we show..." | meta-comment, the slide is the showing | delete |
| "X was driven by Y" | passive, hides the actor | "Y drove X" |

Grep is enough: `, not `, `not just`, `rather than`, `instead of`, `not only`.
