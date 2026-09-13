# Design

<!-- Seeded by /cairn-init (2026-09-10, greenfield scaffold run from the
     intraclass M149 session). Refine with /design-interview. -->

## Purpose & Scope

This repository drafts the companion software paper for the R package
`intraclass` (<https://github.com/jmgirard/intraclass>), which estimates
interrater-reliability intraclass correlation coefficients within the
generalizability-theory framework using mixed-model variance-component
estimation. The paper targets the Journal of Open Source Software (JOSS): a
short software paper (750–1750 words) with a statement of need, a research
impact statement, and references. The package's comparison-with-other-packages
article is the paper's seed. The package itself, its code, and its
documentation stay in the package repository; this repository holds only the
paper and what produces it.

**Distribution ambition (greenfield opener, 2026-09-10):** a tagged public
release — the JOSS submission, and the accepted paper with its DOI. Not an
internal-only document.

## Function families

None: this repository holds a paper, not code. The expected files are
`paper/paper.md`, `paper/paper.bib`, and a workflow that renders the draft
PDF; each arrives with its own milestone.

## Conventions

- **Numeric work needs oracle verification (greenfield opener, 2026-09-10):**
  every number the paper reports is produced by a committed script run against
  a named `intraclass` version, never transcribed by hand; the package's own
  oracle-verified test values are the source of any comparison figure.
- The paper text is licensed CC BY 4.0 (`LICENSE.md`).
- JOSS's co-location rule is met at submission by copying `paper/` onto a
  never-merged `joss-paper` branch of the package repository (package
  repository decision D-045); this repository never holds the package.
- User-facing text never references milestone numbers.

## Design principles

None elicited yet. `/design-interview` elicits the IP (inviolable) and GP
(guiding) principles; the numbering rules in the tracking rulebook apply.

## Architecture

A single Markdown paper with a BibTeX bibliography. The workflow
`.github/workflows/draft-pdf.yml` renders it to PDF with the JOSS draft-PDF
GitHub Action. A push that changes `paper/**` or the workflow file starts it,
and a manual run starts it on any branch. The PDF is the Actions artifact
named `paper`.

## Known issues

None recorded — observed 2026-09-10.
