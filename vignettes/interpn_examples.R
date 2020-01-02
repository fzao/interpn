## ----setup, include=FALSE-----------------------------------------------------
knitr::opts_chunk$set(echo = TRUE)

## ----inter--------------------------------------------------------------------
library(interpn)

## ----sinus--------------------------------------------------------------------
x <- matrix(0:10, ncol = 11)
y <- sin(x)

## ----inter1-------------------------------------------------------------------
xguess <- matrix(1.5:10.5, ncol = 10)
yguess <- interpn(outmode = 2, y, x, xguess)

## ----extra1-------------------------------------------------------------------
print(c(sin(10.5), yguess[10]))

## ----plot1--------------------------------------------------------------------
plot(x, y, main = "interpn in 1D", type = "l")
points(xguess, yguess, col = "red")

## ----add----------------------------------------------------------------------
x1 <- matrix(1:5, ncol = 5)
x2 <- matrix(1:7, ncol = 7)
y <- as.vector(outer(x1, x2, "+"))

## ----inter2-------------------------------------------------------------------
xguess1 <- c(1.5, 1.6, 1.7)  # dimension 1
xguess2 <- c(2.5, 4.6, 6.7)  # dimension 2
yguess <- interpn(outmode = 2, y, x1, x2, xguess1, xguess2)

## ----extra2-------------------------------------------------------------------
print(yguess)

## ----mul----------------------------------------------------------------------
nx1 <- 4  # number of points in dimension 1
nx2 <- 7  # number of points in dimension 2
nx3 <- 10  # number of points in dimension 3
ny <- nx1 * nx2 * nx3 # dimension of the output vector y
y <- double(ny)  # size 
x1 <- as.double(seq(1, nx1))  # grid definition
x2 <- as.double(seq(1, nx2))
x3 <- as.double(seq(1, nx3))

## ----mul2---------------------------------------------------------------------
# function values
a <- 1
for(i in 1:nx3){
    for(j in 1:nx2){
        for(k in 1:nx1){
           y[a] <- x1[k] * x2[j] * x3[i]
           a <- a + 1
        }
    }
 }

## ----inter3-------------------------------------------------------------------
# two query points
xguess1 <- c(1.5, 2.5)
xguess2 <- c(2.5, 3.5)
xguess3 <- c(5, 10)
yguess <- interpn(0, y, x1, x2, x3, xguess1, xguess2, xguess3)
print(yguess)

