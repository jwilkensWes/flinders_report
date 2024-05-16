# data visualization

# packages
library(ggplot2)
library(dplyr)


# shoreline history
load("data/cleandata/flshore_hist.Rdata")

ggplot(flshore, aes(year, distance)) +
  geom_line() +
  geom_point() +
  scale_x_continuous(breaks = seq(min(flshore$year), max(flshore$year), 2),
                     guide = guide_axis(angle = 40)) +
  scale_y_continuous(breaks = seq(-45, 35, 15)) +
  geom_hline(yintercept = 0, linetype = "dashed", color = "blue4") +
  theme_minimal() +
  labs(x = "Year", y = "Distance from 2022 Shoreline (meters)") +
  theme(text = element_text(family = "serif"))


# wave climate
load("data/cleandata/flwave.Rdata")

## wave direction
ggplot(flwave, aes(dir)) +
  geom_histogram(binwidth = 5) +
  scale_x_continuous(breaks = seq(0, 360, 90)) +
  labs(x = "Direction (degrees)", y = "Count") +
  theme_minimal() +
  theme(text = element_text(family = "serif"))

  ### primarily south east wave direction
  
  ## wave height
  ggplot(flwave, aes(hsig)) +
  geom_histogram(bins = 100)
### rayleigh distribution, right skewed

# shoreline profile
load("data/cleandata/flprofile.Rdata")
load("data/cleandata/profileclosuredepth.Rdata")

ggplot(flprofile, aes(distance, elevation)) +
  geom_line() +
  geom_point() +
  geom_hline(yintercept = (-(hc)), linetype = "dashed", color = "red") +
  geom_vline(xintercept = 1375, linetype = "dashed", color = "red")
## cross shore profile is 1375 meters
  



# wave height and shoreline movement

## create average wave height per year
flmeanwave <- flwave %>% group_by(year) %>% 
  summarize(avg_wave_height = mean(hsig))

## plot avg wave height with shoreline position over time
s <- ggplot(flshore, aes(year, distance))+
  geom_line()
w <- ggplot(flmeanwave, aes(year, avg_wave_height)) +
  geom_line()
s
w

## plot avg wave height against shoreline position
flwaveshore <- flshore %>% full_join(flmeanwave)

ggplot(flwaveshore, aes(x = avg_wave_height, y = distance)) +
  geom_point() +
  geom_smooth(method = "lm")

md <- lm(distance ~ avg_wave_height, data = flwaveshore)
summary(md)


