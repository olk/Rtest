library("magrittr")

# function that works with pipelines
# left side of `%>%` becomes first parameter of function
subsamp_rows <- function(d, n) {
    rows <- sample(nrow(d), n)
    d[rows,]
}

d <- data.frame(x=rnorm(100), y=rnorm(100))
d %>% subsamp_rows(n=3)

d <- data.frame(x=rnorm(100), y=rnorm(100))
d %>% lm(y ~ x, data=.) # == `data=d`

# `.` used in expressions
rnorm(10) %>% data.frame(x=., is_negative=.<0)

# `.` used in function calls
rnorm(10) %>% data.frame(x=., y=abs(.))

# if `.` only appears in function calls, it becomes the first column
rnorm(10) %>% data.frame(x=sin(.), y=cos(.))


# `tracit`/`point free` programming = defining functions from combining other functions
fn <- . %>% cos %>% sin # f <- function(.) sin(cos(.))

# anonymous function
x <- rnorm(10)
y <- rnorm(10)
data.frame(x, y) %>% {
    #plot(y ~ x, data=.)
    #abline(lm(y ~ x, data=.))
}

d <- data.frame(a=rnorm(100), b=rnorm(100))
d %$% data.frame(mean_a=mean(a), mean_b=mean(b))

# plot some intermediate results of a pipeline
# `%T>%` tee operator = passes on the result of the left side
d <- data.frame(a=rnorm(100), b=rnorm(100))
#d %T>% plot(y ~ x, data=.) %>% lm(y ~ x, data=.)

d <- matrix(1:10, nrow=2)
d
d %<>% { . * 2 } # anonymous function with scalar multiplication of matrix, result is assigned back to `d`
d


library(magrittr)
library(mlbench)

data(BreastCancer)
dict <- c("2"="benign", "4"="malignant")
data_url <- "http://tinyurl.com/kw4xtts"
read.csv(data_url, header=FALSE, col.names=names(BreastCancer)) ->
    raw_breast_cancer ->
    formated_breast_cancer
formated_breast_cancer
formated_breast_cancer$Class <-
    formated_breast_cancer$Class %>%
    { dict[as.character(.)] } %>%
    unname %>%
    factor(levels=c("benign", "malignant"))
formated_breast_cancer %>% save(file="data/formated-breast-cancer.rda")
