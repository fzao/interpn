#' N-D Linear interpolation
#' 
#' Given a n dimensional grid defined by the n vectors x1 ,x2, ..., xn and
#' the associated values v of a function, 'interpn' interpolates the values at specific query points.
#'
#' ****************************************************************************
#' @param outmode : (integer, scalar) method for the extrapolation outside the grid. 
#' Possible values are: 
#' 0 (using the nearest n-linear patch from the point), 
#' 1 (by zero), 
#' 2 (by NaN), 
#' 3 (by projection), 
#' 4 (using periodicity) 
#' @param v : (double, vector) function values at each sample point
#' @param ... : (double, vectors) x1, ..., xn, xq1, ..., xqn : coordinates of 
#' the sample points followed by the coordinates of the query points
#' @return  (double, vector) interpolated values at the specific query points (xq1, ..., xqn)
#' 
#' ****************************************************************************
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
#' ****************************************************************************
interpn <- function(outmode, v, ...) {
  grids <- list(...)
  lgrids <- length(grids)

  # Check if the number of grid arguments is even
  if (lgrids %% 2 == 1) {
    stop("Number of grid arguments must be even.")
  }
  
  # Check each sample point vector individually
  for (i in 1:(lgrids / 2)) {
    if (length(grids[[i]]) == 1) {
      stop("Sample point vectors must contain more than one coordinate.")
    }   
  }
  
  n <- as.integer(lgrids / 2)
  x <- unlist(grids[1:n])
  xq <- unlist(grids[(n + 1):(2 * n)])
  nq <- length(grids[[n + 1]])
  yq <- matrix(0., nrow = nq) 


  dimx <- sapply(grids[1:n], length)
  

  out_mode <- switch("outmode",
                   "1" = as.integer(7),
                   "2" = as.integer(10),
                   "3" = as.integer(8),
                   "4" = as.integer(3),
                   as.integer(1))

  
  x <- as.double(x)
  v <- as.double(v)
  xq <- as.double(xq)
  
  # Call native function for interpolation
  Adress <- getNativeSymbolInfo("interpn")$address
  Interpolation <- .C(Adress, as.vector(x), as.vector(v), n, dimx, as.vector(xq), yq, nq, out_mode)
  
  return(Interpolation[[6]])
}
