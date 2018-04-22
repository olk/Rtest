g <- "hello world"
h <- c(1:7)
j <- matrix(1:10, nrow = 5)
lst <- list(title=g, ages = h, j)
print("lst")
lst
print("lst[[2]]")
lst[[2]]
print("lst[[ages]]")
lst[["ages"]]
print("lst$ages")
lst$ages

# creating
j <- list(name="Joe", salary="55000", unioin=TRUE)
j
j <- list("Joe", "55000", TRUE) # tags are optional
j

# general operations
# indexing
# return in the data type
j <- list(name="Joe", salary="55000", unioin=TRUE)
j$salary
j[["salary"]]
j[[2]]
# return as list
k <- j["salary"]
class(k)
k <- j[2]
class(k)
j[1:2]
k <- j[2]
k
str(k)

# adding and removing
j <- list(a="abc", b=12)
j
j$c <- "travel" # add component `c`
j
j[[4]] <- 42 # vector indexing single element
j[5:7] <- c(FALSE, TRUE, TRUE) # vector indexing multiple elements
j
j$b <- NULL
j

# concatenating
c(list("joe", 55000, TRUE), list(42))

# size
length(j)

# accessing components and values
j <- list(name="Joe", salary="55000", unioin=TRUE)
names(j)
ju <- unlist(j)
ju
class(ju)
str(ju)
j <- list(a=7, b="abc")
ju <- unlist(j)
ju # output is character; R choses least common denominator
names(ju) <- NULL # strip names
ju

# apply
lapply(list(1:3,25:29), median)
lapply(list(1,2,3,25,26,27,28,29), median)
lapply(list(1:3,25:29), median) # `median()` is applies to both vectors (1:3 and 25:29), part of the list
lapply(list(1,2,3,25,26,27,28,29), median) #`median()´ is applied to each element of the list
sapply(list(c(1,2,3,25,26,27,28,29)), median)
j <- list(full=c(2, 3, 10), and=c(1, 5 ,2, 24), be=c(8), but=c(7), cpu=c(11))
srtl <- function(lst) { # sort list by names
    n <- names(lst)
    s <- sort(n)
    return(lst[s]) # use `[]` for subsetting lit
}
j <- srtl(j)
j
freql <- function(lst) {
    f <- sapply(lst, length) # each element of `lst` contains a vector, `length()` returns the number of entries
    return(lst[order(f)]) # `oder()` returns the indices of a sorted vector
}
j <- freql(j)
j
g <- c("M", "F", "F", "I", "M", "M", "F")
lapply(c("M", "F", "I"), function(gender) { which(g == gender) })

# recursive lists
a <- list(x=1, y=2, z=3)
b <- list(u=7, v=13)
c <- list(a,b)
c # two-component list, with each a component being a list
c(list(a=1,b=2,c=3),k=list(u=7,v=13)) # recursive list
c(list(a=1,b=2,c=3),k=list(u=7,v=13), recursive=TRUE) # non-recursive list
