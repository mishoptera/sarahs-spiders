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
ALE<- read_csv("ALEmeasurements.csv") 

# *************************************************************
# INTERESTING STUFF
# *************************************************************
m <- lm(ALE_ridge_no_lens ~ ALE_ridge_size_lens, data = ALE)
summary(m)
plot(ALE_ridge_no_lens ~ ALE_ridge_size_lens, data = ALE)

n <- lm(ALE_ridge_no_lens ~ ALE_rid_tr_rid, data = ALE)
summary(n)
plot(ALE_ridge_no_lens ~ ALE_rid_tr_rid, data = ALE)

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
m1 <- aov(ALE_eye_area ~ sex+activity+hunting, data = ALE)
summary(m1)
m1.aic <- extractAIC(m1)
m1.aic

m2 <- aov(ALE_eye_area ~ activity+hunting, data = ALE)
summary(m2)
m2.aic <- extractAIC(m2)
m2.aic

m3 <- aov(ALE_eye_area ~ hunting, data = ALE)
summary(m3)
m3.aic <- extractAIC(m3)
m3.aic

m3 <- aov(ALE_eye_area ~ sex+activity, data = ALE)
summary(m3)
m3.aic <- extractAIC(m3)
m3.aic

m3 <- lm(ALE_eye_area ~ hunting, data = ALE)
summary(m3)

m4 <- lm(ALE_eye_area ~ hunting + activity, data = ALE)
summary(m4)

m5 <- lm(ALE_eye_area ~ sex + hunting + activity, data = ALE)
summary(m5)

m6 <- lm(ALE_eye_area ~ sex + activity, data = ALE)

m7 <- lm(ALE_eye_area ~ sex + hunting, data = ALE)

anova(m3, m4, m5, m6, m7)

n <- glm(ALE_eye_area ~ sex+activity+hunting, data = ALE)
summary(n)


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


# *************************************************************
# PLOTTING MADNESS
# *************************************************************
