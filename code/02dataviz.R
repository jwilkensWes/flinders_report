# data visualization

# packages
library(ggplot2)

# shoreline history
load("data/cleandata/flshore_hist.Rdata")

ggplot(flshore, aes(year, `distance (m)`)) +
  geom_line()


# shoreline profile
load("data/cleandata/flprofile.Rdata")
load("data/cleandata/profileclosuredepth.Rdata")

ggplot(flprofile, aes(distance, elevation)) +
  geom_line() +
  geom_point() +
  geom_hline(yintercept = (-(hc)), linetype = "dashed", color = "red") +
  geom_vline(xintercept = 1375, linetype = "dashed", color = "red")
## cross shore profile is 1375 meters
  

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





