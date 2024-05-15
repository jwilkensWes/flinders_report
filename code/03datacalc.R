# calculations

# packages
library(dplyr)

# data
load("data/cleandata/flwave.Rdata")
load("data/cleandata/flgrain.Rdata")

# hi calc, wave impact on sediment transport

## significant wave height average, 1.647 meters
hs_avg <- as.numeric(flwave %>% summarize(avg = mean(hsig)))

## significant wave height standard deviation, 0.709, meters
hs_stdv <- as.numeric(flwave %>% summarize(stdev = sd(hsig)))

## mean significant wave period, 6.334 secs
ts_avg <- as.numeric(flwave %>% summarize(avg = mean(tz)))

## grain size mean, 0.000238 meters
gsize_avg <- as.numeric(flgrain %>% summarize(avg = mean(numval))) / 1000

## the depth at which waves have an impact of sediment transport: 26.090 meters
hi <- (hs_avg - 0.3 * hs_stdv) * ts_avg * sqrt(9.8 / (5000 * gsize_avg))


# hc calc, profile closure depth

## profile closure depth: 11.094 meters
hc <- (2 * hs_avg + 11 * hs_stdv)
save(hc, file = "data/cleandata/profileclosuredepth.Rdata")


# shoreline retreat forecast

## data points
sea_rise_100 <- 0.77 # rcp 8.5 2100
sea_rise_50 <- 0.40 # rcp 8.5 2050
cshore_length <- 1375
berm_height <- 3.8 # meters

retreat_100 <- sea_rise_100 * (cshore_length / (berm_height + hc))
## 71.084
retreat_50 <- sea_rise_50 * (cshore_length / (berm_height + hc))
## 36.927


