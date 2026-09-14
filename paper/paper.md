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

intraclass [@intraclass] is an R package that estimates intraclass correlation coefficients (ICCs) for interrater reliability within generalizability theory.
It estimates the variance components with linear mixed models instead of the mean squares of a classical analysis of variance.
The package provides the full family of interrater ICCs.
The coefficient can measure absolute agreement or consistency, for single or average ratings, with random or fixed raters.
The raters can be crossed with the subjects, or each subject can have its own raters.
`icc()` can report an interval with each estimate, by default a Monte-Carlo interval in which no drawn variance is negative.
The package handles unbalanced, incomplete, and multilevel designs, and its multilevel methods follow @tenhove2022.
It also projects reliability to other numbers of raters with `d_study()` and recommends a coefficient for a stated design with `choose_icc()`.

# Statement of need

Researchers in the behavioral and clinical sciences often report an ICC to show that their raters give consistent scores.
The choice of coefficient is a modeling decision.
Do systematic differences between raters count as error?
Do later decisions rest on the score of a single rater or on an average?
Do the raters stand for a larger pool of possible raters?
intraclass is written for researchers who must make these choices and defend them in a report.
Its `choose_icc()` function names the recommended coefficient, gives the reason for each part of the choice, and prints the call that computes it.
Its documentation site teaches ICC practice as well as the use of each function.

Real rating data rarely fill a complete table of subjects by raters.
Raters miss sessions, and studies often assign different raters to different subjects.
Some tools then set data aside: irr [@irr], for example, omits incomplete subjects listwise.
The `ratings_incomplete` example ships with intraclass.
In it, only 2 subjects have a rating from every rater, but intraclass uses all 20 ratings of the 6 subjects.

Rating studies have further features that call for more than the classical formulas.
Subjects are often nested in clusters, such as pupils in classrooms or patients in clinics.
A study can then need reliability at the subject level or at the cluster level.
A variance component estimated at or near zero is also common in interrater data.
An interval for such a component must respect the zero boundary.

# State of the field

Several R packages compute ICCs.
irr [@irr] computes the classical agreement and consistency ICCs for single and average ratings, and it omits missing data listwise.
psych [@psych] computes the ICCs that @shrout1979 define, with confidence limits.
By default, psych fits them with `lmer()` from lme4 [@lme4], which handles missing values.
irrICC [@irrICC] computes the ICCs for inter-rater and intra-rater reliability that the handbook of @gwet2014 describes, under analysis-of-variance models.
performance [@performance] computes an ICC, which its manual also calls a variance partition coefficient.
It works from a mixed-effects model that the user fitted.

On the balanced `ratings` example, intraclass, psych, and irr computed ICC(1), ICC(k), ICC(A,1), ICC(A,k), ICC(C,1), and ICC(C,k).
The largest absolute difference between intraclass and either psych or irr was 0.000007.
The ICC(A,1) of intraclass differed by 0.000006 from the irrICC inter-rater reliability ICC under the random factorial model without subject-rater interaction.

On the `ratings_incomplete` example, psych and intraclass agreed on ICC(A,1) and ICC(C,1).
They differed on ICC(1), ICC(k), ICC(A,k), and ICC(C,k).
For the averaged coefficients ICC(k), ICC(A,k), and ICC(C,k), the psych values imply an averaging divisor of 4 raters.
intraclass sets that divisor to 3.27, the harmonic mean of the number of ratings per subject.
For ICC(A,k) and ICC(C,k), whose single-rating values agree, the divisor accounts for the whole gap.

intraclass is a separate package because its design differs from each of these packages.
psych is a general-purpose toolbox first developed for personality, psychometric theory, and experimental psychology.
Its `ICC()` takes a table of ratings with a column for each rater, but intraclass takes a data frame with one rating per row.
With an optional cluster column in that data frame, intraclass fits a multilevel ICC.
irr collects coefficients of interrater reliability and agreement for quantitative, ordinal, and nominal data, and it depends only on lpSolve.
intraclass imports glmmTMB, a package for mixed models, which is a dependency that irr does not have.
irrICC computes its coefficients under analysis-of-variance models, but intraclass by default estimates the variance components with mixed models.
performance computes model-quality measures for many kinds of regression models, and its `icc()` starts from a model that the user fitted.
In intraclass, `icc()` fits the model from the rating design that the user states.

intraclass brings together mixed-model estimation for incomplete and multilevel designs, intervals that respect the zero boundary, and guidance on which coefficient to report.
For a balanced, complete design that needs only the classical coefficients, psych and irr remain direct choices.

# Software design

The public interface has three functions: `icc()`, `d_study()`, and `choose_icc()`.
`icc()` fits the model, estimates the coefficient, and computes its interval.
`d_study()` projects a fitted coefficient to other numbers of raters.
`choose_icc()` recommends a coefficient for a stated design.
The results work with `tidy()` and `glance()` from the generics package, so they fit into tables and plots.

Four estimation engines sit behind the `engine` argument of `icc()`: glmmTMB [@glmmTMB], lme4 [@lme4], brms [@brms] for Bayesian fits, and lavaan [@lavaan] for structural-equation fits.
glmmTMB is the default and the only engine that intraclass imports.
The other engines are suggested packages.
glmmTMB estimates each variance component on a log standard-deviation scale, where the parameter has no lower bound.
lme4 fits the same restricted maximum likelihood model, and the tests fit lme4 directly as an independent check on the default.

With the frequentist engines, the default interval draws the variance parameters on that log scale.
It transforms the draws back, so each variance drawn on that scale is positive.
Any negative draw of a rater variance computed from drawn rater means is set to zero.
A user can choose other interval methods, such as a parametric bootstrap, with the `ci_method` argument, and brms fits give a posterior credible interval.
Near the boundary the default interval can fail, and `icc()` then stops with an error and returns no interval.
Before it stops, the package runs some of the interval methods that the design allows on the same data.
The error message names only a method that gave a usable interval.
Some designs do not identify the model, for example ratings that split into groups with no subject or rater in common.
Such a design stops with a classed error condition that names the problem.

The test suite checks each estimator against independent oracles of several types.
A standing test matrix covers each combination of coefficient and frequentist engine.
It checks that the frequentist engines agree on point estimates and that every documented engine refusal occurs.

The output never labels a coefficient as poor, good, or excellent.
The guidance covers which coefficient to report and how to read its interval, and the judgment of adequacy stays with the researcher.

# Research impact statement

- CRAN download counts for intraclass since its first release. [src: to gather]
- Published studies or preprints that cite or use intraclass. [src: to gather]
- Issues, questions, and feature requests from users outside the maintainer's group. [src: to gather]
- Use of the package or its documentation in teaching, workshops, or methods guidance. [src: to gather]

# AI usage disclosure

The author used Claude Code (Anthropic), a generative AI coding tool, to help write the package code, its tests, its documentation, and this paper.
The author reviewed each milestone and bug fix before it was merged.
Numerical correctness does not rest on that review alone, because the test suite checks each estimator against independent oracles of several types.

# Acknowledgements

The author received no specific funding for this work.

# References
