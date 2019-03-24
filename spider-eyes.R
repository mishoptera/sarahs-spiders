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
eyes<- read_csv("raw.csv") 

eyes %<>% select(-c(ratio.num.ridges.to.body.size, ratio.cuticle.ridge.size.to.body.size,
                    ratio.ridge.size.to.body.size)) %>%
  slice(-19)
  
eyes$AME.cuticle.ridge.size %<>% as.numeric()
eyes$ratio.cuticle.ridge.size.to.eye.size %<>% as.numeric()
eyes$ratio.ridge.size.to.eye.size %<>% as.numeric()
str(eyes)


# *************************************************************
# CORRELATIONS BETWEEN VARIABLES
# *************************************************************
eyes.no.na <- eyes %>% 
  select(-c(sex, active.time, eco)) %>%
  drop_na()
M <- cor(eyes.no.na %>% select(num.ridges:AME.outer.edge.distance.micron))
corrplot(M, method = "color")


# *************************************************************
# THE QUESTIONS!
# *************************************************************
# ANOVA cheat sheet http://www.quantide.com/wp-content/uploads/2017/02/Three-way-Anova-with-R.pdf

# for ridge number
m.num.ridges <- aov(est.num.ridges ~ sex * active.time * eco, data = eyes)
summary(m.num.ridges)

m.num.ridges <- aov(num.ridges.per.micron ~ sex * active.time * eco, data = eyes)
summary(m.num.ridges)

# for eye size
m.eye.size <- aov(AME.entire.eye ~ sex * active.time * eco, data = eyes)
summary(m.eye.size)

# for ridge size (trough)
m.ridge.size <- aov(AME.ridge.trough ~ sex * active.time * eco, data = eyes)
summary(m.ridge.size)

# for ridge size (?)
m.ridge.size <- aov(AME.ridges ~ sex * active.time * eco, data = eyes)
summary(m.ridge.size)


