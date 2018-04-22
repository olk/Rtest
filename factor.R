status <- factor(c("poor", "improved", "excellent"), order = F)
status
status <- factor(c("poor", "improved", "excellent"), order = T)
status
status <- factor(c("poor", "improved", "excellent"), order = F, levels = c("poor", "improved", "excellent"))
status
status <- factor(c("poor", "improved", "excellent"), order = T, levels = c("poor", "improved", "excellent"))
status

id <- c(1, 2, 3, 4)
age <- c(25, 34, 28, 52)
diabetes <- c("Type 1", "Type 2", "Type 1", "Type 1")
status <- c("poor", "improved", "excelent", "poor")
diabetes <- factor(diabetes)
status <- factor(status, order = TRUE)
dataset <- data.frame(id, age, diabetes, status, row.names=id)
str(dataset)
summary(dataset)

x <- c(5, 12, 13, 12)
xf <- factor(x)
unclass(xf)
length(x)
length(xf)
xff <- factor(x, levels=c(5, 12, 13, 88))
xff
unclass(xff)
xff[2] <- 88
xff
unclass(xff)

# tapply()
a1 <- c(25, 26, 55, 37, 22, 45)
a2 <- c("R", "D", "D", "R", "U", "D")
tapply(a1, a2, mean)

d <- data.frame(list(gender=c("M", "M", "F", "M", "F", "F"),
                     age=c(47, 59, 22, 34, 38, 24),
                     income=c(55000, 88000, 19200, 76500, 123000, 45600)))
d
d$over25 <- ifelse(d$age > 25, 1, 0)
d
tapply(d$income, list(d$gender,d$over25), mean) # two factors, gender and over25
