a <- c("i", "j", "k", "x", "y", "z")
a[3]
a[c(1, 3 ,5)]
a[2:6]

# adding/deleting
x <- c(34,3,13,49)
x <- c(x[1:3],73,x[4]) # insert before 49
x # [1] 34  3 13 73 49

# null vector
x <- c()
x # [1] NULL
length(x) # [1] 0
1:length(x) # [1] 1 0

# adding
x <- c(1, 2, 3)
x <- x + c(5, 0, -1)
x # [1] 6 2 2

# indexing
x <- c(1.2, 4.2, 0.2, 4.9)
x[c(1, 3)] # extract element at index 1 and 3 from x
x[2:4]
y <- 3:4
x[y]
y <- x[c(1, 1, 3)]
y
# negative index means excluding element
z <- c(4, 58, 102, 4)
z[-1]
z[-1:-3]
z[-length(z)] # exclude the last element

# generate vectors
4:9
3:7
i <- 2
1:i-1 #  operator precendence! (1:i) - 1

# using seq()
x <- seq(from = 12, to = 42, by = 3)
x <- c()
x
seq(x)
length(x)

# repeating
x <- rep(3, 5)
x
rep(c(1, 4, 7), 3)
rep(1:4, 5)
rep(c(4, 8, 3), each = 2)

# all() and any()
x <- 1:8
any(x > 7)
any(x > 10)
findr <- function(x, k) {
    n <- length(x)
    count <- 0
    runs <- vector(length = n)
    for (i in 1:(n-k+1)) {
        if (all(x[i:(i+k-1)] == 1)) {
            count <- count + 1
            runs[count] <- i
        }
    }
    if (count > 0) {
        runs <- runs[1:count]
    } else {
        runs <- NULL
    }
    return(runs)
}
x <- c(1, 0, 0, 1, 1, 1, 1, 0, 0, 1, 1)
findr(x, 3)

# vector in, matric out
x <- 1:5
fun <- function(x) {
    return(c(x, x^2))
}
sapply(1:5, fun)

# NA == not available
x <- c(1, 3, NA, 5)
mean(x) # output [1] NA
mean(x, na.rm = TRUE) # output [1] 3 
# multiple NA modes
x <- c(4, NA, 4)
mode(x[2]) # numeric
x <- c("abc", NA, "yz")
mode(x[2]) # character
x <- NA
length(x) # [1] 1

# NULL == non-existent
x <- NULL
length(x) # [1] 0

# filter
x <- c(3, 2, 5, 7)
y <- x[x*x > 10] # filter elements with `square > 10`
y # output [1] 5 7

x <- c(3, 2, 5, 7, 3)
y <- c(-1, 3, 6, 7, 8) # use x to filter y
z <- y[x*x > 10] # output [1] 6 7
z

x <- c(1:5, 2, 0)
x[x > 3]  <- 0
x # output [1] 1 2 3 0 0 2 0

x <- c(3, 4, NA, 44)
x[x > 5] # output [1] NA 44
subset(x, x > 5) # output [1] 44 

x <- c(7,2, -2, 11)
which(x * x > 7) # returns index x^2>7  [1] 1 4
fn <- function(x) {
    return(which(x == 1)[1]) # finds the first occurence of '1' in 'x'
}
x <- c(4, 5, 1, 1, 4, 5, 1)
fn(x) # output [1] 3

# vectorized if-else
x <- 1:10
y <- ifelse(x %% 2 == 0, 1, 0)
y # output [1] 0 1 0 1 0 1 0 1 0 1
x <- c(4, 1, 11, 34)
x <- ifelse(x > 6, 2*x, 3*x)
x # output [1] 12  3 22 68

x <- c("M", "F", "F", "I", "M", "M", "F")
x
ifelse(x == "M", 1, ifelse(x == "F", 2, 3)) # output [1] 1 2 2 3 1 1 2 
m <- which(x == "M")
f <- which(x == "F")
i <- which(x == "I")
m # output [1] 1 5 6
f # output [1] 2 3 7
i # output [1] 4

grps <- list()
for (gen in c("M", "F", "I")) grps[[gen]] <- which(x == gen)
grps # output $M [1] 1 5 6 $F [1] 2 3 7 $I [1] 4

# comparing vectors
# == is a vectorized function
x <- 1:3
y <- c(1, 3 ,4)
x == y # output [1]  TRUE FALSE FALSE 
all(x == y) # output [1] FALSE
identical(x, y) # output [1] FALSE
identical(x, x) # output [1] TRUE
y <- c(1, 2, 3) # produces doubles
identical(x, y) # output [1] FALSE
typeof(x) # output "integer"
typeof(y) # output "double"
y <- 1:3 # produces integers
identical(x, y) # output [1] TRUE

# naming vector elements
x <- 1:4
names(x) # output NULL
names(x) <- c("a", "b", "c", "d")
names(x) #output [1] "a" "b" "c" "d"
x
x["c"] # output c 3 
names(x) <- NULL # removes the names

c(5, 3, "abc") # convert integer to character mode
c(5, 3, list(a=0, b=1)) # convert first two elements to list modes
c(5, 3, c(1.4, 3)) # flatening 5.0 3.0 1.4 3.0 

