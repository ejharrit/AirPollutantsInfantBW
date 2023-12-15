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
library(janitor)
library(skimr)

##### --
#####


##### Load the raw data
#####

epa_county <- read_csv("data/raw/epa_county.csv")
birthweight <- read_csv("data/raw/birthweight.csv")

##### --
#####


##### get a look at the datasets
#####

glimpse(epa_county)
glimpse(birthweight)

skim(epa_county)
skim(birthweight)

### make sure the epa data set only includes California
epa_county %>%
  distinct(state_code)

### and only data from 2018
epa_county %>%
  distinct(year)

##### --
#####


##### Select only the necessary columns and join the tables
#####
hap_data <- epa_county %>%
  ### select only the epa_county columns we need
  distinct(county_name, parameter, arithmetic_mean) %>%
  ### join to the birthweight data set
  left_join(
    birthweight %>%
      ### filter to only include data from 2018
      filter(Year == 2018) %>%
      ### select only the columns we need
      distinct(County, `Birthweight Type`, Percent) %>%
      ### pivot wider so "Low Birthweight" and "Very Low Birthweight" have their own columns
      pivot_wider(names_from = `Birthweight Type`, values_from = Percent),
    by = c("county_name" = "County")
  ) %>%
  ### use the janitor package to clean up the names real fast
  clean_names()

##### --
#####


##### Save the data
#####

write_csv(hap_data, file = "data/cleaned/hap_data.csv")

### clean our environment
remove(birthweight, epa_county, hap_data)

##### --
#####
