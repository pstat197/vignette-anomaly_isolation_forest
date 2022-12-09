# load packages and data
require(tidyverse)
require(isotree)
require(mlbench)
require(MLmetrics)
require(kableExtra)
require(ggplot2)
require(dplyr)
require(yardstick)

load("data/creditcard.RData")
# iForest is an unsupervised algorithm, so we remove the labels
# from these data
class <- credit %>% select(Class)
credit <- credit %>% select(-Class)

# plot data
ggplot(credit, aes(x = Time, y = Amount)) +
  geom_point(shape = 1, alpha = 0.5) +
  labs(x = "Time", y = "Transaction Amount") +
  labs(alpha = "", color = "Legend")

# create an iForest with default parameters
model_orig <- isolation.forest(
  credit,
  ndim = 1,
  sample_size = 256,
  ntrees = 1000,
  missing_action = "fail"
)
# make predictions using the iForest model
pred_orig <- predict(model_orig, credit)

# density iForest
model_dens <- isolation.forest(
  credit,
  ndim = 1,
  sample_size = 256,
  ntrees = 1000,
  missing_action = "fail",
  scoring_metric = "density"
)
# density iForest predictions
pred_dens <- predict(model_dens, credit)

# fair-cut iForest
model_fcf <- isolation.forest(
  credit,
  ndim = 1,
  sample_size = 32,
  prob_pick_pooled_gain = 1,
  ntrees = 1000,
  missing_action = "fail"
)
# fair-cut iForest predictions
pred_fcf <- predict(model_fcf)

# store AUC measurements for each model type
results_df <- data.frame(
  Model = c(
    "Isolation Forest",
    "Density Isolation Forest",
    "Fair-Cut Forest"
  ),
  AUROC = c(
    AUC(pred_orig, class),
    AUC(pred_dens, class),
    AUC(pred_fcf, class)
  )
)
# display
results_df %>%
  kable() %>%
  kable_styling()

# outlier plot
ggplot(credit, aes(x = Time, y = Amount, color = pred_orig)) +
  geom_point(alpha = 0.5, fill = pred_orig) +
  labs(x = "Time", y = "Transaction Amount") +
  labs(alpha = "", color = "Legend") +
  scale_color_gradient(low = "yellow", high = "purple")