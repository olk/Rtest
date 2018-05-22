library(compiler)

# vectorization
x <- runif(1000000)
y <- runif(1000000)
z <- vector(length=1000000)
system.time(for (i in 1:length(x)) z[i] <- x[i] + y[i])
system.time(z <- x + y)

x <- sample(1:1000000, 1000000, replace=TRUE)
oddc <- function(x) {
    v <- 0
    for (i in 1:length(x)) {
        if (1 == x[i] %% 2) {
            v <- v + 1
        }
    }
    return(v)
}
system.time(oddc(x))
oddc <- function(x) {
    return(sum(1 == x %% 2))
}
system.time(oddc(x))

# byte code
x <- runif(1000000)
y <- runif(1000000)
z <- vector(length=1000000)
fn <- function() {
    for (i in 1:length(x)) z[i] <- x[i] + y[i]
}
cfn <- cmpfun(fn)
system.time(fn())
system.time(cfn())

# Rprof()
x <- sample(1:1000000, 1000000, replace=TRUE)
oddc <- function(x) {
    v <- 0
    for (i in 1:length(x)) {
        if (1 == x[i] %% 2) {
            v <- v + 1
        }
    }
    return(v)
}
Rprof()
invisible(oddc(x))
Rprof(NULL)
summaryRprof()
