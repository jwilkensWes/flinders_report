# Analysis, retreat forecasts and wave climate


# shoreline retreat forecast

## data points
load("data/cleandata/profileclosuredepth.Rdata")
sea_rise_100 <- 0.77 # meters, rcp 8.5 2100
sea_rise_50 <- 0.23 # meters, rcp 8.5 2050
cshore_length <- 1375 # meters
berm_height <- 3.6 # meters
rf <- 70.9/2 # meters

retreat_100 <- sea_rise_100 * (cshore_length / (berm_height + hc))
## 72.051
retreat_50 <- sea_rise_50 * (cshore_length / (berm_height + hc))
## 21.522
retreatflux_100 <- rf + retreat_100
## 107.501
retreatflux_50 <- rf + retreat_50
## 56.972


# wave climate

## data points
load("data/cleandata/flwave.Rdata")
load("data/cleandata/hs_avg.Rdata")
load("data/cleandata/hs_stdv.Rdata")

## exceedance calculation
h0.5 <- 2 * hs_stdv * sqrt(2 * log(1 / 0.5 ))
### 1.670 meters
h0.1 <- 2 * hs_stdv * sqrt(2 * log(1 / 0.1 ))
### 3.044 meters
h0.01 <- 2 * hs_stdv * sqrt(2 * log(1 / 0.01 ))
### 4.304 meters
  