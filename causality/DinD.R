# Reference
# https://bookdown.org/ccolonescu/RPoE4/indvars.html#the-difference-in-differences-estimator
library(devtools)
library(tidyverse)
library(stargazer)
install_github("ccolonescu/PoEdata")
library(PoEdata)

# The following example calculates this estimator for the dataset  njmin3 , where the response is  fte , the full-time equivalent employment,  d  is the after dummy, with  d=1  for the after period and  d=0  for the before period, and  nj  is the dummy that marks the treatment group ( nji=1  if unit  i  is in New Jersey where the minimum wage law has been changed, and  nji=0  if unit  i  in Pennsylvania, where the minimum wage law has not changed). In other words, units (fast-food restaurants) located in New Jersey form the treatment group, and units located in Pennsylvania form the control group.

data("njmin3")
# 820 observations of 14 variables
summary(njmin3)

# d-in-d
mod1 <- lm(fte~nj*d, data=njmin3)

mod2 <- lm(fte~nj*d+
             kfc+roys+wendys+co_owned, data=njmin3)

mod3 <- lm(fte~nj*d+
             kfc+roys+wendys+co_owned+
             southj+centralj+pa1, data=njmin3)

stargazer(mod1,mod2,mod3, 
          type="text",
          title="Difference in Differences example",
          header=FALSE, keep.stat="n",digits=2,
          single.row=TRUE, intercept.bottom=FALSE)

# t-ratio for delta, the D-in-D estimator:
tdelta <- summary(mod1)$coefficients[4,3]

