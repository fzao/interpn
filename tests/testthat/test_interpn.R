
# library(interpn)
library(devtools)
devtools::load_all(".", reset=TRUE)

# FAILS
y <- c(0,1,2,3)
x1 <- c(0.,20.)
x2 <- c(12.5,15.0)
x3 <- c(100.)
xg1 <- c(11.) # c(2,14)
xg2 <- c(13.) # c(17.5, 20)
xg3 <- c(100.) # c(10080, 10080)
outmode <- as.integer(0)
nbiter <- 1

print("Start TEST_1")
for(i in 1:nbiter){
    yguess <- interpn(outmode, y, x1, x2, x3, xg1, xg2, xg3)
    if(is.nan(yguess)) print(c("TEST_1 ", i, yguess))
}


# SUCCESS
y <- c(0,1,2,3,4,5,6,7)
x1 <- c(0.,20.)
x2 <- c(12.5,15.0)
x3 <- c(100., 200.)
xg1 <- c(20.) #c(2,14)
xg2 <- c(15) # c(17.5, 20)
xg3 <- c(200) # c(10080, 10080)
outmode <- as.integer(0)
nbiter <- 1

print("Start TEST_2")
for(i in 1:nbiter){
    yguess <- interpn(outmode, y, x1, x2, x3, xg1, xg2, xg3)
    if(is.nan(yguess)) print(c("TEST_2 ", i, yguess))
    print(c("TEST_2 ", i, yguess))
}





# # test if simple abacus is correctly interpolated
# test_that("Test small abacus", {

#   # TODO...

#   expect_equal(
#     y[N], 
#     yguess,
#     label = paste0("Problem with ... ")
#   )

# })


# # test if interpn return error when using abacus that have columns 
# # with only 
# test_that("Test if abacus with single-valued dimension fails", {

    
#   # TODO ....

#   expect_equal(
#     1+1, 
#     4,
#     label = paste0("Problem with ... ")
#   )

# })
