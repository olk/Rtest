# scalar-product of a vector
x <- c(1, 5, 4, 11)
2*x # [1]  2 10  8 22

# cross-product of vectors
crossprod(1:3, c(5, 12, 13)) # [1] 68

# cross-product of two matrices
x <- matrix(c(1, 3, 2, 4), nrow=2)
y <- matrix(c(1, 0, -1, 1), nrow=2)
x %*% y

# solve equation
x <- matrix(c(1, - 1, 1, 1), nrow=2)
y <- c(2, 4)
solve(x, y) # 1] -1  3 

# find inverse matrix
z <- solve(x)
x %*% z # einheitsmatrix == diag(2)

# einheitsmatrix
diag(2)
diag(3)
x <- matrix(c(1, 7, 2, 8), nrow=2)
dx <- diag(x)
dx # [1] 1 8 
diag(dx) # matrix with diagonale fileld with `1`, `8`

