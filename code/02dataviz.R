# data visualization

# packages
library(ggplot2)

# shoreline history
load("data/cleandata/flshore_hist.Rdata")

ggplot(flshore, aes(year, `distance (m)`)) +
  geom_line()


# shoreline profile
load("data/cleandata/flprofile.Rdata")

ggplot(flprofile, aes(distance, elevation)) +
  geom_line()

# wave climate
load("data/cleandata/flwave.Rdata")

## wave direction
ggplot(flwave, aes(compass)) +
  geom_histogram(stat = "count")

ggplot(flwave, aes(dir)) +
  geom_histogram()
### primarily south east wave direction

## wave height
ggplot(flwave, aes(hsig)) +
  geom_histogram(bins = 100)
### rayleigh distribution, right skewed





