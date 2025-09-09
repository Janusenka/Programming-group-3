library(dplyr)
library(tidyr)
library(ggplot2)

# Dataset
df_recovery = TableCountries %>%
  filter(year %in% c(2021, 2023)) %>%
  select(country, year, monthly_income)

# Recovery ratio
df_wide = df_recovery %>%
  pivot_wider(names_from = year, values_from = monthly_income, names_prefix = "income_") %>%
  mutate(
    recovery_ratio = round(income_2023 / income_2021, 2),
    recovery_percent = round((income_2023 - income_2021) / income_2021 * 100, 1)
  ) %>%
  filter(country != "European Union - 27 countries (from 2020)")

# Add regions
region_map = c(
  "Austria" = "Western Europe", "Belgium" = "Western Europe", "France" = "Western Europe", "Germany" = "Western Europe",
  "Netherlands" = "Western Europe", "Ireland" = "Western Europe", "Luxembourg" = "Western Europe",
  
  "Spain" = "Southern Europe", "Portugal" = "Southern Europe", "Italy" = "Southern Europe", "Greece" = "Southern Europe",
  "Croatia" = "Southern Europe", "Malta" = "Southern Europe", "Slovenia" = "Southern Europe", "Cyprus" = "Southern Europe",
  
  "Poland" = "Eastern Europe", "Romania" = "Eastern Europe", "Bulgaria" = "Eastern Europe", "Hungary" = "Eastern Europe",
  
  "Czechia" = "Central Europe", "Slovakia" = "Central Europe", "Estonia" = "Central Europe", "Latvia" = "Central Europe", "Lithuania" = "Central Europe",
  
  "Sweden" = "Northern Europe", "Denmark" = "Northern Europe", "Finland" = "Northern Europe", "Norway" = "Northern Europe"
)

df_wide$region = region_map[df_wide$country]

# Plot
ggplot(df_wide, aes(x = reorder(country, recovery_ratio), y = recovery_ratio, fill = recovery_ratio > 1)) +
  geom_col() +
  geom_text(aes(label = recovery_ratio), hjust = 0.6, size = 3.5) +
  coord_flip() +
  facet_wrap(~ region, scales = "free_y", ncol = 3) +
  geom_hline(yintercept = 1, linetype = "dashed", color = "white") +
  scale_fill_manual(
    values = c("TRUE" = "palegreen", "FALSE" = "lightcoral"),
    labels = c("Below 2021", "Recovered"),
    name = "Recovery Status"
  ) +
  labs(
    title = "Wage Recovery by Region in Europe (2023 vs 2021)",
    y = "Recovery Ratio (2023 ÷ 2021)"
  ) +
  theme_minimal(base_size = 12) +
  theme(
    legend.position = "top",
    legend.title = element_text(face = "bold"),
    axis.title.y = element_blank(),
    axis.text.y = element_text(size = 11),
    axis.text.x = element_text(size = 11),
    strip.text = element_text(face = "bold", size = 13),
    plot.title = element_text(face = "bold", hjust = 0.5)
  )