# M006: State of the field says why intraclass is a new package

**Status:** done (2026-09-13, PR #6 https://github.com/jmgirard/intraclass-paper/pull/6)

**Goal:** The State of the field section of `paper/paper.md` says why intraclass is a separate package and not a contribution to psych, irr, irrICC, or performance.

**Outcome:** State of the field adds 10 lines after the sentence that lists what intraclass brings together. psych: `ICC()` takes a column per rater, but `icc()` takes one rating per row. `mlr()` is for data such as items over time within subjects. irr: intraclass imports glmmTMB, which irr does not depend on. irrICC: one function per analysis-of-variance model, against one `icc()` call that takes the design as arguments. performance: the ICC is one of its model-quality measures, but it is the purpose of intraclass. Each fact comes from psych 2.6.5, irr 0.85, irrICC 1.0, performance 0.17.1, or intraclass 0.1.0 manuals. The paper has no new numbers and is 1330 words.

**Decisions:** Reasons were drafted from documented differences, for all four packages, with no limit claim that a manual does not state. The paper states no contact with other maintainers.

**Review:** Full three-lens fan-out. The diff-bug lens found D1 to D11, the blame-history lens B1 to B3, and the prior-review lens P1 to P3. None failed a criterion. At the gate the maintainer chose a rewrite for argument strength (D1 to D5, D9, B3). A fresh audit of the rewrite found a false claim that all intraclass parts take a rating data frame. `choose_icc()` takes none. That claim and two wordings were fixed before merge. All criteria were rerun. The other findings were rejected with reasons or noted. One lesson was added, and nothing retired.
