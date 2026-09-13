# M001: The paper has a sourced outline in JOSS's required structure

**Status:** done (2026-09-13, PR #1 https://github.com/jmgirard/intraclass-paper/pull/1)

**Goal:** `paper/paper.md` and `paper/paper.bib` hold an outline of the JOSS paper: every required section, a word budget per section, and bullets stating each claim with its source.

**Outcome:** `paper/paper.md` has JOSS front matter for the sole author and the eight required sections, with word budgets totaling 1300. Each one-line bullet ends in one `[src: …]` marker: an intraclass file at 497d617, a URL, the maintainer, or `to gather`. The four research-impact bullets are all `to gather`. `paper/paper.bib` holds 10 entries, one per cited key, taken from `citation()` output. The budget lines and markers are scaffolding for the drafting milestone to remove.

**Decisions:** The implement gate chose the DESCRIPTION-based title, the author form "Jeffrey M. Girard" (the package `inst/CITATION` says "Jeffrey Girard"), a date to refresh at submission, and four extra citations: intraclass, tenhove2022, brms, and lavaan.

**Review:** Full three-lens fan-out, with all seven criteria passing on fresh evidence. The blame-history and prior-review lenses found nothing. The diff lens reported 8 findings. F1 was fixed now: the outline said psych needs complete data, but `psych::ICC` fits with `lmer` by default and used all 6 subjects of `ratings_incomplete`. F2, F3, F5, and F6 were overstated bullets, narrowed now. F4, the untested irrICC agreement claim, was added to the drafting candidate row. The vignette's psych error became a new candidate row. F7 (author name form) and F8 (psych version) were rejected. Nothing graduated or retired.
