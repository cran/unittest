## ----message=FALSE, echo=FALSE------------------------------------------------
library(unittest)

## -----------------------------------------------------------------------------
biggest <- function(x,y) {max(c(x,y))}

## ----eval = FALSE-------------------------------------------------------------
#  #!/usr/bin/Rscript --vanilla
#  
#  library(mypackage)
#  library(unittest, quietly = TRUE)
#  if (!interactive()) options(warn=2, error = function() { sink(stderr()) ; traceback(3) ; q(status = 1) })
#  
#  ok(ut_cmp_equal( biggest(3,4), 4), "two numbers")
#  ok(ut_cmp_equal( biggest(c(5,3),c(3,4)), 5), "two vectors")

## ----eval = FALSE-------------------------------------------------------------
#  var <- 4
#  
#  local({
#      ok(ut_cmp_equal(internal_function(3), 3))
#      ok(ut_cmp_equal(internal_function(var), 4))
#  
#      # NB: Regular assignment (<-) won't work here,
#      # but using <<- to refer to variables outside local() will
#      var <<- 5
#      ok(ut_cmp_equal(internal_function(var), 5))
#  }, asNamespace('mypackage'))

