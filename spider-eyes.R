# Author: Sarah Crews and Misha Leong
# Date: March 2019
# Project: Sample code for Sarah to run on her spider eyes


# *************************************************************
# FIRST THINGS FIRST
# *************************************************************

# load libraries
library(tidyverse)
library(corrplot)
library(lazyeval)

# load file
ALE<- read_csv("ALEmeasurements.csv") 


# *************************************************************
# CORRELATIONS BETWEEN VARIABLES
# *************************************************************
M <- cor(ALE %>% select(ceph:ALE_rid_tr_rid))
corrplot(M, method = "color")


# *************************************************************
# THE QUESTIONS!
# *************************************************************
# ANOVA cheat sheet http://www.quantide.com/wp-content/uploads/2017/02/Three-way-Anova-with-R.pdf

# example goal
m <- aov(ALE_eye_area ~ sex*activity*hunting, data = ALE)
summary(m)

variable_to_test <- "ceph"
# function to run model
aov_model_test <- function(variable_to_test){
  print(variable_to_test)
  m <- aov(eval(variable_to_test) ~ sex * activity * hunting, data = ALE)
  print(summary(m))
  return(m)
}

variable_vector <- names(ALE) 
variable_vector[-c(1:4)]

lapply(variable_vector, function(i){
  assign(paste0("aov_", i) , aov_model_test(i), 
         envir = .GlobalEnv)
})
