# load packages and data
require(ggplot2)
require(tidyverse)
require(solitude)

load("data/creditcard.csv")

class <- credit %>% select(Class)
credit <- credit %>% select(Time, Amount)

#plot data
ggplot(credit, aes(x = Time, y = Amount)) + 
  geom_point(shape = 1, alpha = 0.5) +
  labs(x = "Time", y = "Transaction Amount") +
  labs(alpha = "", color="Legend")

# create isolation forest using isolationForest function from solitude package 
# with default parameters
iforest <- isolationForest$new(num_trees = 1000)

iforest$fit(credit)

#predict outliers within dataset
credit$pred <- iforest$predict(credit)
credit$outlier <- as.factor(ifelse(credit$pred$anomaly_score >=0.75, "outlier", "normal"))

#plot data
ggplot(credit, aes(x = Time, y = Amount, color = outlier)) + 
  geom_point(shape = 1, alpha = 0.5) +
  labs(x = "Time", y = "Transaction Amount") +
  labs(alpha = "", color="Legend")
