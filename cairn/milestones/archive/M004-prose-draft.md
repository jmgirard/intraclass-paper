# M004: The paper is drafted as prose within JOSS's length limit

**Status:** done (2026-09-13, PR #4 https://github.com/jmgirard/intraclass-paper/pull/4)

**Goal:** `paper/paper.md` holds finished prose for every section except the Research impact statement, within 750 to 1750 words.

**Outcome:** `paper/paper.md` has prose for Summary, Statement of need, State of the field, Software design, AI usage disclosure, and Acknowledgements, 1081 words by `pandoc -t plain`. Research impact is still four `[src: to gather]` bullets. Claims about psych 2.6.5, irr 0.85, and irrICC 1.0 rest on their manuals or on `analysis/comparison-results.csv`. Claims about performance rest on its 0.17.1 manual. Claims about intraclass were read against its v0.1.0 source. Agreement with psych and irr is stated only for the balanced `ratings` example, as rounded CSV gaps (0.000007, 0.000006). `paper/paper.bib` has 12 entries, which add Shrout and Fleiss (1979), Gwet's 2014 handbook, and CRAN DOIs for intraclass and psych. The draft PDF built with 3 pages.

**Decisions:** Claims about performance rest on the 0.17.1 manual, because the results file records no performance version. The gaps are stated as rounded CSV values, not as a bound. Research impact stays with the submission candidate row.

**Review:** Two passes, each a full three-lens fan-out. The first pass found F1 to F19, H1 to H3, and P1. F1 (agreement claimed beyond the balanced example) failed AC5, which made defect return 1. Fifteen findings were fixed, F4 and the F2 remainder became candidate rows, and six were rejected. A fresh claim audit then corrected 3 of 51 claims. The second pass found R1 to R13, B1, B2, and no failing criterion. R2, R3, R5, R6, R8, R9, and B1 were fixed before approval. R1, R7, and G1 became or joined candidate rows, and six were rejected. One lesson was added, and nothing retired.
