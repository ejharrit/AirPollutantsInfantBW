#############################################################################################################################
#############################################################################################################################
##                                                                                                                         ##
##                              This file this file performs an exploratory analysis on the                                ##
##                                  data we cleaned in the CleanRawDatAndSave.R file                                       ##
##                                                                                                                         ##
##                                                                                                                         ##
#############################################################################################################################


##### Load the necessary packages
#####

library(tidyverse)

##### --
#####


##### Load the data
#####

hap_data <- read_csv("data/cleaned/hap_data.csv")

##### --
#####


##### Descriptive Statistics
#####
### Summary statistics of our numerical variables of interest
hap_data %>%
  select(arithmetic_mean, low_birthweight, very_low_birthweight) %>%
  summary()

### check if the distribution of the variables
hap_data %>%
  select(arithmetic_mean, low_birthweight, very_low_birthweight) %>%
  pivot_longer(everything(), names_to = "variable", values_to = "value") %>%
  ggplot(aes(x = value)) +
  geom_histogram() +
  facet_grid(rows = vars(variable), scales = "free")

### check them individually for a better view
### average PM2.5 measure
hap_data %>%
  ggplot(aes(x = arithmetic_mean)) +
  geom_histogram()

### percent of low weight births
hap_data %>%
  ggplot(aes(x = low_birthweight)) +
  geom_histogram()

### percent of very low weight births
hap_data %>%
  ggplot(aes(x = very_low_birthweight)) +
  geom_histogram()

##### --
#####

##### Clean our environment
#####
remove(hap_data)

##### --
#####
