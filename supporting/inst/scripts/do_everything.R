library(here)
library(purrr)
library(dplyr)
library(cli)

# Source a plain .R file, capturing errors, warnings, and messages.
# Always returns a record for the file so the caller can summarise everything.
source_script <- function(file, envir = globalenv()) {
  warns <- list()
  msgs <- list()

  result <- tryCatch(
    withCallingHandlers(
      {
        source(file, local = envir, echo = FALSE)
        NULL
      },
      warning = function(w) {
        warns[[length(warns) + 1]] <<- cli::ansi_strip(conditionMessage(w))
        invokeRestart("muffleWarning")
      },
      message = function(m) {
        msgs[[length(msgs) + 1]] <<- cli::ansi_strip(conditionMessage(m))
        invokeRestart("muffleMessage")
      }
    ),
    error = function(e) {
      structure(
        list(message = cli::ansi_strip(conditionMessage(e))),
        class = "source_script_error"
      )
    }
  )

  has_error <- inherits(result, "source_script_error")

  list(
    file     = basename(file),
    path     = file,
    success  = !has_error,
    error    = if (has_error) result$message else NULL,
    warnings = warns,
    messages = msgs
  )
}

# Print a run report; set show_messages = TRUE to also see message() output.
report_results <- function(results, show_messages = FALSE) {
  failed <- results |> keep(\(x) !x$success)
  warned <- results |> keep(\(x) length(x$warnings) > 0)
  noted <- results |> keep(\(x) length(x$messages) > 0)

  cli::cli_h1("Source report")
  cli::cli_alert_info(
    "{length(results)} file{?s} run: {length(failed)} error{?s}, \\
    {length(warned)} file{?s} with warnings."
  )

  if (length(failed) == 0) {
    cli::cli_alert_success("All files sourced successfully.")
  } else {
    cli::cli_h2("Errors")
    walk(failed, \(x) {
      cli::cli_alert_danger("{x$file}")
      cli::cli_ul(x$error)
    })
  }

  if (length(warned) > 0) {
    cli::cli_h2("Warnings")
    walk(warned, \(x) {
      cli::cli_alert_warning("{x$file}")
      cli::cli_ul(unlist(x$warnings))
    })
  }

  if (show_messages && length(noted) > 0) {
    cli::cli_h2("Messages")
    walk(noted, \(x) {
      cli::cli_alert_info("{x$file}")
      cli::cli_ul(unlist(x$messages))
    })
  }

  invisible(results)
}

# Tidy one-row-per-file summary.
summarise_results <- function(results) {
  results |>
    map(\(x) {
      tibble::tibble(
        file      = x$file,
        success   = x$success,
        n_warning = length(x$warnings),
        n_message = length(x$messages),
        error     = x$error %||% NA_character_
      )
    }) |>
    list_rbind()
}

# Uncomment additional scripts as you add them to inst/scripts/:
script_files <- c(
  "libraries.R"
  # "import.R",
  # "preprocess.R"
)

results <- script_files |>
  map_chr(\(file) here::here("inst", "scripts", file)) |>
  set_names(basename) |>
  map(source_script)

report_results(results, show_messages = TRUE)

summary_tbl <- summarise_results(results)
print(summary_tbl)
save.image(file = "do_everything_summary.RData")
