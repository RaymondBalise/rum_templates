packages <- c(
  "conflicted",

  # data I/O and wrangling
  "arrow",
  "broom",
  "glue",
  "haven",
  "here",
  "janitor",
  "labelled",
  "rio",
  "rUM",
  "tidyverse",

  # modeling
  "tidymodels",

  # explainability

  # visualization and tables
  "ggthemes",
  "gt",
  "gtsummary",
  "patchwork",
  "sumExtras"
)

for (pkg in packages) {
  if (!requireNamespace(pkg, quietly = TRUE) && interactive()) {
    if (requireNamespace("pak", quietly = TRUE)) {
      pak::pak(pkg)
    } else {
      repos <- getOption("repos")
      if (is.null(repos) || identical(unname(repos["CRAN"]), "@CRAN@")) {
        repos <- c(CRAN = "https://cloud.r-project.org")
      }
      install.packages(pkg, repos = repos)
    }
  }
  library(pkg, character.only = TRUE)
}
tidymodels_prefer()
