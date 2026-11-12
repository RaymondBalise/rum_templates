# Repository Name

**PI**: add contact info if the repo is private.

**Code Authors**:

**Description**: Follow the name with a *brief* description of what the project
does. State the source of the data. If the data is public, add a reference here.

**Notes**: When logging analytical decisions or project milestones, record them
in `DECISIONS.md` and `CHANGELOG.md` (or `NEWS.md` for R packages).

## Run Me First

Include the packages needed. Consider using either `remotes` or `pak`:

```r
install.packages("remotes")

remotes::install_cran(
  c(
    "arrow", "conflicted", "gtsummary", "here", "knitr",
    "rio", "rUM", "tidymodels", "tidyREDCap", "tidyverse"
  )
)
# remotes::install_github()
```

## Raw Data

The names of each raw file with a brief description:

`file_name`: what is in the file

## Directories

`path`: what goes in the directory

## Ordered Analysis Pipeline / Workflow

Run these files in order from raw processing to publication:

1.
2.
3.

## Other Files

**Data**: Include enough information to trace the data to its origin. This may
be URLs or emails (with who sent it and who received it on what date).

**Preprocessing/Anonymization**:
If the project began with confidential data, include the **paths** to the code
that processed the sensitive data here.

**Miscellaneous**: Things like `.css`, `.scss`, `.csl`, `.bib`, or `.js` files.
