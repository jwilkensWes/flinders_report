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


# shoreline retreat forecast

##

retreat <- sea_rise * (cshore_length / )

