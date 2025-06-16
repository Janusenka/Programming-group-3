getwd
setwd("Home/Documents/GitHub/Programming-group-3")
data<- read.csv("TableCountries.csv")
str(data)
data.matrix <- as.matrix(data)
#subset.matrxi<- data.matrix[,c"$gender_pay_gap"]
#install.packages("ggplot2")
library(ggplot2)
#install.packages("tidyverse")
library(tidyverse)

data2022 <- data %>% filter(year  == "2022")