# loading packages
library(tidyverse)
library(isotree)
library(mlbench)
library(MLmetrics)
library(kableExtra)
library(ggplot2)
library(dplyr)
library(yardstick)

# loading data
load("vignette-group6/data/fertility_rate.RData")
View(fertility_rate)

###################################
# SCROLL DOWN FOR THE CREDIT DATA #
###################################

# Isolation Forest
model_orig <- isolation.forest(
  fertility_rate,
  ndim=1, sample_size=nrow(fertility_rate),
  ntrees=100,
  missing_action="fail"
)
pred_orig <- predict(model_orig, fertility_rate)

# Density Isolation Forest
model_dens <- isolation.forest(
  fertility_rate,
  ndim=1, sample_size=nrow(fertility_rate),
  ntrees=100,
  missing_action="fail",
  scoring_metric="density"
)
pred_dens <- predict(model_dens, fertility_rate)

# Fair-Cut Forest
model_fcf <- isolation.forest(
  fertility_rate,
  ndim=1, sample_size=32,
  prob_pick_pooled_gain=1,
  ntrees=100,
  missing_action="fail"
)
pred_fcf <- predict(model_fcf, fertility_rate)





# AUC giving NaN for all the values
results_df <- data.frame(
  Model = c(
    "Isolation Forest",
    "Density Isolation Forest",
    "Fair-Cut Forest"
  ),
  AUROC = c(
    AUC(pred_orig, fertility_rate$X2008),
    AUC(pred_dens, fertility_rate$X2008),
    AUC(pred_fcf, fertility_rate$X2008)
  )
)
results_df %>%
  kable() %>%
  kable_styling()



################
# CREDEIT DATA #
################

## Trying the same code with credit card anomalies

# loading data
load("vignette-group6/data/creditcard.RData")
View(credit)

#credit_no_class <- credit %>% select(c(Time, Amount))
credit_no_class <- credit %>% select(-Class)

# Isolation Forest
model_orig <- isolation.forest(
  credit_no_class,
  ndim=1, sample_size=256,
  ntrees=1000,
  missing_action="fail"
)
pred_orig <- predict(model_orig, credit_no_class)

# Density Isolation Forest
model_dens <- isolation.forest(
  credit_no_class,
  ndim=1, sample_size=256,
  ntrees=1000,
  missing_action="fail",
  scoring_metric="density"
)
pred_dens <- predict(model_dens, credit_no_class)

# Fair-Cut Forest
model_fcf <- isolation.forest(
  credit_no_class,
  ndim=1, sample_size=32,
  prob_pick_pooled_gain=1,
  ntrees=1000,
  missing_action="fail"
)
pred_fcf <- predict(model_fcf, credit_no_class)

"In the case of anomolies, our metric of choice is going to be the area 
under the curve. Accuracy is not the best metric in this case since there
are few outliers and classifying the entire dataset as normal points would
still yeild a high accuracy rate. The ROC curve on the other hand, finds a 
balance between sensitivity (true positives) and specificity 
(false positives) giving us better insight into how well our models worked."

results_df <- data.frame(
  Model = c(
    "Isolation Forest",
    "Density Isolation Forest",
    "Fair-Cut Forest"
  ),
  AUROC = c(
    AUC(pred_orig, credit$Class),
    AUC(pred_dens, credit$Class),
    AUC(pred_fcf, credit$Class)
  )
)
results_df %>%
  kable() %>%
  kable_styling()


ggplot(credit, aes(x = Time, y = Amount, color = pred_orig)) +
  geom_point(alpha = 0.5, fill = pred_orig) +
  labs(x = "Time", y = "Transaction Amount") +
  labs(alpha = "", color = "Legend") +
  scale_color_gradient(low = "yellow", high = "purple")


