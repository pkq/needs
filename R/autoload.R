autoload <- function(flag) {
  sysfile <- system.file("extdata", "promptUser", package = "needs")
  site_profile <- if (is.na(Sys.getenv("R_PROFILE", unset = NA))) {
    file.path(Sys.getenv("R_HOME"), "etc", "Rprofile.site")
  } else {
    Sys.getenv("R_PROFILE")
  }

  if (!file.exists(site_profile)) {
    file.create(site_profile)
  }
  cxn <- file(site_profile)
  lines <- readLines(cxn)

  if (flag) {
    if (!any(grepl("^[:blank:]*autoload\\(\"needs\", \"needs\"\\)", lines))) {
      write('\n\nautoload("needs", "needs")\n\n', file = site_profile,
            append = TRUE)
    }
  } else {
    lines[grepl("^[:blank:]*autoload\\(\"needs\", \"needs\"\\)", lines)] <- ""
    k <- write(paste(lines, collapse = "\n"), file = site_profile,
               append = FALSE)
  }

  close(cxn)
  options(needs.promptUser = FALSE)
  write(0, file = sysfile)

  return(flag)
}
