library(gt)
library(scales)  # for col_numeric()

df_wide %>%
  mutate(
    across(c(income_2021, income_2023), round, 0),
    recovery_ratio = round(recovery_ratio, 2),
    recovery_percent = round(recovery_percent, 1)
  ) %>%
  gt() %>%
  data_color(
    columns = vars(recovery_ratio),
    colors = scales::col_numeric(palette = c("white", "violet"), domain = NULL)
  ) %>%
  data_color(
    columns = vars(recovery_percent),
    colors = scales::col_numeric(palette = c("white", "cadetblue1"), domain = NULL)
  ) %>%
  tab_header(
    title = "Wage Recovery Across EU (2023 vs. 2021)"
  )


