## ----message=FALSE, echo=FALSE------------------------------------------------
library(unittest)

## -----------------------------------------------------------------------------
add_four <- function(x) {
    if( ! is.numeric(x) ) stop("x must be numeric")
    return( x+4 )
}

## -----------------------------------------------------------------------------
ok(ut_cmp_error(add_four("a"), "must be numeric"), "add_four() argument not numeric throws error")

## -----------------------------------------------------------------------------
has_similar_mean <- function(x, y, tol = 0.5) {
    if( any(is.na(x)) ) warning("x contains NAs", call. = FALSE)
    if( any(is.na(y)) ) warning("y contains NAs", call. = FALSE)
    return( isTRUE(all.equal(mean(x), mean(y), tolerance = tol)) )
}

## -----------------------------------------------------------------------------
ok(ut_cmp_warning(has_similar_mean(c(1,2,3,4), c(1,NA,5)), "y contains NAs"), "has_similar_mean() NAs in y issues a warning")

## -----------------------------------------------------------------------------
ok(ut_cmp_warning(has_similar_mean(c(NA,2,3,4), c(1,NA,5)), expected_regexp = c("x contains NAs", "y contains NAs"), expected_count = 2L),
   "has_similar_mean() NAs in arguments issue warnings")

## -----------------------------------------------------------------------------
ok(ut_cmp_warning(has_similar_mean(c(NA,2,3,4), c(1,NA,5)), "^[xy] contains NAs", expected_count = 2L),
   "has_similar_mean() NAs in arguments issue warnings")

## -----------------------------------------------------------------------------
a <- c(1,2,3)
b <- 1:3
ok(ut_cmp_equal(a,b), "a and b are equal")

## -----------------------------------------------------------------------------
ok_group("Test addition", {
    ok(1 + 1 == 2, "Can add 1")
    ok(1 + 3 == 4, "Can add 3")
})
ok_group("Test subtraction", {
    ok(1 - 1 == 0, "Can subtract 1")
    ok(1 - 3 == -2, "Can subtract 3")
})

## -----------------------------------------------------------------------------
ok_group("Test adding integers", local({
    x <- 1L; y <- 2L
    ok(x + y == 3L, "Can add integer variables")
}))

