# prod()
eo <- function(p) {
    np <- 1 - p # compute for idenpendent events `not happen` propability
    total <- 0.0 # initialize
    for (i in 1:length(p)) {
        total <- total + p[i] + prod(np[-i]) # `prod()` producti of the elements of a vector
    }
    return(total)
}

# cumulative sums and products
x <- c(1, 15, 3)
cumsum(x) # [1]  1 16 19 
cumprod(x) # [1]  1 15 45

# minima and maxima
z <- matrix(c(1, 4, 7, 2, 4, 2), ncol=2)
z
min(z[,1], z[,2]) # [1] 1
pmin(z[,1], z[,2]) # [1] 1 4 2
pmin(z[1,], z[2,], z[3,]) # [1] 1 2

# Nullstellen
nlm(function(x) { return(x^2+1) }, 10)

# differentiation
D(expression(1/x), "x")
D(expression(log(x)), "x")

# statisical
# prefix `r` == random number generation
# prefix `d` == density/probability mass function
# prefix `p` == cumulative distrib. function
# prefix `q` == qunatiles
mean(rchisq(1000, df=2)) # [1] 1.895382
# 95th percentile (0.95 quantil) of chi-square distribution with 2 degrees of freedom
qchisq(0.95, 2) # [1] 5.991465
# 0.50 and 0.95 auantil of chi-square distribution with 2 degrees od freedom
qchisq(c(0.50, 0.95), 2) # [1] 1.386294 5.991465 

# sorting
x <- c(12, 5, 11, 4)
sort(x) # [1]  4  5 11 12
order(x) # [1] 4 2 3 1, inidces returned
# sort data.frame via o`rder()`
x <- data.frame(V1=c("xyz", "abc", "uvw"), V2=c(2, 8, 0), stringsAsFactors=FALSE)
x
y <- order(x$V2)
x[y,]
x[order(x$V1),]

# rank()
x <- c(14, 4, 13, 4)
rank(x) # [1] 4.0 1.5 3.0 1.5

