# ellipsis
rescale <- function(x, ...) {
    m <- mean(x, ...)
    s <- sd(x, ...)
    (x - m) / s
}

x <- c(NA, 1:3)
rescale(x) # [1] NA NA NA NA 
rescale(x, na.rm=TRUE) # [1] NA -1  0  1

f <- function(...) {
    list(...)
}
g <- function(x, y, ...) {
    f(...)
}
g(x=1, y=2, z=3, w=4) # $z [1] 3 $w [1] 4

# f <- function(w) {
#     w
# }
# g <- function(x, y, ...) {
#     f(...)
# }
# g(x=1, y=2, z=3, w=4) # Fehler in f(...) : unbenutztes Argument (z = 3)

params <- function(...) {
    eval(substitute(alist(...)))
}
params(a=4, b=a**2) # $a [1] 4 $b a^2

# alist() returns the parameters as it gets them provided
params <- function(...) {
    alist(...)
}
params(a=4, b=a**2) # [[1]] ...

params <- function(...) {
    substitute(alist(...)) # substitute() returns the (unevaluated) parse tree of the given expression
}
params(a=4, b=a**2) # alist(a = 4, b = a^2)


# lazy evaluation
f <- function(a) {
    function(b) {
        a + b
    }
}
f(2)(2) # [1] 4

ff <- vector("list", 4)
for (i in 1:4) {
    ff[[i]] <- f(i)
}
ff[[1]](1) # [1] 5; because of lazy evaluation is i == 4
ff[[2]](1) # [1] 5; because of lazy evaluation is i == 4

f <- function(a) {
    force(a) # force evaluationg parameter a
    function(b) {
        a + b
    }
}

ff <- vector("list", 4)
for (i in 1:4) {
    ff[[i]] <- f(i)
}
ff[[1]](1) # [1] 2
ff[[2]](1) # [1] 3

params <- function(...) {
    eval(substitute(alist(...)))
}

p <- params(x=2)
class(p$x) # [1] "numeric"; paramater is number 2

a <- 2
p <- params(x=a)
class(p$x) # [1] "name"; expression given if a name is passed
eval(p$x) # [1] 2; evaluation of the expression

p <- params(x=2 * y)
class(p$x) # [1] "call"; all expression are function calls, `*` is being called

y <- 2
eval(p$x) # [1] 4
eval(p$x, list(y=4)) # [1] 8


# vectorized functions
x <- 1:5
y <- 6:10
x - y # [1] -5 -5 -5 -5 -5

f <- function(a, b) {
    log(a) - sqrt(b)
}
f(1:3, 1:3) # [1] -1.0000000 -0.7210664 -0.6334385

# vectoruied version of if-else
compare <- function(x, y) {
    ifelse(x < y, -1, ifelse( y < x, 1, 0))
}
compare(1:6, 1:3) # [1] 0 0 0 1 1 1 

compare <- function(x, y) {
    if (x < y) {
        -1
    } else if (y < x) {
        1
    } else {
        0
    }
}
compare <- Vectorize(compare)
compare(1:6, 1:3) # [1] 0 0 0 1 1 1

scale_with <- function(x, y) {
    (x -mean(y)) / sd(y)
}
scale_with(1:6, 1:3) # [1] -1  0  1  2  3  4 

scale_with1 <- Vectorize(scale_with)
scale_with1(1:6, 1:3) # [1] NA NA NA NA NA NA

scale_with2 <- Vectorize(scale_with, vectorize.args="x")
scale_with2(1:6, 1:3) # [1] -1  0  1  2  3  4


# infix operators
`+`(2, 2) # [1] 4

`if`(2 > 3, "true", "false") # [1] "false"

`%x%` <- `*`
3 %x% 2 # [1] 6

`%x%` <- function(expr, num) {
    replicate(num, expr)
}
3 %x% 5 # [1] 3 3 3 3 3 


# lazy evaluation does evaluate `expr` when `replicate()` is called
rnorm(1) %x% 4 # [1] -1.26634 -1.26634 -1.26634 -1.26634


`%x%` <- function(expr, num) {
    m <- match.call()
    replicate(num, eval.parent(m$expr))
}
rnorm(1) %x% 4 # [1] 0.3054343  1.2290937  1.3302927 -0.535156


# replacement functions
x <- 1:4
x # [1] 1 2 3 4
names(x) <- letters[1:4] # assgins the result of the expression from the left to the variable 
x
# a b c d 
# 1 2 3 4

x <- 1:4
attributes(x) # NULL
attributes(x) <- list(foo="bar") # set all attributes
attributes(x)
# $foo
# [1] bar
attr(x, "baz") <- "abc" # assign individual attributes
attributes(x)
# $foo
# [1] "bar"
# $baz
# [1] "abc"


# tail recusion
# tail-recursive functions == the result of recursive call s returned without doing further computations
factorial <- function(n, acc=1) {
    if (1 == n) {
        acc
    }
    else factorial(n - 1, n * acc); # accumulator is the product of numbers that have been seen so far and is passed to the tail-recursive fucntion
}


# scope
f <- function(x) {
    g <- function(y) {
        x + y
    }
    g(x)
}
f(2) # [1] 4
f(3) # [1] 6

f <- function(x) {
    g <- function(y) {
        x + y
    }
    g # `f` returns function `g`
}
h <- f(2)
h(2) # [1] 4
h(3) # [2] 5

h1 <- f(1)
h2 <- f(2)

g <- function(x) {
    x(1)
}
g(h1) # [1] 2
g(h2) # [1] 3


# closure
# closure => enclosing scope, function remembers the enclosing environment in which they were created
counter <- function() {
    x <- 0
    count <- function() {
        x <<- x + 1
        x
    }
}
cnt <- counter()
cnt() # [1] 1
cnt() # [1] 2
cnt() # [1] 3


# lexical and dynmaic scope
# `quote()`, `x` and `y´ do not refer to any variable, they are just variable names
# `eval()`, uses the calling instead of the enclosing scope (by using function `parent.frame()`)
# `parent.frame()`, gives access to the environments of the functions on the call stack
rm(x); rm(y)
f <- function() {
    x <- 2; y <- 2
    eval(quote(x + y)) # `eval()` evaluates quoted expression
}
f() # [1] 4


# high-order functions
# functions that either take functions as parameters or return functions
myapply <- function(x, f) {
    result <- x
    for (i in seq_along(x)) {
        result[i] <- f(x[i])
    }
    result
}
myapply(1:5, sqrt) # [1] 1.000000 1.414214 1.732051 2.000000 2.236068 

rescale <- function(x) {
    m <- mean(x)
    s <- sd(x)
    myapply(x,
            function(y) {
                (y - m) / s
            })
}
rescale(1:5) # [1] -1.2649111 -0.6324555  0.0000000  0.6324555  1.2649111

# curring:w
curry2 <- function(f) {
    function(x) {
        function(y) {
            f(x, y)
        }
    }
}
h <- curry2(`+`)
h(2)(3) # [1] 5

myapply(1:5, curry2(`+`)(2)) # [1] 3 4 5 6 7

curry <- function(f) {
    n <- length(formals(f)) # number of parameters
    if (1 == n) {
        return(f) # no currying needed
    }
    arguments <- vector("list", length=n) # create a table storing the variables when the chain of functions is called
    # last function must call `f()` with its parameters
    last <- function(x) {
        arguments[n] <<- x
        do.call(f, arguments)
    }
    # store an parameter and retruns the next function in the curried chain
    make_i <- function(i, continuation) {
        force(i); force(continuation)
        function(x) {
            arguments[i] <<- x
            continuation
        }
    }
    continuation <- last
    for (i in seq(n - 1, 1)) {
        continuation <- make_i(i, continuation)
    }
    continuation
}
f <- function(x, y, z) {
    x + 2 * y + 3 * z
}
f(1, 2, 3) # [1] 14
curry(f)(1)(2)(3) # [1] 14


# parameter binding
bind <- function(f, ...) {
    remembered <- list(...) # disables lazy evaluation
    function(...) {
        new <- list(...)
        do.call(f, c(remembered, new))
    }
}
f <- function(x, y, z, w=4) {
    x + 2 * y + 3 * z + 4 * w
}
f(1, 2, 3, 4) # [1] 30
g <- bind(f, y=2)
g(x=1, z=3) # [1] 30
g <- bind(f, y=1, w=1)
g(x=2, z=3) # [1] 17
