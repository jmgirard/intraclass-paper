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
