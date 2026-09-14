# Comparison figures for the intraclass paper.
#
# Run from the repository root:
#   Rscript analysis/comparison.R
#
# The script writes analysis/comparison-results.csv with columns name,value.
# Non-integer values are written to 6 significant digits, trailing zeros kept.
# Whole-valued numbers (such as counts) are written without decimals. Only
# point estimates are written, because interval bounds depend on Monte-Carlo
# draws.
# Adapted from the vignette comparison-with-other-packages.Rmd in the
# intraclass package (validation, irrICC, and incomplete-data chunks).

pkgs <- c("intraclass", "psych", "irr", "irrICC")
missing_pkgs <- pkgs[!vapply(pkgs, requireNamespace, logical(1), quietly = TRUE)]
if (length(missing_pkgs) > 0) {
  stop("Install these packages before running the script: ",
       paste(missing_pkgs, collapse = ", "), call. = FALSE)
}

# The paper reports figures for the CRAN release of intraclass 0.1.0.
intraclass_version <- as.character(packageVersion("intraclass"))
intraclass_repository <- packageDescription("intraclass")$Repository
if (!identical(intraclass_version, "0.1.0") ||
    !identical(intraclass_repository, "CRAN")) {
  stop("Install intraclass 0.1.0 from CRAN; found version ",
       intraclass_version, " from ",
       if (is.null(intraclass_repository)) "no repository" else
         intraclass_repository, ".", call. = FALSE)
}

# A comma decimal mark would break the comma-separated results file.
options(OutDec = ".")

library(intraclass)

out_path <- file.path("analysis", "comparison-results.csv")
if (!dir.exists(dirname(out_path))) {
  stop("Run the script from the repository root.", call. = FALSE)
}

results <- list()
add <- function(name, value) {
  if (is.numeric(value)) {
    value <- if (value == round(value)) {
      format(value, scientific = FALSE, trim = TRUE)
    } else {
      formatC(signif(value, 6), digits = 6, format = "fg", flag = "#")
    }
  }
  results[[name]] <<- as.character(value)
}

# psych and irr take a wide subjects-by-raters matrix.
to_wide <- function(d) {
  w <- reshape(d, idvar = "subject", timevar = "rater", direction = "wide")
  w <- w[order(as.integer(as.character(w$subject))), ]
  as.matrix(w[, -1])
}

estimate <- function(data, model, type, unit, term) {
  fit <- icc(data, subject = subject, rater = rater, score = score,
             model = model, type = type, unit = unit, seed = 1L)
  td <- tidy(fit)
  value <- td$estimate[td$term == term]
  if (length(value) != 1) {
    stop("intraclass returned no single row for term ", term, call. = FALSE)
  }
  value
}

# Package versions -----------------------------------------------------------

for (p in pkgs) add(paste0("version_", p), as.character(packageVersion(p)))
add("repository_intraclass", packageDescription("intraclass")$Repository)

# Balanced data: intraclass, psych, irr --------------------------------------

coefs <- list(
  ICC1  = list(model = "oneway", type = "agreement",   unit = "single",
               term = "ICC(1)",   psych = "ICC1"),
  ICC1k = list(model = "oneway", type = "agreement",   unit = "average",
               term = "ICC(k)",   psych = "ICC1k"),
  ICCA1 = list(model = "twoway", type = "agreement",   unit = "single",
               term = "ICC(A,1)", psych = "ICC2"),
  ICCAk = list(model = "twoway", type = "agreement",   unit = "average",
               term = "ICC(A,k)", psych = "ICC2k"),
  ICCC1 = list(model = "twoway", type = "consistency", unit = "single",
               term = "ICC(C,1)", psych = "ICC3"),
  ICCCk = list(model = "twoway", type = "consistency", unit = "average",
               term = "ICC(C,k)", psych = "ICC3k")
)

wm <- to_wide(ratings)
ps <- psych::ICC(wm)$results
psych_values <- stats::setNames(ps$ICC, ps$type)

balanced <- lapply(coefs, function(cf) {
  c(intraclass = estimate(ratings, cf$model, cf$type, cf$unit, cf$term),
    psych = unname(psych_values[cf$psych]),
    irr = irr::icc(wm, model = cf$model, type = cf$type,
                   unit = cf$unit)$value)
})

for (pkg in c("intraclass", "psych", "irr")) {
  for (cf in names(coefs)) {
    add(paste0("balanced_", pkg, "_", cf), balanced[[cf]][[pkg]])
  }
}

gaps <- unlist(lapply(balanced, function(b) {
  abs(b[["intraclass"]] - c(b[["psych"]], b[["irr"]]))
}))
add("balanced_max_abs_gap", max(gaps))

# irrICC: Gwet's inter-rater ICC, random factorial model without interaction --

w <- reshape(ratings, idvar = "subject", timevar = "rater", direction = "wide")
w <- w[order(as.integer(as.character(w$subject))), ]
gwet_frame <- data.frame(
  Target = as.integer(as.character(w$subject)),
  J1 = w$score.1, J2 = w$score.2, J3 = w$score.3, J4 = w$score.4
)
icc2r <- irrICC::icc2.nointer.fn(gwet_frame)$icc2r
add("irricc_nointer_icc2r", icc2r)
add("irricc_nointer_abs_diff_ICCA1",
    abs(balanced$ICCA1[["intraclass"]] - icc2r))

# Incomplete data --------------------------------------------------------------

wm_inc <- to_wide(ratings_incomplete)
add("incomplete_complete_case_subjects", sum(stats::complete.cases(wm_inc)))

fit_inc <- icc(ratings_incomplete, subject = subject, rater = rater,
               score = score, model = "twoway", type = "agreement",
               unit = "average", seed = 1L)
gl_inc <- glance(fit_inc)
add("incomplete_intraclass_subjects", gl_inc$n_subjects)
add("incomplete_intraclass_ratings", gl_inc$n_obs)
add("incomplete_intraclass_k_eff", gl_inc$k_eff)

add("incomplete_psych_subjects", psych::ICC(wm_inc)$n.obs)

# The six estimates of psych and intraclass on the incomplete data.
ps_inc <- psych::ICC(wm_inc)$results
psych_inc <- stats::setNames(ps_inc$ICC, ps_inc$type)
for (pkg in c("psych", "intraclass")) {
  for (cf in names(coefs)) {
    value <- if (pkg == "psych") {
      unname(psych_inc[coefs[[cf]]$psych])
    } else {
      estimate(ratings_incomplete, coefs[[cf]]$model, coefs[[cf]]$type,
               coefs[[cf]]$unit, coefs[[cf]]$term)
    }
    add(paste0("incomplete_", pkg, "_", cf), value)
  }
}

# The rater count k that psych's ICC2 and ICC2k imply through the
# Spearman-Brown formula ICC2k = k ICC2 / (1 + (k - 1) ICC2).
icc2 <- psych_inc[["ICC2"]]
icc2k <- psych_inc[["ICC2k"]]
# Rounding keeps floating-point residue from changing how a whole k is written.
add("incomplete_psych_k",
    round(icc2k * (1 - icc2) / (icc2 * (1 - icc2k)), 6))

# Write --------------------------------------------------------------------------

write.csv(data.frame(name = names(results), value = unlist(results)),
          out_path, row.names = FALSE, quote = FALSE)
