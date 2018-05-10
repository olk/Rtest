f <- function(x) {
    x <<- 2*x # superassignemnt operator, writes to top-level variables
    v <- 2*v
}
y <- 1
v <- 3
# x, object `x` not found
f(y)
y # outout [1] 1
v # outout [1] 3
x # output [1] 2

x <- NULL
f <- function() {
    i <- function() {
        x <<- x+1 # updates `x` local variable in function `f()`
    }
    x <- 3
    i()
    return(x)
}
f() # output [1] 4
x # output NULL

# assign()
f <- function(x) {
    assign("m", 2*x, pos=.GlobalEnv)
}
k <- 7
f(k)
m

n <- c("a", "b", "c")
make <- function(d) {
    for (i in 1:length(d)) {
        v <- d[i]
        assign(v, v, pos=.GlobalEnv)
    }
}
make(n)
a
b
c

# encapsulate global variables with `assign()` + new environment
f <- function() {
    assign("envX", new.env(), envir=.GlobalEnv)
}
g <- function() {
    a <- 1:10
    assign("a", a, envir=envX)
}
h <- function() {
    get("a", envir=envX)
}
f() # create new environment `envX` on top-level
g() # add variable `a` to environment `envX`
h() # access/return variable `a`
