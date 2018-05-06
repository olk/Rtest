# creation
k <- c("Jack", "Daniel", "Vincent")
a <- c(100, 110, 13)
d <- data.frame(k, a, stringsAsFactors=FALSE)
d

# accessing
d[[1]] # idexed values, first column
d$k  # component name
d[,1] # matrix like indexing
str(d)

# matrix like
d[1:2,]
d[1,2]
d[1:2,2] # returns vector
d[1:2,2, drop=FALSE]  # returns data frame
# filtering
d[d$a < 100,]
subset(d, a < 100)

# rbind()/cbind()
d <- rbind(d, list("Lisa", 20))
d
d$plz <- c(1199, 1199, NA, NA)
d
d$x <- 1
d

# selecting NA
complete.cases(d)
d1 <- d[complete.cases(d),] # data without NA
d1

# merging
k <- c("Jack", "Jill", "Jillian", "John")
s <- c("CA", "MA", "MA", "HI")
d1 <- data.frame(k, s, stringsAsFactors=FALSE)
a <- c(10, 7, 12)
k <- c("Jill", "Lillian", "Jack")
d2 <- data.frame(a, k, stringsAsFactors=FALSE)
d2
d <- merge(d1, d2) # only the rows with the same values are merged
d
a <- c(12, 10, 7)
p <- c("Jack", "Jill", "Lillian")
d3 <- data.frame(a, p, stringsAsFactors=FALSE)
d3
merge(d1, d3, by.x="k", by.y="p") # merge with column `k` == column `p`

# surprising merge
d2a <- rbind(d2, list(15, "Jill"))
d2a
merge(d1, d2a) # two observations of variable "Jill" 

# lapply() and sapply()
d
dl <- lapply(d, sort) # sort() is called for each column; `dl` is a list, not a data frame
dl
as.data.frame(dl) # correspondence between data is lost
dl <- sapply(d, sort) # sort() is called for each column; `dl` is a matrix, not a data frame
dl

a <- read.csv("data/abalone.data", header=TRUE)
#a1 <- a[a$Gender!="I",]
a1 <- subset(a, Gender != "I")
fn <- function(col) {
    glm(a1$Gender ~ col, family=binomial)$coef
}
a2 <- sapply(a1[,-1], fn)
a2


library(magrittr)
library(mlbench)
data(BostonHousing)
data_url <- "http://tinyurl.com/zq2u8vx"
col_classes <- rep("numeric", length(BostonHousing)) # create vector of 'numeric' mode
col_classes[which("chas" == names(BostonHousing))] <- "factor" # replace 'numeric' by 'factor' for column 'chas'
boston_housing <- read.table(data_url, col.names=names(BostonHousing), colClasses=col_classes) # read data from URL, use column names from othe data set, all couluns have mode 'numeric' except `chs` is factor
str(boston_housing)
