# Layout library

Every layout is a table: rows are items, columns are dimensions. Pick the
archetype that matches the *shape* of the content, then fill its slots.

## Build one slide in this order

Never start at step 3.

1. **Message.** State the one message and write it as the action title. If you
   cannot state it in a sentence, the slide is not ready to be built.
2. **Layout.** Choose the archetype from the content's shape — rows = items,
   columns = dimensions (measure, rationale, impact, timing).
3. **Main visual.** Build the centrepiece, usually the chart. Chart type comes
   from the message, not the data shape.
4. **Supporting text.** Bullets, labels, callouts, takeaway. Parallel grammar
   across every list, and every bullet a statement — a line that reads "Cost base"
   or "Regulatory risk" is a column header that escaped into the body.
5. **Polish.** Align to the grid, kill jitter, run the checklist.

## Geometry and brand layouts

Geometry below is **Tier N**: inches on a 13.333 × 7.5 canvas, content band
y 1.30 – 6.60. Read the numbers as proportions.

**Tier B — a brand template exists:** do not build any of these from
coordinates. Map each archetype onto the **nearest real template layout** and
fill its placeholders; the archetype then only tells you what goes in which slot.
Typical mapping:

| Archetype here | Typical template layout |
|---|---|
| Cover | Title slide (dark, or image variant) |
| Section divider | Section header (dark / light / image) |
| Chart + observations, custom graphics | Title Only / blank content layout |
| Two-up comparison, A-vs-B | Two-content layout |
| Text with supporting picture | Text-and-image (left / right) layout |
| Headline metrics | Fact-tile or number layout, if the brand has one |
| Closing, thank-you | Call-to-action + closing layout |

Only build free-form where the brand offers a layout meant for it. Take
coordinates from the brand grid tokens, never from this file.

---

## Structural slides

### R1 — Cover
Title (28–32pt), subtitle, client/department, date, author or firm mark. Date is
the **meeting date**, not today. No stock imagery unless the brand supplies it.

### R2 — Executive summary
The whole answer on one page. Two forms:

- **SCR narrative:** three labelled blocks — Situation, Complication,
  Resolution — each a bold lead sentence plus 2–3 supporting bullets.
- **Three-pillar:** three bold takeaways, each with 2–3 sub-bullets, closing
  with a single bold recommendation line at the bottom.

Slots: `header` (11pt bold) × 3, `takeaway` (bold, 1 line) × 3, `support`
(2–3 bullets) × 3, `recommendation` (bold, full width, bottom).
Geometry: 4/4/4 split, recommendation bar full width at y ≈ 5.90.

### R3 — Agenda / contents
Numbered sections, no page references — they break the moment a slide moves.
Reappears as a section divider with the current section in accent, the rest
muted.

### R4 — Section divider
Section number, section name, and the one-line takeaway of the section. A
divider that carries no message is a wasted page.

---

## The workhorses

### A1 — Chart + observations (8 / 4)
**Use for:** a trend, a comparison, or a breakdown that needs interpretation.
This is the most-used consulting layout in existence.

| Slot | Geometry | Spec |
|---|---|---|
| Kicker + action title | 0.50, 0.28 | `Analysis name \| insight sentence` |
| Chart sub-header | 0.50, 1.30 | Insight-bearing, not "Revenue, EUR mn" |
| Unit line | 0.50, 1.58 | `Revenue, EUR mn` — 8pt muted |
| Chart | 0.50, 1.85, w 8.17, h 4.20 | Direct labels, no legend, one accent series |
| Column header | 8.82, 1.30 | `Key observations` — 11pt bold |
| Observations | 8.82, 1.62, w 4.01 | 3–5 bullets, one idea each, max 1 sub-level |
| Source | 0.50, 6.95 | 7pt muted |

Rules: annotate the chart itself (CAGR brackets, delta labels, callout bubbles)
rather than describing it in the bullets. The bullets carry *why*, the chart
carries *what*.

### A2 — Two-up comparison (6 / 6)
Two charts, two periods, or two scenarios side by side. Identical axes, identical
scales, identical colors. A shared bracket or delta label between them states the
comparison. Sub-headers form one sentence split by `…` when the halves are
evidence-then-consequence.

### A3 — Assessment table (rows × dimensions)
**Use for:** N items evaluated on M criteria. The backbone of capability
assessments, option evaluations and vendor comparisons.

Structure: a numbered badge column (0.35 wide circles, primary fill, white
number), a criterion-name column (11pt bold, ~1.9 wide), and 1–3 evidence
columns. Row separators are hairlines only — no boxes, no zebra fill. Header row
may take the panel fill; body rows sit on plain background.

Cap at 6 rows. Beyond that, group into 2–3 labelled clusters or move detail to
the appendix.

### A4 — Harvey balls / traffic lights
Same as A3 but one column carries a rating glyph. Define the legend once, top
right, 7pt. Four-state Harvey balls (empty / quarter / half / full) beat a
5-point scale nobody can read at 9pt. Traffic lights only where the semantics
really are stop/caution/go.

### A5 — A-vs-B comparison with implications
**Use for:** two mutually exclusive strategic paths.

Two equal columns (6/6) with a header band each (`Supporting function` /
`Independent trading business`), 2–3 bullets of definition, then a **shared
implications row** spanning the full width beneath, labelled on the left
(`Implications on the BU`). The shared row is what makes it a decision slide
rather than a description.

### A6 — Three / four / five pillars
Equal columns, each: icon or number badge, header (11pt bold), 2–3 bullets.
Uniform column heights — ragged bottoms are the clearest tell of an unedited
slide. Five columns is the ceiling; six becomes a clothesline.

---

## Process, time and sequence

### P1 — Chevrons / numbered steps
3–6 stages, left to right. Stage name in the chevron, supporting text below it,
never inside. Use when there are no dates.

### P2 — Timeline / roadmap
Horizontal time axis with period labels (`1Q2019`, `2Q2019`…). Milestones as
markers with a short label and date. Include a **"We are here"** marker — it is
the single most-read element on a status slide. A side or bottom block lists
what has happened since the last checkpoint.

### P3 — Gantt / workplan
Rows = workstreams, columns = weeks or months. Bars in primary, current-phase
bar in accent. Milestone diamonds. Owner column on the left. Keep to one page;
a two-page Gantt has too much detail for the meeting.

### P4 — Funnel / multi-stage refinement
**Use for:** narrowing a long list to a short one. Stages across the page with
the count at each stage, and an `Inputs` band beneath listing the evidence base
(interviews, benchmarks, data, workshops). Ends at the shortlist.

---

## Conceptual and structural

### C1 — Framework / structure page (hub + spokes)
A central concept with 5–7 surrounding elements, each a label plus a
one-sentence definition or question. Introduces a model the rest of the section
will use. **Always follow it with a tracker**: repeat the framework marker,
highlighted, on each subsequent slide so the audience can locate itself.

Also the right layout for a "questions to answer" page — each spoke is a
question, the whole page is the agenda for the next phase.

### C2 — Issue tree / driver tree
Left-to-right decomposition. Keep it MECE and stop at two levels on a
presentation slide. Level-1 boxes in primary, level-2 in tint, the branch you
will pursue in accent. Trend arrows or Harvey balls on the leaves turn a
structural tree into an analytical one.

### C3 — 2×2 matrix
Axes labelled with the actual dimension and direction. Quadrants named, not
just numbered. Items plotted as labelled dots — no more than ~10. The recommended
quadrant gets the accent; the rest are grey. If you cannot defend an item's
position, it does not go on.

### C4 — Waterfall / bridge
Start bar, driver bars, end bar. Increases and decreases visually distinct.
Label every bar with its value; label the start and end with the total. This is
the correct chart for "why did the number change" and it is under-used.

### C5 — Stakeholder / ecosystem map
Groups as labelled clusters, with the role of each group stated beneath. For
named-person lists (steering committees, project teams), organise by
organisation type and cap visible names — overflow goes to appendix.

### C6 — Org chart
Boxes with role and name, hierarchy by row. Highlight the roles being added or
changed in accent. Never render more than three levels.

---

## Decision and closing

### D1 — Initiative / recommendation table
Columns: **initiative — rationale — impact — owner — by when.** Rows numbered.
This is the page the meeting actually acts on. A category key (colour or letter)
in the corner lets one table cover several workstreams.

### D2 — Impact quantification
Left: the build-up chart (workers, savings, revenue) with conservative and
aggressive cases. Right: qualitative benefits list. Bottom right: the headline
number in a large callout (`$0.5B – $1B in annual economic value`). Footnote the
assumption behind the headline number, always.

### D3 — Next steps / decision needs
Task, owner, deadline, and — separately — what the audience must decide today.
Explicitly list the decisions as questions. Last page of any deck that expects
action.

### D4 — Question grid ("food for thought")
5–6 open questions arranged around a centre, each with a label and the question
in full. Mark `For discussion`. Correct when the analysis is genuinely
incomplete; dishonest when used to dodge a conclusion you could have reached.

---

## Elements that attach to any archetype

- **Callout bubble** — a remark tied to one chart element, with a leader line.
- **Takeaway box** — a single bordered or tinted strip carrying the conclusion,
  usually bottom of the content band.
- **Bracket + delta** — `~2x`, `+3% CAGR`, drawn on the chart between the two
  values being compared. Cheapest way to make a chart argue.
- **Number badges** — small filled circles numbering rows or elements, so the
  discussion can reference "point 3".
- **Status sticker** — `Preliminary` / `Indicative` / `Illustrative` /
  `For discussion`, top-right, 7–8pt. Use honestly; it protects credibility.
- **Chapter tracker** — section name top-right or a mini-TOC strip, current
  section in accent.

## Density limits

| Archetype | Max elements |
|---|---|
| Pillars / columns | 5 |
| Assessment table rows | 6 |
| Bullets per block | 5 (min 2 — a single bullet is prose) |
| Items on a 2×2 | 10 |
| Chart series | 4 named, or grouped as "other" |
| Process stages | 6 |

Above the limit, group into labelled clusters (three groups of two beat one list
of six) or move to the appendix. Ungrouped lists of 5+ parallel items —
"clotheslines" — are the most common structural failure in draft decks.
