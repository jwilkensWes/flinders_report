# calculations

# packages
library(dplyr)

# profile closure depth

load("data/cleandata/flwave.Rdata")

hs_avg <- as.numeric(flwave %>% summarize(avg = mean(hsig)))
hs_stdv <- as.numeric(flwave %>% summarize(stdev = sd(hsig)))

hi <- (hs_avg - 3 * hs_stdv) * sqrt(9.8 / (5000 *))