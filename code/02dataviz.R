# data visualization

# packages
library(ggplot2)
library(dplyr)

# shoreline history
load("data/cleandata/flshore_hist.Rdata")

ggplot(flshore, aes(year, `distance (m)`)) +
  geom_line() +
  geom_point()


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


# wave height and shoreline movement

## create average wave height per year
flmeanwave <- flwave %>% group_by(year) %>% 
  summarize(avg_wave_height = mean(hsig))

## plot avg wave height with shoreline position over time
s <- ggplot(flshore, aes(year, `distance (m)`))+
  geom_line()
w <- ggplot(flmeanwave, aes(year, avg_wave_height)) +
  geom_line()
s
w

## plot avg wave height against shoreline position
flwaveshore <- flshore %>% full_join(flmeanwave)

ggplot(flwaveshore, aes(x = avg_wave_height, y = `distance (m)`)) +
  geom_point() +
  geom_smooth(method = "lm")

md <- lm(`distance (m)` ~ avg_wave_height, data = flwaveshore)
summary(md)


