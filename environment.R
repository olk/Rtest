x <- 12
fn <- function(y) {
    p <- 8
    fn1 <- function() {
        return(p*(x+y))
    }
    return(fn1())
}
environment(fn) # output <environment: R_GlobalEnv>
fn(2) # output [1] 112

# ls()
ls() # output [1] "fn" "q"  "x" 
ls.str()
f <- function(u) {
    v <- 8
    return(h(v, u))
}
h <- function(a, b) {
    print(ls())
    print(ls(envir=parent.frame(n=1)))
    return(a*(x+b))
}
f(2)

showframe <- function(l) {
    # determine environment
    if (0 > l) {
        env <- .GlobalEnv
    } else {
        env <- parent.frame(n=l+1)
    }
    variables <- ls(envir=env) # variable names
    for (n in variables) {
        v <- get(n, envir=env)
        if (!is.function(v)) {
            cat(n, ": \n", sep="")
            print(v)
        }
    }
}

f <- function() {
    a <- 1
    return(g(a)+a)
}
h <- function(aaa) {
    c <- 3
    return(aaa+c)
}
g <- function(aa) {
    b <- 2
    showframe(0)
    showframe(1)
    aab <- h(aa+b)
    return(aab)
}
f()
