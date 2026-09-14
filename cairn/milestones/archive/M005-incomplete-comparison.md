# M005: The paper's comparison with psych and irrICC rests on script rows for incomplete data and the no-interaction model

**Status:** done (2026-09-13, PR #5 https://github.com/jmgirard/intraclass-paper/pull/5)

**Goal:** `analysis/comparison-results.csv` records psych's and intraclass's six estimates on `ratings_incomplete` and irrICC's no-interaction coefficient on `ratings`, and `paper/paper.md` states the comparison from those rows.

**Outcome:** `analysis/comparison.R` writes 15 new rows. Twelve are `incomplete_psych_<c>` and `incomplete_intraclass_<c>` for the six coefficients. `incomplete_psych_k` is the Spearman-Brown k from psych's ICC2 and ICC2k, rounded to 6 places (value 4). `irricc_nointer_icc2r` and `irricc_nointer_abs_diff_ICCA1` come from `irrICC::icc2.nointer.fn`. They replace the `icc2.inter.fn` rows, and the value is unchanged at 0.289764. State of the field says psych and intraclass agree on ICC(A,1) and ICC(C,1) and differ on ICC(1), ICC(k), ICC(A,k), and ICC(C,k). It gives the averaging divisors 4 (psych) and 3.27 (intraclass `k_eff`, a harmonic mean). It says the divisor is the whole ICC(A,k) and ICC(C,k) gap. The irrICC sentence names the model without subject-rater interaction. The "psych reported 6 subjects" sentence is gone. The paper is 1143 words, and an independent R session matched all 15 rows.

**Decisions:** The interaction-model irrICC rows were replaced, not kept. The averaged-coefficient gap is explained by each package's divisor, and no cause is given for the ICC(1) gap. The Statement of need stays unchanged.

**Review:** Implement-side claim audit read 8 claims and corrected 1 (divisor wording). Review ran a full three-lens fan-out. The blame-history and prior-review lenses found nothing. The diff-bug lens found D1 to D14, and none failed a criterion. D1 (divisor sentences read as the cause of the ICC(k) gap), D3 (floating-point residue in the k row), and D8 (repeated word) were fixed before merge, with criteria rerun. The rest were rejected with reasons, and D14 was noted. One lesson was added, and nothing retired.
