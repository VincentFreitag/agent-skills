# Chart craft

## Pick the chart from the comparison, not the data

Name the comparison in the message first, then read off the chart.

| Comparison in the message | Chart |
|---|---|
| Share of a whole | Stacked column, or 100% stacked bar. Pie only for ≤4 slices |
| Absolute comparison of items | Bar, sorted descending |
| Change over time | Line (many points) or column (few points) |
| How a number changed / decomposed | **Waterfall** |
| Two variables related | Scatter |
| Three variables related | Bubble (x, y, area) |
| Distribution | Histogram column |
| Contribution over time | Stacked column with CAGR labels per band |
| Range or uncertainty | High-low, or two-case bands (conservative / aggressive) |
| Ranking movement | Slope chart or paired bars |
| Sensitivity | Tornado |

Waterfalls are under-used and disproportionately persuasive. Any slide answering
"why did this number move" should default to one.

## Chart anatomy — all seven, every time

1. **Insight sub-header** — "EBIT margin declines despite growth", not
   "EBIT margin, %".
2. **Unit line** — `EUR mn`, `% of revenue`, `FTE`. Separate, 8pt, muted.
3. **Period** — explicit, including whether values are actual or forecast
   (`2025F`).
4. **Direct labels** — on the bars, lines and segments. Never make the reader
   cross-reference a legend. Drop the legend entirely for ≤3 series.
5. **The highlight** — one series, bar or point in accent; everything else in
   greys or primary tints.
6. **Annotation** — CAGR bracket, delta, or callout stating the story.
7. **Source line** — 7pt, bottom left, on every slide carrying data.

## Craft rules

- **Sort.** Descending by value unless the category has an inherent order (time,
  process stages, agreed segment order). Unsorted bars are unread bars.
- **Zero baseline on bars and columns.** Always. Truncate a line chart's axis
  only when the variation genuinely demands it, and mark the break.
- **Kill the frame.** No chart border, no vertical gridlines, horizontal
  gridlines in hairline grey or removed entirely when values are directly
  labelled. No axis line where labels already imply it.
- **No 3D, no shadows, no gradients on data.**
- **No screenshots of charts.** They cannot be re-highlighted, clash with the
  deck, and pixelate. Rebuild natively.
- **Consistent segment order and colour** across every chart in the deck. If
  "Logistics" is the third band in light tint on slide 4, it is on slide 12.
- **Round honestly.** One decimal at most on a slide; keep full precision in the
  model, not the page.
- **Forecast versus actual** must be visually distinct — a lighter tint or a
  hatched pattern with the boundary labelled.

## Two-case projections

When showing a range (conservative / aggressive, base / upside), plot both as
lines or paired columns, label each case at its endpoint, and put the headline
number in a callout with the assumption footnoted. Never present a single line
for something that is genuinely a range.

## Data tables

Use a table only when the audience will look values up. If the point is a trend
or comparison, it is a chart.

- Numbers right-aligned, text left-aligned, headers matching their column's
  alignment.
- Column headers one or two words.
- Highlight the one row or cell carrying the message; grey the rest.
- Hairline row separators only; no vertical rules, no full grid, no zebra.
- Units in the header (`Revenue, EUR mn`), never repeated in every cell.
- One number format for the whole deck: pick `1,412.84` or `1.412,84` and
  never mix. Same for units: `EUR 100` or `100 EUR`, pick one.

## Colour: take it from the brand, do not choose it

In Tier B the series palette comes from the brand tokens (`chart.seriesOrder`)
and its banned effects from `chart.forbidden`. Two rules on top of the brand's
own order:

- **Grey everything, colour the one series that carries the message.** Blindly
  cycling the theme's accent slots produces a rainbow in which nothing is
  emphasised.
- **The highlight colour depends on the background.** Where a brand has
  polarity (a colour legal only on dark, another only on light), resolve the
  accent per slide against the brand's contrast table. The same chart on a dark
  divider and a light content page uses different hexes.

Keep segment colours constant deck-wide: if a category is the third band in a
light tint on slide 4, it is the same on slide 12.

## Building charts natively

Native charts for anything PowerPoint can chart — a rendered image cannot be
edited by the client, and clients always edit. Only Sankey, chord and network
diagrams justify an image.

### python-pptx (the template-derived path)

```python
from pptx.chart.data import CategoryChartData
from pptx.enum.chart import XL_CHART_TYPE, XL_LABEL_POSITION
from pptx.util import Cm, Pt
from pptx.dml.color import RGBColor

data = CategoryChartData()
data.categories = ["2022", "2023", "2024"]
data.add_series("Revenue", (312.0, 348.0, 351.0))

gf = slide.shapes.add_chart(XL_CHART_TYPE.COLUMN_CLUSTERED,
                            Cm(1.14), Cm(4.23), Cm(20.0), Cm(10.0), data)
ch = gf.chart
ch.has_title = False                      # the sub-header is a text box you control
ch.has_legend = False                     # direct-label instead
plot = ch.plots[0]
plot.has_data_labels = True
plot.data_labels.font.size = Pt(9)
plot.data_labels.position = XL_LABEL_POSITION.OUTSIDE_END
ch.value_axis.has_major_gridlines = False
ch.category_axis.has_major_gridlines = False

for i, pt in enumerate(plot.series[0].points):        # grey all, accent one
    pt.format.fill.solid()
    pt.format.fill.fore_color.rgb = ACCENT if i == 2 else NEUTRAL
```

Traps: `position` must be an inside variant on stacked types; a chart placed in a
placeholder inherits the template's chart style, which is usually what you want —
check before overriding it; and `plot.gap_width` defaults wide (150), so set
~40–60 for a dense column chart.

### pptxgenjs (the from-scratch path)

Defaults render badly; set explicitly:

```js
{
  showTitle: false,                       // the sub-header is a text box you control
  showLegend: false,                      // direct-label instead
  showValue: true, dataLabelPosition: "outEnd",
  dataLabelFontSize: 8, dataLabelFontFace: FONT,
  chartColors: [PRIMARY, TINT1, TINT2, TINT3],
  catAxisLabelColor: MUTED, valAxisLabelColor: MUTED,
  catAxisLabelFontSize: 8, valAxisLabelFontSize: 8,
  catGridLine: { style: "none" },
  valGridLine: { color: HAIRLINE, size: 0.5 },
  border: { pt: 0 },
}
```

Traps that corrupt the file or silently break the chart — an installed `pptx`
skill has the full list, but these bite chart work specifically:

- On **stacked** bars/columns, `dataLabelPosition` must be `ctr`, `inEnd` or
  `inBase`. `outEnd` corrupts the file.
- A combo series using `secondaryValAxis` needs **both** `valAxes` and `catAxes`
  declared with two entries each, or PowerPoint discards the chart.
- Colors are 6-digit hex with **no** `#` and no alpha.
- Waterfalls have no native pptxgenjs type: build with a stacked bar where the
  lower series is a transparent spacer (`chartColors` entry + per-series
  transparency), or draw as shapes on the grid.

Render every chart slide to an image and look at it before shipping — labels
colliding with bars, a legend you thought you disabled, and a truncated axis
label are all invisible in the generator and obvious in the render. See
`build-and-production.md`.
