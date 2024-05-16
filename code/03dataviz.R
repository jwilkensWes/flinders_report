# data visualization

# packages
library(ggplot2)
library(dplyr)
library(ggpubr)

# data sets
load("data/cleandata/flwave.Rdata")
load("data/cleandata/flshore_hist.Rdata")
load("data/cleandata/flprofile.Rdata")
load("data/cleandata/profileclosuredepth.Rdata")


# wave height and shoreline movement
## shoreline history

ggplot(flshore, aes(year, distance)) +
  geom_line() +
  geom_point() +
  scale_x_continuous(breaks = seq(min(flshore$year), max(flshore$year), 2),
                     guide = guide_axis(angle = 40)) +
  scale_y_continuous(breaks = seq(-45, 35, 15)) +
  geom_hline(yintercept = 0, linetype = "dashed", color = "grey40") +
  theme_bw() +
  labs(x = "Year", y = "Distance from 2022 Shoreline (meters)") +
  theme(text = element_text(family = "serif"))

ggsave("reports/shoreline_history.png", scale = 2)

## wave direction
ggplot(flwave, aes(dir)) +
  geom_histogram(binwidth = 5, color = "black", fill = "grey40") +
  scale_x_continuous(breaks = seq(0, 360, 90)) +
  labs(x = "Direction \u00b0N", y = "Count") +
  theme_bw() +
  theme(text = element_text(family = "serif"))
  ### primarily south east wave direction
ggsave("reports/wave_direction.png", scale = 2)

  
## wave height
ggplot(flwave, aes(hsig)) +
  geom_histogram(bins = 100, color = "black", fill = "blue3") +
  labs(x = "Significant Wave Height (meters)", y = "Count") +
  scale_x_continuous(breaks = seq(0, 8, 1)) +
  theme_bw() +
  theme(text = element_text(family = "serif"))
### rayleigh distribution, right skewed
ggsave("reports/wave_height.png", scale = 2)

## create average wave height per year

flmeanwave <- flwave %>% group_by(year) %>% 
  summarize(avg_wave_height = mean(hsig))

## plot avg wave height against shoreline position
flwaveshore <- flshore %>% full_join(flmeanwave)

ggplot(flwaveshore, aes(x = avg_wave_height, y = distance)) +
  geom_point() +
  geom_smooth(method = "lm", se = FALSE, color = "grey40") +
  theme_bw() +
  labs(x = "Mean Significant Wave Height (meters)", 
       y = "Distance from 2022 Shoreline (meters)") +
  theme(text = element_text(family = "serif"))
ggsave("reports/wave_height_vs_shoreline.png", scale = 2)

md <- lm(distance ~ avg_wave_height, data = flwaveshore)
summary(md)

# shoreline profile

ggplot(flprofile, aes(distance, elevation)) +
  geom_line() +
  geom_point() +
  #geom_hline(yintercept = (-(hc)), linetype = "dashed", color = "blue3") +
  #geom_vline(xintercept = 1375, linetype = "dashed", color = "blue3") +
  labs(x = "Distance (meters)", y = "Elevation (meters)") +
  scale_x_continuous(breaks = seq(-1000, 4000, 500)) +
  scale_y_continuous(breaks = seq(-30, 15, 5)) +
  theme_bw() +
  theme(text = element_text(family = "serif"))
### cross shore profile is 1375 meters
### berm height is 3.6 meters
ggsave("reports/shoreline_profile.png", scale = 2)

  




