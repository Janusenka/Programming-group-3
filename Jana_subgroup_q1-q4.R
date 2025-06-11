# Create quartiles based on average sector income
df$income_quartile <- cut(df$income_eur,
  breaks = quantile(df$income_eur, probs = seq(0, 1, 0.25), na.rm = TRUE),
  include.lowest = TRUE,
  labels = c("Q1 (lowest)", "Q2", "Q3", "Q4 (highest)"))
table(df$income_quartile)

# Group summary by quartile
library(dplyr)

quartile_summary <- df %>%
  group_by(income_quartile) %>%
  summarise(
    avg_income = mean(income_eur),
    avg_gpg = mean(gpg_2023),
    var_gpg = var(gpg_2023),
    avg_p_female = mean(p_female),
    var_p_female = var(p_female),
    n_sectors = n()
  )
View(quartile_summary)

# Correlations
cor(df$income_eur, df$p_female)
cor(df$income_eur, df$gpg_2023)
cor(df$gpg_2023, df$p_female)