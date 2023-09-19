
# S1 and S2 are functions  ---------------------------------------------------------------------
## COV-COV4 -----
test_that("ics - ics2 - ICS - S1 and S2 are functions", {
  X <- iris[,1:4]

  # ICS with scores standardization
  out_ics <- ics(X, S1 = cov, S2 = cov4, stdKurt = FALSE,  stdB = "Z")
  out_ics2 <- ics2(X, S1 = MeanCov, S2 = Mean3Cov4)
  out_ICS <- ICS(X, S1 = ICS_cov, S2 = ICS_cov4, algorithm = "standard",
                 fix_signs = "scores")
  out_ICS_whiten <- ICS(X, S1 = ICS_cov, S2 = ICS_cov4,
                        algorithm = "whiten")


  # Eigenvalues
  expect_equal(out_ics2@gKurt, out_ics@gKurt)
  expect_equal(as.vector(out_ICS$gen_kurtosis), out_ics@gKurt)
  # whiten option
  expect_equal(out_ICS$gen_kurtosis, out_ICS_whiten$gen_kurtosis)


  # Scores
  # ics - ICS scores - standardization by scores
  expect_equal(out_ics@Scores, data.frame(out_ICS$scores))


  # ics2 - ICS scores - centering
  # out_ICS <- ICS(X, S1 = ICS_cov, S2 = ICS_cov4, center = TRUE)
  # expect_equal(out_ics2@Scores, data.frame(out_ICS$scores))
  # expect_true(all.equal(out_ics2@Scores, data.frame(out_ICS$scores)))


})

test_that("ics - ics2 - ICS - S1 and S2 are functions - eigenvalues standardization", {
  X <- iris[,1:4]

  # ICS with eigenvalues standardization
  out_ics <- ics(X, S1 = cov, S2 = cov4, stdKurt = TRUE)
  out_ICS <- ICS(X, S1 = ICS_cov, S2 = ICS_cov4)

  # Eigenvalues
  expect_equal(as.vector(gen_kurtosis(out_ICS, scale = TRUE)),
               out_ics@gKurt)

})



test_that("ics - ICS scores - S1 and S2 are functions - eigenvectors standardization", {
  X <- iris[,1:4]

  # ICS - eigenvectors standardization
  out_ics <- ics(X, S1 = cov, S2 = cov4, stdKurt = FALSE,  stdB = "B")
  out_ICS <- ICS(X, S1 = ICS_cov, S2 = ICS_cov4, fix_signs = "W")

  # Scores - eigenvectors standardization
  expect_equal(out_ics@Scores, data.frame(out_ICS$scores))
})


## MCD-COV ----
test_that("ics - ICS eigenvalues - S1 and S2 are functions", {
  X <- iris[,1:4]

  # ICS with scores standardization
  mcd <- function(x,...) robustbase::covMcd(x, ...)$cov
  out_ics <- ics(X, S1 = mcd, S2 = cov,
                 S1args = list(nsamp = "deterministic", alpha = 0.5),
                 stdKurt = FALSE,  stdB = "Z")
  out_ICS <- ICS(X,  S1 = mcd, S2 = ICS_cov,
                 S1_args = list(nsamp = "deterministic", alpha = 0.5),
                 fix_signs = "scores")

  # Eigenvalues
  expect_equal(as.vector(out_ICS$gen_kurtosis), out_ics@gKurt)

})


# S1 and S2 are matrices/ICS_scatter --------------------------------------------------

test_that("ics - ICS eigenvalues - S1 and S2 are matrices/ICS_scatter", {
  X <- iris[,1:4]

  # ICS
  out_ics <- ics(X,  S1 = cov(X), S2 = cov4(X), stdKurt = FALSE,
                 stdB = "Z")
  out_ICS <- ICS(X, S1 = cov(X), S2 = cov4(X), fix_signs = "scores",
                 algorithm = "standard")
  out_ICS2 <- ICS(X, S1 = ICS_cov(X), S2 = ICS_cov4, fix_signs = "scores")
  out_ICS3 <-  ICS(X, S1 = ICS_cov(X), S2 = ICS_cov4(X),
                   fix_signs = "scores", algorithm = "standard")

  # Eigenvalues
  expect_equal(as.vector(out_ICS$gen_kurtosis), out_ics@gKurt)
  expect_equal(as.vector(out_ICS2$gen_kurtosis), out_ics@gKurt)
  expect_equal(as.vector(out_ICS3$gen_kurtosis), out_ics@gKurt)

})




## QR ----------------------------------------------------------------------
# It requires LAPACK version "3.11.0"
test_that("ics - ICS eigenvalues - S1 and S2 are functions - QR", {
  X <- iris[,1:4]

  # ICS with QR

  out_ics <- ics(scale(X, center = TRUE, scale = FALSE),
                 S1 = cov, S2 = cov4, stdB = "Z", stdKurt = FALSE)
  out_ics2 <- ics2(X, S1 = MeanCov, S2 = Mean3Cov4)
  out_ICS <- ICS(X, S1 = ICS_cov, S2 =  ICS_covW,
                 S2_args = list(alpha = 1, cf = 1/(ncol(X)+2)))
  out_ICS_QR <- ICS(X, S1 = ICS_cov, S2 =  ICS_covW,
                    S2_args = list(alpha = 1, cf = 1/(ncol(X)+2)),
                    algorithm = "QR", center = TRUE, fix_signs = "scores")

  # Order of columns in W matrix matches order in data matrix
  # (since QR algorithm uses column pivoting)
  expect_identical(colnames(out_ICS_QR$W), names(X))

  # Eigenvalues
  expect_equal(out_ics2@gKurt, as.vector(out_ICS$gen_kurtosis))
  expect_equal(out_ics2@gKurt, as.vector(out_ICS_QR$gen_kurtosis))

  # Scores
  expect_equal(out_ics@Scores, data.frame(out_ICS_QR$scores))

})


test_that("ics2 - S1 and S2 are functions - QR", {
  X <- iris[,1:4]
  X_rank_deficient <- sweep(X, 2, c(10^(-12), 10^(-3), 1, 10^12), "*")
  expect_error(ics2(X_rank_deficient, S1 = MeanCov,
                    S2 = Mean3Cov4)@gKurt)

  expect_error(ICS(X_rank_deficient, S1 = ICS_cov, S2 =  ICS_covW,
                   S2_args = list(alpha = 1, cf = 1/(ncol(X)+2)), algorithm = "standard")$gen_kurtosis)

  # ICS with QR
  if(La_version() == "3.10.0"){
    expect_true(sum(ICS(X_rank_deficient, S1 = ICS_cov, S2 =  ICS_covW,
                        S2_args = list(alpha = 1, cf = 1/(ncol(X)+2)), algorithm = "whiten")$gen_kurtosis !=
                      ICS(X_rank_deficient, S1 = ICS_cov,
                          S2 =  ICS_covW,
                          S2_args = list(alpha = 1,
                                         cf = 1/(ncol(X)+2)),
                          algorithm = "QR")$gen_kurtosis) >= 1)

    expect_equal(ics(X, S1 = cov, S2 = cov4, stdB = "Z",
                     stdKurt = FALSE)@gKurt,
                 as.vector(ICS(X_rank_deficient, S1 = ICS_cov,
                               S2 =  ICS_covW,
                               S2_args = list(alpha = 1,
                                              cf = 1/(ncol(X)+2)),
                               algorithm = "QR")$gen_kurtosis))
  }

})




