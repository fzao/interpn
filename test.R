dyn.load('libInterpn.so')
Adress <- getNativeSymbolInfo("interpn")$address

n <- as.integer(2)  # dimensions
nn <- as.integer(10)  # nombres de points de grille dans chaque dimension
np <- as.integer(5)  # nmbre de points a interpoler
dim <- as.integer(rep(nn, n))
outmode <- as.integer(1)
x <- rep(seq(0,9.99,1),2)  # les coordonnees des axes
nval <- as.integer(nn**2)  # nombre de valeurs sur la grille
val <- matrix(0, nrow = dim[1], ncol = dim[2]) # les valeurs sur la grille
for(i in 1:dim[1]){
  for(j in 1:dim[2]){
    val[i,j] <- x[i] - x[dim[1]+j] # somme
  }
}

xp <- matrix(data = c(seq(1,9.1,2), seq(1.5,9.6,2)), nrow = np, ncol = 2)
yp <- matrix(0., nrow = np)

Interpolation <- .C(Adress, as.vector(x), as.vector(val), dim, n, nn, as.vector(xp), yp, np, outmode)
print(Interpolation[[7]])

dyn.unload('libInterpn.so')