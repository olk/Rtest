library(dplyr)
library(magrittr)
library(mlbench)

data(iris)
# selecting columns
iris %>% tbl_df %>% select(Sepal.Width, Petal.Length)
iris %>% tbl_df %>% select(starts_with("Petal"))
iris %>% tbl_df %>% select(contains("etal"))
iris %>% tbl_df %>% select(matches(".t."))
iris %>% tbl_df %>% select(-starts_with("Petal"))

# add columns
iris %>% tbl_df %>%
    mutate(Petal.Width.plus.Length=Petal.Width + Petal.Length) %>%
    select(Species, Petal.Width.plus.Length) %>%
    head(5)
iris %>% tbl_df %>%
    transmute(Petal.Width.plus.Length=Petal.Width + Petal.Length) %>%
    head(5)

# sort columns
iris %>% tbl_df %>%
    arrange(desc(Sepal.Length)) %>%
    head(5)

# filter by predicate
iris %>% tbl_df %>%
    filter(Sepal.Length > 5) %>%
    head(5)
iris %>% tbl_df %>%
    arrange(desc(Sepal.Length)) %>%
    filter(Sepal.Length > 5 & Species == "virginica") %>%
    head(5)


data(BreastCancer)

data_url <- "http://tinyurl.com/kw4xtts"
read.csv(data_url, header=FALSE, col.names=names(BreastCancer)) -> raw_breast_cancer
format_class <- . %>% {
    dict <- c("2" = "benign", "4" = "malignant")
    dict[as.character(.)]
} %>% unname %>% factor(levels=c("benign", "malignant"))
formatted_breast_cancer <- raw_breast_cancer %>% mutate(Class=format_class(Class))
#formatted_breast_cancer %>% head(3)

# group by `Class`, calculate mean of thickness
formatted_breast_cancer %>%
    group_by(Class) %>%
    summarise(mean.thickness = mean(Cl.thickness))

# group by `Class`, calculate mean of cell size
formatted_breast_cancer %>%
    group_by(Class) %>%
    summarise(mean.size = mean(Cell.size))

# count for each cell size how many benign and malignant tumors
formatted_breast_cancer %>%
    arrange(Cell.size) %>% # sorted asc. by Cell.size
    group_by(Cell.size, Class) %>%
    summarise(ClassCount=n()) # count

# how does cell thickness behaves as function of both class and cell size
formatted_breast_cancer %>%
    group_by(Class, as.factor(Cell.size)) %>%
    summarise(mean.thickness = mean(Cl.thickness))

# how does cell numbers of benign and malignant tumors behaves as function of both thickness and cell size
formatted_breast_cancer %>%
    group_by(as.factor(Cell.size), Class) %>%
    summarise(mean.thickness = mean(Cl.thickness))
