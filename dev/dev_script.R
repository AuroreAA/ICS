
# Package development
devtools::load_all()
devtools::check(manual = FALSE,
                cran = TRUE,
                remote = TRUE)
devtools::build_manual()

## Edit DESCRIPTION
usethis::use_readme_rmd()

# To create an R script
usethis::use_r("covW")

# GitHub Actions ------
usethis::use_github_action_check_standard()


# Tests --------------
usethis::use_testthat(3)
usethis::use_test("ICS_S3_tests")
testthat::test_file("tests/testthat/test-ICS_S3_tests.R")
