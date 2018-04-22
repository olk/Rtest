# creating
x <- matrix(c(1:4), nrow=2)
x
x <- matrix(nrow=2, ncol=2)
x[1,1] <- 1
x[1,2] <- 0
x[2,1] <- 0
x[2,2] <- 1
x
x <- matrix(c(1:6), nrow=2, byrow=TRUE)
x

# operations
x <- matrix(c(1:4), nrow=2)
x %*% x
3 * x
x * 3
x + x

# indexing
x <- matrix(c(1:9), nrow=3)
x
x[,2:3]
x[2:3,]
x[c(2,3), c(1,2)]
x[c(2,3), c(1,2)] <- matrix(c(0,0,1,0), nrow=2)
x

# assigning submatrices
x <- matrix(nrow=3, ncol=3)
y <- matrix(c(1,0,0,1), nrow=2)
x[2:3,2:3] <- y
x
x <- matrix(1:9, nrow=3)
x[-2,]

# filtering
x <- matrix(c(1:3,2:4), ncol=2)
x
x[x[,2] >= 3,]
v <- x[,2] >= 3 # second column of `x`, elements >= 3
v # output [1] FALSE TRUE TRUE
x[v,] # apply vector `v` to first column of `x`
# x[v,] == rows of `x` specified by `v` element is `TRUE` or `FALSE`
# first element of `v` is `FALSE`, thus first row of `x` is skipped
# second and thrid element of `x` are `TRUE`, thus second and thrid row of `x` used
x <- matrix(c(1:6), nrow=3)
x[x[,1] > 1 & x[,2] > 5,] # output [1] 3 6
x <- matrix(c(5,2,10,-3,10,23), ncol=2)
x
which(x > 3) # output [1] 1 3 5 6

# row()/col()
# covarianz matrix
cov <- function(rho, n) {
    m <- matrix(nrow=n, ncol=n)
    m <- ifelse(row(m) == col(m), 1, rho)
    return(m)
}
x <- cov(0.2, 3)
x

# apply()
x <- matrix(c(1:6), nrow=3)
f <- function(x) {
    x/c(2, 8) # no return()
}
# if f() return a vector of `k` elements, the returned matrix of `apply()` will have k rows
# if f() return a scalar, the result of `apply()` will a vector
x <- apply(x, 1, f) # returns a matrix of 2 rows and 3 columns
x
t(x) # transpose matrix
# a matrix of `0` and `1`; check the majority of the first d elements in a row a `1`
f <- function(m, d) {
   maj <- sum(m[1:d]) / d 
   return(ifelse(maj > 0.5, 1, 0)) 
}
x <- matrix(c(1,0,1,1,0,1,1,1,1,0,1,0,0,1,1), nrow=3, byrow=TRUE)
x
apply(x, 1, f, 3) # output [1] 1 1 0
apply(x, 1, f, 2) # output [1] 0 1 0
# find outliers
f <- function(m) {
    g <- function(r) {
        mdn <- median(r)
        devs <- abs(r-mdn)
        return(which.max(devs))
    }
    return(apply(m, 1, g))
}
x <- matrix(c(1:6), nrow=2)
x
f(x) # output [1] 1 1 

# changing size of a matrix
x <- rep(1,4)
x 
y <- matrix(c(1:12), nrow=4)
y
cbind(x, y)
x <- cbind(c(1, 2), c(3, 4))
x
x <- matrix(1:6, nrow=3)
x
x <- x[c(1,3),]
x

# vector/matrix distinction
x <- matrix(1:8, nrow=4)
x
length(x)
class(x)
attributes(x) # attirbute `dim` containing the number of rows and columns
nrow(x) # number of rows of `x`
ncol(x) # numner of columns of `x`

# avoiding dimension reduction
x <- matrix(1:8, nrow=4)
x
v <- x[2,]
v # output [1] 2 6 , `v` is a vector
v <- x[2,, drop=FALSE] # avoid dimension reduction
v # `v` is a 1x2 matrix
x <- 1:4
x
attributes(x) # output NULL
y <- as.matrix(x) # tread vector as matrix
attributes(y) # output $dim [1] 4 1

# naming matrix rows and columns
x <- matrix(1:8, nrow=4)
x
colnames(x) # output NULL
colnames(x) <- c("x","y")
x
colnames(x) # output x y
rownames(x) <- c("a","b","c","d")
x

# array == tensor
t1 <- matrix(1:6, nrow=3)
t1
t2 <- matrix(10:15, nrow=3)
t2
tens <- array(data=c(t1,t2), dim=c(3,2,2))
attributes(tens)
tens
