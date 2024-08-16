## -----------------------------------------------------------------------------
biggest <- function(x,y) {max(c(x,y))}

## ----eval=FALSE---------------------------------------------------------------
#  library(unittest, quietly = TRUE)
#  
#  source('biggest.R')
#  
#  ok(biggest(3,4) == 4, "two numbers")
#  ok(biggest(c(5,3),c(3,4)) == 5, "two vectors")

## ----eval=FALSE---------------------------------------------------------------
#  source('test_biggest.R')

## -----------------------------------------------------------------------------
biggest <- function(x,y) { 4 }

## ----eval=FALSE---------------------------------------------------------------
#  library(unittest, quietly = TRUE)
#  
#  source('biggest.R')
#  
#  ok(ut_cmp_equal(biggest(3,4), 4), "two numbers")
#  ok(ut_cmp_equal(biggest(c(5,3),c(3,4)), 5), "two vectors")

