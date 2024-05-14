## Data Management

# packages
library(readr)
library(readxl)
library(dplyr)

# shoreline history from Digital Earth Australia Coastlines
flshore <- read_csv("data/rawdata/deaflindersbeachhistoricalshoreline.csv")
# convert to lowercase
flshore$year <- flshore$Year
flshore$`distance (m)` <- flshore$`Distance (m)` 
flshore$Year <- NULL
flshore$`Distance (m)`<- NULL
# save file
save(flshore, file = "data/cleandata/flshore_hist.Rdata")

# beach profile
flprofile <- read_excel("data/rawdata/Flinders_Profile.xlsx")
# convert to lowercase
flprofile$distance <- flprofile$Distance
flprofile$Distance <- NULL
flprofile$elevation <- flprofile$Elevation
flprofile$Elevation <- NULL
flprofile
# save file
save(flprofile, file = "data/cleandata/flprofile.Rdata")


# wave data
flwave <- read_excel("data/rawdata/bris_waves_cleaned.xlsx")

# add directions as cats
flwave <- flwave %>% mutate(compass = case_when(
  dir > 0 & dir < 90 ~ "NE",
  dir > 90 & dir < 180 ~ "SE",
  dir > 180 & dir < 270 ~ "SW",
  dir > 270 ~ "NW"
))
  
# save file
save(flwave, file = "data/cleandata/flwave.Rdata")



