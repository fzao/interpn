#' N-D Linear interpolation
#'
#' Given a n dimensional grid defined by the n vectors x1 ,x2, ..., xn and the associated values v of a function, 'interpn' computes the linear interpolant at the query points xq1, ..., xqn.
#'
#' @param outmode : (integer, scalar) method for the extrapolation outside the grid. Possible values are: 0 (using the nearest n-linear patch from the point), 1 (by zero), 2 (by NaN), 3 (by projection), 4 (using periodicity)
#' @param v : (double, vector) function values at each sample point
#' @param ... : (double, vectors) xq1, ..., xqn, x1, ..., xn : coordinates of the query points followed by the coordinates of the sample points
#' @return  (double, vector) interpolated values at the specific query points (xq1, ..., xqn)
#'
#' @examples
#' n1 <- 4  # dimension of x1
#' n2 <- 7  # dimension of x2
#' nv <- n1 * n2  # dimension of v
#' x1 <- as.double(seq(, n1))  # grid
#' x2 <- as.double(seq(, n2))
#' v <- double(nv)
#' # function values
#' k <- 1
#' for(i in 1:n2){
#'    for(j in 1:n1){
#'       v[k] <- x1[j] * x2[i]
#'       k <- k + 1
#'    }
#' }
#' # query points
#' xq1 <- c(1.5, 2.5)
#' xq2 <- c(3.5, 4.5)
#' # call 'interpn'
#' vq <- interpn(outmode=0, v , x1, x2, xq1, xq2)
#' 
#' @author Fabrice Zaoui - Copyright EDF 2019

interpn <- function(outmode, v, ...) {
  grids <- list(...)
  lgrids <- length(grids)
  if(lgrids%%2 == 1) return(NA)
  n <- as.integer(lgrids / 2)
  x <- unlist(grids[1:n])
  xq <- unlist(grids[(n+1):(2*n)])
  nq <- length(grids[[n+1]])
  yq <- matrix(0., nrow = nq)
  dimx <- c(length(grids[[1]]))
  if(n > 1){
    for(i in 2:n){
      dimx <- c(dimx, length(grids[[i]]))
    }
  }
  if(outmode == 1) out_mode <- as.integer(7)
  else if(outmode == 2) out_mode <- as.integer(10)
  else if(outmode == 3) out_mode <- as.integer(8)
  else if(outmode == 4) out_mode <- as.integer(3)
  else out_mode <- as.integer(1)
  x <- as.double(x)
  v <- as.double(v)
  xq <- as.double(xq)

  Adress <- getNativeSymbolInfo("interpn")$address
  Interpolation <- .C(Adress, as.vector(x), as.vector(v), n, dimx, as.vector(xq), yq, nq, out_mode)
  return(Interpolation[[6]])
}
