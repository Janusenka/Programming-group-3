df =Germany_subgroup

# Create quartiles based on average sector income
df$income_quartile = cut(df$income_eur,
  breaks = quantile(df$income_eur, probs = seq(0, 1, 0.25), na.rm = TRUE),
  include.lowest = TRUE,
  labels = c("Q1 (lowest)", "Q2", "Q3", "Q4 (highest)"))
table(df$income_quartile)

# Group summary by quartile
library(dplyr)
quartile_summary = df %>%
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
#Bar plot this-yay doen
# Correlations
cor(df$income_eur, df$p_female)
cor(df$income_eur, df$gpg_2023)
cor(df$gpg_2023, df$p_female)

# Plotting
library(dplyr)
library(tidyr)
library(ggplot2)

# Reshape to long format
quartile_long = quartile_summary %>%
  select(income_quartile, avg_gpg, var_gpg, avg_p_female, var_p_female) %>%
  pivot_longer(
    cols = -income_quartile,
    names_to = "metric",
    values_to = "value"
  )

# Metric labels
quartile_long$metric = recode(quartile_long$metric,
  avg_gpg = "Average GPG",
  var_gpg = "Variance GPG",
  avg_p_female = "Average Female Share",
  var_p_female = "Variance Female Share"
)

# 2×2 layout
ggplot(quartile_long, aes(x = income_quartile, y = value, fill = income_quartile)) +
  geom_col(show.legend = FALSE) +
  facet_wrap(~ metric, ncol = 2, scales = "free_y") +
  labs(
    title = "GPG and Female Share by Income Quartile",
    x = "Income Quartile",
    y = "Value"
  ) +
  theme_minimal(base_size = 12)







