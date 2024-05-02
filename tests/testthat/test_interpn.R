# library(interpn)
library(devtools)
library(testthat)
devtools::load_all(".", reset=TRUE)


test_that("interpn function disallows grids with only one argument", {
  # Define test case
  y <- c(1, 2, 3, 4)  # Example function values at each sample point
  x1 <- c(0., 20.)
  x2 <- c(12.5, 15.0)
  x3 <- c(100.)
  xg1 <- c(11.)
  xg2 <- c(13.)
  xg3 <- c(100.)
  outmode <- as.integer(0)
  
  # Run test
  expect_error(interpn(outmode, y, x1, x2, x3, xg1, xg2, xg3), 
               "All sample point vectors must contain more than one coordinate.")
})


# Test for normal scenario: 1D linear interpolation
test_that("1D linear interpolation", {
  # Define sample data
  x1 <- c(0, 1, 2, 3)
  v <- c(1, 2, 3, 4)
  xq1 <- c(0.5, 1.5, 2.5)
  outmode <- as.integer(0)
  
  # Expected interpolated values
  expected <- c(1.5, 2.5, 3.5)
  
  # Run interpolation function
  actual <- as.vector(interpn(outmode, v, x1, xq1))

  # Check if the actual result matches the expected result
  expect_equal(actual, expected)
})


# Test for 2D linear interpolation
test_that("2D linear interpolation", {
  # Given example data
  x1 <- matrix(1:5, ncol = 5)
  x2 <- matrix(1:7, ncol = 7)
  y <- as.vector(outer(x1, x2, "+"))
  xguess1 <- c(1.5, 1.6, 1.7)  # dimension 1
  xguess2 <- c(2.5, 4.6, 6.7)  # dimension 2

  # Expected output
  expected <- c(4.0, 6.2, 8.4)  # Expected interpolated values for outmode = 2

  # Actual output
  actual <- as.vector(interpn(outmode = 2, y, x1, x2, xguess1, xguess2))

  # Compare actual and expected
  expect_equal(actual, expected)
})


#' @example
#' FAILS
# y <- c(0,1,2,3)
# x1 <- c(0.,20.)
# x2 <- c(12.5,15.0)
# x3 <- c(100.)
# xg1 <- c(11.) # c(2,14)
# xg2 <- c(13.) # c(17.5, 20)
# xg3 <- c(100.) # c(10080, 10080)
# outmode <- as.integer(0)
# nbiter <- 10 
## 
# print("Start TEST_1")
# for(i in 1:nbiter){
#     yguess <- interpn(outmode, y, x1, x2, x3, xg1, xg2, xg3)
#     if(is.nan(yguess)) print(c("TEST_1 ", i, yguess))
# }

#' @example  
#' SUCCESS
# y <- c(0,1,2,3,4,5,6,7)
# x1 <- c(0.,20.)
# x2 <- c(12.5,15.0)
# x3 <- c(100., 200.)
# xg1 <- c(20.) #c(2,14)
# xg2 <- c(15) # c(17.5, 20)
# xg3 <- c(200) # c(10080, 10080)
# outmode <- as.integer(0)
# nbiter <- 10
# print("Start TEST_2")
# for(i in 1:nbiter){
#     yguess <- interpn(outmode, y, x1, x2, x3, xg1, xg2, xg3)
#     if(is.nan(yguess)) print(c("TEST_2 ", i, yguess))
#     print(c("TEST_2 ", i, yguess))
# }

