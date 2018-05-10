fn <- function(x) {
    x+1 # function `return()` not necessary
    # return(x+1)
}
fn(3)
?"{"
# argument list of `fn`
formals(fn)
formals("fn")
# body of `fn`
body(fn)
body("fn")
# description/implementation of `fn`
fn
page(fn)
# assignment
fn1 <- function(x, y) {
    return(x+y)
}
fn2 <- function(x, y) {
    return(x-y)
}
fn <- fn1 # assigned `fn1()` to `fn`
fn(1, 2)
fn <- fn2
fn(1, 2) # assigned `fn2()` to `fn`
body(fn) <- quote(x*y) # assign a different body to `fn()`
fn(1,2) # body of `fn()` becomes `x*y`
fn2(1,2) # body of `fn2()` remains `x-y`
g <- function(f, a, b) {
    f(a, b)
}
g(fn2, 1, 2)

# recursive function
qs <- function(x) {
    if (1 >= length(x)) {
        return(x);
    }
    x1 <- x[1]
    x2 <- x[-1]
    sv1 <- x2[x2 < x1]
    sv2 <- x2[x2 >= x1]
    sv1 <- qs(sv1)
    sv2 <- qs(sv2)
    return(c(sv1, x1, sv2))
}
x <- c(12, 4, 5, 88, 15)
x
x <- qs(x)
x

# anonymous function
y <- lapply(x, function(z) {z*2})
y

# replacement function
"g<-" <- function(x, value=v) {
    x <- value
}
g(y) <- x
x
y
