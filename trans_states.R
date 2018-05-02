#ggplot transition states testing
library(tidyverse)
library(gganimate) # this package is currently under development
# https://github.com/thomasp85/gganimate
ggplot(mtcars, aes(mpg, disp, colour = factor(carb))) + 
  geom_point(size = 4, alpha = 1) +
  transition_states(gear, transition_length = 4, state_length = 1) + 
  ease_aes('linear', y = 'bounce-out', x = 'quadratic-out')
