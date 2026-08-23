# Brand Philosophy Template

Use this template when scaffolding `brand/brand-philosophy.md` for a project's visual
identity. Fill every bracket; delete guidance notes when done.

This file is a **hand-authored project asset**: durable config, edited directly and committed
to git. If the host repo has a generated knowledge base or docs pipeline, this file is not
part of it — never route it through that tooling.

---

# Brand Philosophy: [Brand / Project Name]

## Brand Assets

### Logo
- **Primary logo**: `assets/[logo-filename].png` *(PNG or JPG — SVG not supported by rasterized outputs like PPTX/PDF; keep an SVG master too if you have one)*
- **Logo description**: [e.g., "Gradient wordmark with abstract dynamic icon"]
- **Clear space**: [Minimum padding around logo]
- **Minimum size**: [Smallest legible size]

## Visual Identity

### Colors
| Role | Color | Hex Code | Usage |
|------|-------|----------|-------|
| Primary | [Color name] | #XXXXXX | Main brand color, CTAs, headers |
| Secondary | [Color name] | #XXXXXX | Supporting elements, accents |
| Tertiary | [Color name] | #XXXXXX | Backgrounds, subtle highlights |
| Text | [Color name] | #XXXXXX | Body text, readable content |
| Background | [Color name] | #XXXXXX | Page backgrounds, containers |

### Text Colors (Contrast-Validated)
| Context | Hex Code | Contrast Ratio | Source |
|---------|----------|----------------|--------|
| Text (light bg) | #XXXXXX | ≥4.5:1 vs white | [from palette or derived] |
| Text (dark bg) | #XXXXXX | ≥4.5:1 vs black | [from palette or derived] |

*Validated for WCAG AA. Use these for all text regardless of palette choice.*

### Typography
| Role | Font | Fallback | Usage |
|------|------|----------|-------|
| Heading | [Font name] | [Sans-serif/Serif] | Headlines, titles, emphasis |
| Body | [Font name] | [Sans-serif/Serif] | Paragraphs, readable content |
| Accent | [Font name] | [Monospace/Display] | Code, callouts, special text |

### Font Files (if available)
| Font | File Path | Format |
|------|-----------|--------|
| [Font name] | `assets/fonts/[filename].ttf` | TTF |
| [Font name] | `assets/fonts/[filename].otf` | OTF |

### Imagery Style
- **Photography**: [e.g., "Bright, natural lighting with human subjects"]
- **Illustrations**: [e.g., "Flat, geometric icons with brand colors"]
- **Graphics**: [e.g., "Clean lines, minimal decoration"]
- **Mood**: [e.g., "Professional yet approachable"]

## Verbal Identity

### Voice Personality
The brand voice is: **[Trait 1]**, **[Trait 2]**, **[Trait 3]**

### We Sound Like
[e.g., "A knowledgeable friend who explains complex topics simply. Confident but never arrogant. Direct but warm."]

### We Never Sound Like
[e.g., "Salesy, pushy, jargon-heavy. Never condescending or overly formal."]

### Key Vocabulary
**Words we use:**
- [Word/phrase 1]
- [Word/phrase 2]

**Words we avoid:**
- [Word/phrase 1]
- [Word/phrase 2]

## Core Principles

### Always
- [Principle 1 — e.g., "Lead with value before asking for anything"]
- [Principle 2 — e.g., "Show, don't tell — use visuals to communicate"]

### Never
- [Anti-pattern 1 — e.g., "Never use stock photos with obvious watermarks"]
- [Anti-pattern 2 — e.g., "Never create walls of text"]

## Alternative Palettes (optional)
*Populated by `/brand-palette`. Derived (color-theory) or mood-based alternatives.*

## Brand Story (Optional)
[Brief narrative about the brand's mission, origin, or purpose. 2-3 sentences.]

---

*Project: [project slug] · Last updated: [YYYY-MM-DD]*
