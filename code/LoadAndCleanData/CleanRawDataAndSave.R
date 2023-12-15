#############################################################################################################################
#############################################################################################################################
##                                                                                                                         ##
##                              This file loads the data we pulled from the LoadData.R                                     ##
##                                  file cleans it and saves the new data format                                           ##
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

epa_county <- read_csv("data/raw/epa_county.csv")
birthweight <- read_csv("data/raw/birthweight.csv")

##### --
#####


##### get a look at the datasets
#####

glimpse(epa_county)
glimpse(birthweight)

##### --
#####