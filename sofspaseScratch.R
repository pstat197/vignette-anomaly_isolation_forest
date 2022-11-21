# loading packages
library(isotree)
library(mlbench)
library(MLmetrics)
library(kableExtra)
library(ggplot2)

# loading data
load("vignette-group6/data/fertility_rate.RData")
View(fertility_rate)

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
