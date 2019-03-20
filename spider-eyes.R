# Author: Sarah Crews and Misha Leong
# Date: March 2019
# Project: Sample code for Sarah to run on her spider eyes


# *************************************************************
# FIRST THINGS FIRST
# *************************************************************

# load libraries
library(tidyverse)
library(corrplot)

# load file
eyes<- read_csv("raw.csv") %>% drop_na()


# *************************************************************
# CORRELATIONS BETWEEN VARIABLES
# *************************************************************
M <- cor(eyes)
corrplot(M, method = "number")
