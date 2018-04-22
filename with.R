id <- c(1, 2, 3, 4)
age <- c(25, 34, 28, 52)
diabetes <- c("Type 1", "Type 2", "Type 1", "Type 1")
status <- c("poor", "improved", "excelent", "poor")
dataset <- data.frame(id, age, diabetes, status, row.names=id)
dataset
with(dataset, {
    table(diabetes, status)
    stats <<- summary(age) # saves `stats` in global env
})
stats
