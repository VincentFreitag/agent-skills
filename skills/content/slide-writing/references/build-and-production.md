# Build and production

How the file actually gets written. The design decisions are already made by
this point: storyline approved, brand resolved (`brand-and-template.md`),
archetype chosen per slide.

**Rule of the whole document: derive the deck from the brand template.** Building
beside a template always looks adjacent-to-brand rather than on-brand, and the
gap is visible to anyone who works with the real deck every day.

---

## Path A — template-derived (default whenever a template exists)

`python-pptx`, starting from the brand's `.potx`/`.pptx`.

### If the brand ships a helper, use it

A mature `brand/` folder often carries `brand/tools/<brand>_deck.py` with the
template plumbing already solved and verified — layout indices, placeholder
indices, and the `.potx` content-type workaround. Import it instead of
re-deriving any of that:

```python
import sys; sys.path.append("brand/tools")
from brand_deck import base_presentation, add, LAYOUT, PH   # names vary by project

prs = base_presentation()          # template opened, sample slides removed,
                                   # master / theme / layouts / embedded fonts intact
s = add(prs, "title_dark")
s.shapes.title.text = "..."
s.placeholders[PH["subtitle"]].text = "..."
prs.save("deck.pptx")
```

Check the module and the build guide for the layout and placeholder maps before
writing anything. They are verified; your guess is not.

### If there is no helper: the `.potx` trap

`python-pptx` refuses a `.potx`:

```
ValueError: ... is not a PowerPoint file, content type is
'…presentationml.template.main+xml'
```

Only the content type differs. Rewrite it into a `.pptx` copy — the payload stays
bit-identical, so master, theme, layouts and embedded fonts survive:

```python
import shutil, zipfile
from pathlib import Path

TPL_CT = "application/vnd.openxmlformats-officedocument.presentationml.template.main+xml"
PPT_CT = "application/vnd.openxmlformats-officedocument.presentationml.presentation.main+xml"

def potx_to_pptx(src: Path, dst: Path) -> Path:
    with zipfile.ZipFile(src) as zin, zipfile.ZipFile(dst, "w", zipfile.ZIP_DEFLATED) as zout:
        for item in zin.infolist():
            data = zin.read(item.filename)
            if item.filename == "[Content_Types].xml":
                data = data.replace(TPL_CT.encode(), PPT_CT.encode())
            zout.writestr(item, data)
    return dst
```

Then delete the template's own sample slides (a template usually ships 20–30 of
them) before adding your own, and keep the layouts.

### Fill placeholders, do not float text boxes

| Do | Why |
|---|---|
| `slide.placeholders[idx]` and set text | Placeholder brings position, size, font, colour and theme binding with it |
| Free `add_textbox()` | Brings none of that. Every value becomes a hard-coded guess you must maintain |

Only use a free shape where the brand provides a deliberately empty layout
(Title Only / Blank) for custom graphics — and then take geometry from
`brand.tokens.json` (`grid`) and colours from theme slots
(`MSO_THEME_COLOR`), not raw RGB, so the theme binding survives.

### The traps that actually bite

- **Paragraph level is not inherited.** `text_frame.add_paragraph()` starts at
  level 0 and takes level 0's size. On tile or fact layouts that means a label
  rendering at the number's 90pt and blowing the box apart. Set `p.level = n`
  explicitly on every paragraph.
- **Runs, not paragraph text, for mixed styling.** Bold lead-in labels and accent
  words need `p.add_run()` per segment; setting `p.text` collapses them.
- **Fonts by family, respecting the brand's traps.** Where the emphasis face is a
  separate family, set `run.font.name` to that family; never set `bold=True` on a
  face that has no bold cut.
- **Footer, date and page number are not automatic.** `python-pptx` does not
  create those placeholders. Either write them yourself from the grid values, or
  finish in PowerPoint with `Insert > Header & Footer > Apply to All`. Say which
  you did.
- **Structural work first.** Add, delete and reorder slides *before* editing any
  content. Never copy a slide part by hand.
- **Template placeholder text.** Grep the output for the template's own
  boilerplate (`Footer (Insert > Header & Footer to edit)`, `Lorem`, `Click to
  edit`) before declaring done.
- **Odd template sizes.** Templates rescaled between formats carry sizes like
  15.97pt or 20.54pt. Use the round values from the brand type scale when setting
  sizes manually.

### Tables

Build with `shapes.add_table()`, then strip the Office table style: no banding,
no vertical rules, header row in the brand's header treatment, hairline row
separators only, numbers right-aligned. Set cell margins tight (0.05–0.1") or the
table will not fit the content band.

---

## Path B — from scratch

Only when no template exists. Either `python-pptx` on a blank presentation or
`pptxgenjs`. Whichever: define palette, grid and type scale as constants at the
top of the generator and reference them everywhere. A coordinate typed twice is a
jitter bug waiting to happen.

```js
// pptxgenjs
const pptx = new PptxGenJS();
pptx.defineLayout({ name: "16x9", width: 13.333, height: 7.5 });
pptx.layout = "16x9";
```

`pptxgenjs` specifics: colours are 6-digit hex with **no** `#`; on stacked series
`dataLabelPosition` must be `ctr` / `inEnd` / `inBase` (`outEnd` corrupts the
file); a secondary-axis combo needs both `valAxes` and `catAxes` declared with
two entries each. Full chart defaults in `chart-craft.md`.

If a dedicated `pptx` skill is installed in the project, **read it before writing
build code** — it wins on mechanics (API footguns, XML editing, validation). This
document wins on what gets built.

---

## Charts

Native charts, not images: the client will edit them, and an image cannot be
re-highlighted. Only Sankey, chord and network diagrams justify a picture.
Defaults render badly in both libraries — set them explicitly per
`chart-craft.md`, and take the series palette from the brand
(`chart.seriesOrder`), greying every series except the one carrying the message.

---

## Render and look — required before shipping

You cannot QA a deck by reading its generator. Render it and view every page.

**With PowerPoint installed (Windows):**

```powershell
$ppt = New-Object -ComObject PowerPoint.Application
$deck = $ppt.Presentations.Open("C:\path\deck.pptx", $true, $false, $false)
$deck.SaveAs("C:\path\deck.pdf", 32)      # 32 = ppSaveAsPDF
$deck.Close(); $ppt.Quit()
```

**With LibreOffice:**

```bash
soffice --headless --convert-to pdf deck.pptx
```

**PDF → images (PyMuPDF, no extra binaries):**

```python
import fitz
doc = fitz.open("deck.pdf")
for i, page in enumerate(doc):
    page.get_pixmap(dpi=110).save(f"_preview_p{i+1}.png")
```

Then read the images. The checklist for what to look for is in
`qa-and-review.md`.

Also grep the file for leftovers before shipping:

```bash
python -c "from pptx import Presentation;print('\n'.join(sh.text_frame.text for s in Presentation('deck.pptx').slides for sh in s.shapes if sh.has_text_frame))" \
  | grep -inE "lorem|ipsum|TODO|\[\[|\[insert|xx%|click to edit|header & footer"
```

---

## Handover

State, in the reply that delivers the deck:

- which design governs it (file + variant, per `brand-and-template.md`);
- which build path was used, and whether footer/page numbers still need the
  one-click PowerPoint step;
- which fonts the file specifies versus what the preview rendered with;
- every placeholder still open (`[[…]]`) and what it is waiting for;
- anything that was cut to hold the brand's minimum type size.
