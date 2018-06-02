library(ggplot2)
library(tidyr)
library(dplyr)
library(magrittr)
library(mlbench)

data(iris)
iris %>% head(5)
iris %>% select(Species, Petal.Length, Sepal.Width) %>% head(5)

# key column `Attribute` contains the names of columns from the input
# and column `Measurement` contains the claues of the key column
iris %>%
    gather(key=Attribute, value=Measurement, Sepal.Length, Sepal.Width) %>%
    select(Species, Attribute, Measurement) %>%
    #head(5)
    qplot(Attribute, Measurement, geom="boxplot", facets=.~Species, data=.)
