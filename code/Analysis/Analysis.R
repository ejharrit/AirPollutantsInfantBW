#############################################################################################################################
#############################################################################################################################
##                                                                                                                         ##
##                              This file this file performs the statistical analysis on the                               ##
##                                  data we cleaned in the CleanRawDatAndSave.R file                                       ##
##                                                                                                                         ##
##                                                                                                                         ##
#############################################################################################################################

##### Load the necessary packages
#####

library(tidymodels)
library(tidyverse)

##### --
#####


##### Load the data
#####

hap_data <- read_csv("data/cleaned/hap_data.csv")

##### --
#####


##### Simple linear regression between the average measure of Lead pm2.5 and the percent of low birthweight births
### fit the model
lm_fit <- linear_reg() %>%
  set_engine("lm") %>%
  fit(low_birthweight ~ arithmetic_mean, data = hap_data %>% filter(arithmetic_mean < 0.01))

### check output
tidy(lm_fit)
glance(lm_fit)

### plot the linear model
hap_data %>%
  filter(arithmetic_mean < 0.01) %>%
  ggplot(aes(y = low_birthweight, x = arithmetic_mean)) +
  geom_point() +
  stat_smooth(method = "lm", formula = y ~ x, geom = "smooth")
