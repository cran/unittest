# everything should no-op in interactive session

pkg_vars <- new.env()

# Clear out pkg_vars so any test failures aren't reported
clear_outcomes <- function () {
    if (exists('outcomes', where = pkg_vars)) rm('outcomes', pos = pkg_vars)
    if (exists('errors', where = pkg_vars)) rm('errors', pos = pkg_vars)
}

assign_outcome <- function(outcome) {
    if (interactive()) return()
    # as per assign() invoked for side effect
    if( ! exists('outcomes', where = pkg_vars) ) {
        assign(
            'outcomes',
             data.frame(status = logical(0), output = character(0), stringsAsFactors = FALSE),
             pos = pkg_vars
        )
    }
    assign('outcomes', rbind(get('outcomes', pos = pkg_vars), outcome), pos = pkg_vars)
}

# having this as a named function means that CMD check will not complain about the use of cat and packageStartupMessage in .onLoad
non_interactive_exit <- function( e ) {
    if( exists('outcomes', where = e) && nrow(get('outcomes', pos = e)) ) {
         tests.total <- nrow(get('outcomes', pos = e))
         tests.failed <- sum(! get('outcomes', pos = e)$status) 
         if ( exists('errors', where = e) ) {
            tests.errors <- get('errors', pos = e)
            writeLines(paste("Bail out! Looks like", tests.total, "tests passed, but script ended prematurely", collapse = " "))
            writeLines(paste("#", tests.errors))
         } else if (tests.failed) {
             cat(paste("# Looks like you failed", tests.failed, "of", tests.total, "tests.\n", collapse = " "), file = output_fh(), append = TRUE)
             # We need to alter the status code, stop() doesn't work, not allowed to use .Last, should only happen as script is terminating anyway.
             quit(save = "no", status = 10, runLast=FALSE)
         }
         else {
             cat(paste("# Looks like you passed all", tests.total, "tests.\n", collapse = " "), file = output_fh(), append = TRUE)
             invisible(NULL)
         }
    }
}

non_interactive_error_handler <- function() {
    # Generate a traceback string
    tb <- head(sys.calls(), -1)
    tb <- lapply(seq_along(tb), function (i) {
        c(
            paste0(i, ":"),
            deparse(tb[[i]], nlines = 3)
        )
    })

    assign('errors', c(
        unlist(strsplit_with_emptystr(geterrmessage(), "\n")),
        "Traceback:", unlist(tb)
    ), pos = pkg_vars)

    q("no", status = 11, runLast = FALSE)
}

.onAttach <- function(libname, pkgname) {
    if (interactive()) return()

    reg.finalizer(pkg_vars, non_interactive_exit, onexit = TRUE)

    # Only register our error handler if we'd use the default otherwise
    if (is.null(getOption('error'))) {
        options(error = non_interactive_error_handler)
    }
}

# "Note that when an R session is finished, packages are not detached and namespaces are not unloaded, so the corresponding hooks will not be run." ?getHook
# so we can assume that if this is called then the package is being detached (and maybe also unloaded)
# the assumption is that if the package is also unloaded that any reg.finalizers would be run some time later when garbage collection happens
# So the onDetach event allows us to clear out the pkg_vars environment so that when the finalizer is called the non_interactive_exit will no-op
.onDetach <- function(libpath) {
    if (interactive()) return()

    rm('outcomes', pos = pkg_vars)
    rm('errors', pos = pkg_vars)
}
