#' Easier package loading / auto-installation
#'
#' @docType package
#' @name needs-package
#' @description \strong{needs} is a simple R function to make package loading /
#' installation hassle-free --- use it in place of \code{library} to attach
#' packages and automatically install any that are missing. You can also supply
#' a minimum version number, and it will update old packages as needed. No more
#' changing your code to reinstall packages every time you update R ---
#' \code{needs} does it for you.
#' @author Josh Katz
#' @references Source repo: \url{http://www.github.com/joshkatz/needs}
NULL

.onLoad <- function(libname, pkgname) {
  while (".needs" %in% search()) detach(.needs)
  sysfile <- system.file("extdata", "prompt_user", package = "needs")
  prompt_user <- as.logical(scan(sysfile, quiet = TRUE))
  options(needs.prompt_user = prompt_user)

  if (getOption("needs.prompt_user")) {

    if (interactive()) {

      q <- "Should `needs` load itself when it's... needed?\n
      (this is recommended)"
      choices <- sample(c("Yes", "No"))
      yes <- choices[utils::menu(choices, title = q)] == "Yes"

      if (isTRUE(yes)) {

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
        if (!any(grepl("^[:blank:]*autoload\\(\"needs\", \"needs\"\\)",
                       lines))) {
          write('\n\nautoload("needs", "needs")\n\n', file = site_profile,
                append = TRUE)
        }
        close(cxn)

      }

      options(needs.prompt_user = FALSE)
      write(0, file = sysfile)

    }
  }
}

.onAttach <- function(libname, pkgname) {
  if (getOption("needs.prompt_user") && !interactive()) {
    packageStartupMessage("\nLoad `package:needs` in an interactive session to
                          set auto-load flag\n")
  }
}
