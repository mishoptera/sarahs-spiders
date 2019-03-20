# Author: Misha Leong
# Date: March 2019
# Project: Sample code for Sarah to run on her spider eyes


# *************************************************************
# FIRST THINGS FIRST
# *************************************************************

# load libraries
library(tidyverse)
library(corrplot)
library(vegan)
library(ggrepel)
library(ggpubr)
library(stringr)

# load file
sarah <- read_csv("raw.csv") %>% drop_na()


# *************************************************************
# CORRELATIONS BETWEEN VARIABLES?
# *************************************************************
M <- cor(sarah)
corrplot(M, method = "number")
ggsave("figures_n_tables/corrplot.png", width = 15, height = 15, units = "cm")
