#############################################################################################################################
#############################################################################################################################
##                                                                                                                         ##
##                              This file loads EPA data on particlant matter from the API using the                       ##
##                              RAQSAPI package and loads the birthweight data from the California                         ##
##                                        Department of Health and Human Services as csv file                              ##
##                                                                                                                         ##
#############################################################################################################################


##### Load the necessary packages
#####

library(tidyverse)
library(RAQSAPI)

##### --
#####


##### Download birthweight data from California Health and Human Services
#####
download.file("https://data.chhs.ca.gov/dataset/a48f9312-5b61-479d-98fb-9cfb2ccde481/resource/8eb6fed1-fe7e-4ea9-a71e-99a95fa0edf7/download/low-and-very-low-birthweight-by-county-2014-2018.csv",
              destfile = "data/raw/birthweight.csv")

### Include a file indicating the last time the data was pulled
write_file(paste0("Birthweight data last downloaded ", Sys.Date()),
           file = paste0("data/raw/last_pull_birthweight_data_", Sys.Date(), ".txt")
)

##### --
#####

##### Pull EPA Air Quality data from the API. Access is open to anyone but signing up is required
##### https://aqs.epa.gov/aqsweb/documents/data_api.html#signup
#####
### first pull the api key from a file api_key.R This is done separately to prevent personal API keys from being shared.
### alternatively, the command `api_key <- "yourapikeyhere"` & email <- "youremailhere" 
### used instead of the line sourcing the file will work as well.
source("api_key.R")

### pass the user credentials to be used
aqs_credentials(
  username = email,
  key = api_key
)

### create a list of all the county fips in CA
county_list <- aqs_counties_by_state("06", return_header = FALSE) %>%
  pull(county_code)

county_match <- aqs_counties_by_state("06", return_header = FALSE)

### make the request parameter code list can be found at https://aqs.epa.gov/aqsweb/documents/codetables/methods_all.html
epa_county <- aqs_annualsummary_by_county(parameter = "88128", stateFIPS = "06", countycode = county_list,
                            bdate = as.Date("2018-01-01"),  edate = as.Date("2018-12-31")) %>%
  left_join(county_match, by = "county_code")

### save the epa data to a csv file
write_csv(epa_county, file = "data/raw/epa_county.csv")


### Include a file indicating the last time the data was pulled
write_file(paste0("EPA data last downloaded ", Sys.Date()),
           file = paste0("data/raw/last_pull_epa_data_", Sys.Date(), ".txt")
)

### clear our environment
remove(county_match, epa_county, api_key, county_list, email)

##### --
#####