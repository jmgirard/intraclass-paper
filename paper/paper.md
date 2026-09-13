---
title: "intraclass: Modern intraclass correlation coefficients for interrater reliability in R"
tags:
  - R
  - interrater reliability
  - intraclass correlation
  - generalizability theory
  - mixed models
authors:
  - given-names: Jeffrey M.
    surname: Girard
    orcid: 0000-0002-7359-3746
    affiliation: 1
affiliations:
  - name: University of Kansas, United States
    index: 1
date: 13 September 2026
bibliography: paper.bib
---

# Summary

Word budget: 150
- intraclass [@intraclass] is an R package that estimates interrater-reliability intraclass correlation coefficients (ICCs) within generalizability theory. [src: intraclass/DESCRIPTION]
- It estimates variance components from linear mixed models instead of classical ANOVA mean squares. [src: intraclass/DESCRIPTION]
- It covers the full ICC family: agreement or consistency, single or average, fixed or random raters, one-way or two-way. [src: intraclass/DESCRIPTION]
- Every coefficient comes with a boundary-aware Monte-Carlo confidence interval. [src: intraclass/README.Rmd]
- It handles imbalanced, incomplete, and multilevel designs, following ten Hove, Jorgensen, and van der Ark [@tenhove2022]. [src: intraclass/DESCRIPTION]
- It projects reliability to other numbers of raters with `d_study()` and helps users choose a coefficient with `choose_icc()`. [src: intraclass/README.Rmd]

# Statement of need

Word budget: 250
- The audience is applied behavioral and clinical researchers who must report a defensible ICC but do not yet know which one they need. [src: intraclass/cairn/DESIGN.md]
- Choosing the coefficient is a modeling decision: agreement or consistency, single or average, fixed or random raters. [src: intraclass/README.Rmd]
- Real rating data are often incomplete or unbalanced, and classical ANOVA ICCs need a complete subjects-by-raters rectangle. [src: intraclass/vignettes/comparison-with-other-packages.Rmd]
- Listwise deletion can leave too few subjects for a usable ICC, and the shipped `ratings_incomplete` example shows this. [src: intraclass/vignettes/comparison-with-other-packages.Rmd]
- Raters nested in clusters (pupils in classrooms, patients in clinics) need separate subject-level and cluster-level reliability. [src: intraclass/README.Rmd]
- Variance components near zero are common in interrater data, and normal-approximation intervals misbehave at that boundary. [src: intraclass/vignettes/comparison-with-other-packages.Rmd]
- The package's documentation site also teaches ICC practice, not only the function calls. [src: intraclass/README.Rmd]

# State of the field

Word budget: 250
- psych [@psych] and irr [@irr] compute the classical ICC family from ANOVA mean squares and assume balanced, complete data. [src: intraclass/vignettes/comparison-with-other-packages.Rmd]
- irrICC [@irrICC] implements Gwet's ICCs by a moment method and can fit incomplete data with its own model. [src: intraclass/vignettes/comparison-with-other-packages.Rmd]
- performance [@performance] returns a variance-partition coefficient, not the interrater ICC family or its agreement and consistency framing. [src: intraclass/vignettes/comparison-with-other-packages.Rmd]
- The largest gap between intraclass and psych or irr on the balanced `ratings` data is a figure for a committed script. [src: to gather]
- intraclass's ICC(A,1) reproduces the two-way random agreement coefficient of irrICC. [src: intraclass/vignettes/comparison-with-other-packages.Rmd]
- A capability matrix contrasts the four packages on incomplete data, multilevel reliability, boundary-aware intervals, fixed or random rater framing, and selection guidance. [src: intraclass/vignettes/comparison-with-other-packages.Rmd]
- psych and irr remain the right tools for balanced, complete designs that need only the classic coefficients. [src: intraclass/vignettes/comparison-with-other-packages.Rmd]

# Software design

Word budget: 350
- The public surface is `icc()` (fit, estimate, interval), `d_study()` (projection), `choose_icc()` (selection), and tidy S3 methods. [src: intraclass/cairn/DESIGN.md]
- Four estimation engines sit behind one interface: frequentist, frequentist oracle, Bayesian, and structural-equation. [src: intraclass/cairn/DESIGN.md]
- glmmTMB [@glmmTMB] is the default engine because it keeps a variance component positive on a log-SD scale, so boundary fits stay finite. [src: intraclass/cairn/DESIGN.md]
- lme4 [@lme4] is an alternate engine and an independent oracle for the default. [src: intraclass/cairn/DESIGN.md]
- brms [@brms] adds Bayesian fits and lavaan [@lavaan] adds structural-equation fits, both optional. [src: intraclass/cairn/DESIGN.md]
- Optional engines stay in Suggests behind an install check, which keeps the default install light. [src: intraclass/cairn/DESIGN.md]
- The default interval draws Monte-Carlo samples from the parameter covariance on the engine's log scale, so it is boundary-aware by construction. [src: intraclass/cairn/DESIGN.md]
- Bootstrap and posterior intervals are selectable, and each method documents how it treats a variance at zero. [src: intraclass/cairn/DESIGN.md]
- Ill-posed designs fail through classed error conditions that name the problem and a remedy. [src: intraclass/cairn/DESIGN.md]
- Every estimator traces to a published primary source and agrees with at least two independent oracles. [src: intraclass/cairn/DESIGN.md]
- A test matrix holds point-estimate agreement across engines for every estimand. [src: intraclass/cairn/DESIGN.md]
- Output never labels an ICC as poor, good, or excellent, and guidance covers which coefficient to report. [src: intraclass/cairn/DESIGN.md]

# Research impact statement

Word budget: 150
- CRAN download counts for intraclass since its first release. [src: to gather]
- Published studies or preprints that cite or use intraclass. [src: to gather]
- Issues, questions, and feature requests from users outside the maintainer's group. [src: to gather]
- Use of the package or its documentation in teaching, workshops, or methods guidance. [src: to gather]

# AI usage disclosure

Word budget: 100
- Generative AI (Claude Code) helped write the software, the documentation, and this paper. [src: maintainer]
- The maintainer reviewed every change before it reached the default branch. [src: maintainer]
- Numerical correctness rests on tests that check each estimator against at least two independent oracles. [src: intraclass/cairn/DESIGN.md]

# Acknowledgements

Word budget: 50
- People and funding to acknowledge, as the maintainer names them. [src: maintainer]

# References
