# M003: A committed script produces the comparison figures the paper reports

**Status:** done (2026-09-13, PR #3 https://github.com/jmgirard/intraclass-paper/pull/3)

**Goal:** `analysis/comparison.R` writes every comparison figure the paper cites to `analysis/comparison-results.csv`, together with the package versions that produced them.

**Outcome:** `analysis/comparison.R` runs intraclass 0.1.0 from CRAN, psych, irr, and irrICC on the shipped `ratings` and `ratings_incomplete` data. It writes 31 `name,value` rows. There are 5 version rows, 19 balanced rows with the largest gap, 2 irrICC rows, and 5 incomplete-data rows. Numeric values are rounded to 6 significant digits. Whole values have no decimals. For a missing package, a term that is not one row, or an intraclass that is not 0.1.0 from CRAN, the script stops. It sets `OutDec` to a period. A rerun leaves the committed file unchanged. Three bullets in `paper/paper.md` cite the file. They give the gap (7e-6), the irrICC agreement (6e-6), and 2 complete-case subjects. The `cairn/DESIGN.md` convention names the script as the source of comparison figures (D-001).

**Decisions:** CRAN intraclass 0.1.0 over the development version, because reviewers can install it. The cross-cutting source rule is D-001.

**Review:** Two passes, each a full three-lens fan-out. The first found F1 to F7. F2, F3, F5, and F6 were fixed, and F1, F4, and F7 went to a candidate row on stating gaps as a bound. F5 caused one amendment return on AC3, which after two re-audits reads "rounded to 6 significant digits" and lists all 31 rows. The second pass found G1 to G10. G5 (a stale DESIGN heading) was fixed, G1 (an RSPM repository field) went to a candidate row, and the rest were rejected because none changes the results file. Nothing graduated or retired.
