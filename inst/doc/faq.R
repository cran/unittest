## ---- message=FALSE, echo=FALSE------------------------------------------
library(unittest)

## ------------------------------------------------------------------------
add_four <- function(x) {
    if( ! is.numeric(x) ) stop("x must be numeric")
    return( x+4 )
}

## ------------------------------------------------------------------------
ok(ut_cmp_error(add_four("a"), "must be numeric"), "add_four() argument not numeric throws error")

## ------------------------------------------------------------------------
a <- c(1,2,3)
b <- 1:3
ok(ut_cmp_equal(a,b), "a and b are equal")

## ------------------------------------------------------------------------
ok_group("Test addition", {
    ok(1 + 1 == 2, "Can add 1")
    ok(1 + 3 == 4, "Can add 3")
})
ok_group("Test subtraction", {
    ok(1 - 1 == 0, "Can subtract 1")
    ok(1 - 3 == -2, "Can subtract 3")
})

## ---- eval = FALSE-------------------------------------------------------
#  library(mypackage)
#  library(unittest, quietly = TRUE)

## ------------------------------------------------------------------------
biggest <- function(x,y) {max(c(x,y))}

## ---- eval = FALSE-------------------------------------------------------
#  library(mypackage)
#  library(unittest, quietly = TRUE)
#  
#  ok(biggest(3,4) == 4, "two numbers")
#  ok(biggest(c(5,3),c(3,4)) == 5, "two vectors")

## ---- eval = FALSE-------------------------------------------------------
#  local({
#      ok(internal_function() == 3)
#      ok(another_internal_function() == 4)
#      ok(final_internal_function() == 5)
#  }, asNamespace('mypackage'))

