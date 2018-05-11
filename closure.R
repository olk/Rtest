# closure == function that sets up local variables
# and creates and returns a function that accesses the variables
fn <- function(x=0) {
    l <- x
    f <- function() {
        l <<- l+1
        l
    }
    return(f)
}
fn1 <- fn()
fn2 <- fn()
fn3 <- fn(5)
fn1() # [1] 1
fn2() # [1] 1
fn3() # [1] 6
fn2() # [1] 2
fn2() # [1] 3
fn1() # [1] 2
fn3() # [1] 7
