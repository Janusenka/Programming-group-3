library(ggplot2)
library(dplyr)

# Ensure year is factor
TableCountries$year <- as.factor(TableCountries$year)

# Define EU country order
eu_countries <- c(
  "Austria", "Belgium", "Bulgaria", "Croatia", "Cyprus", "Czechia",
  "Denmark", "Estonia", "Finland", "France", "Germany", "Greece",
  "Hungary", "Ireland", "Italy", "Latvia", "Lithuania", "Luxembourg",
  "Malta", "Netherlands", "Poland", "Portugal", "Romania", "Slovakia",
  "Slovenia", "Spain", "Sweden"
)

# Filter and arrange data
filtered_data <- TableCountries %>%
  filter(country %in% eu_countries) %>%
  mutate(year_numeric = as.numeric(as.character(year))) %>%
  arrange(factor(country, levels = eu_countries))

# Plot
ggplot(filtered_data, aes(x = year_numeric, y = monthly_income, group = 1)) +
  geom_line(color = "mediumorchid", linewidth = 0.7) +
  geom_point(color = "darkmagenta", size = 2) +
  geom_vline(xintercept = 2021.5, linetype = "dashed", color = "red", linewidth = 0.5) +
  facet_wrap(~ country, ncol = 4, nrow = 7) +
  scale_x_continuous(breaks = c(2021, 2022, 2023)) +
  scale_y_continuous(limits = c(500, NA)) +
  labs(
    title = "Average Monthly Income in EU Countries (2021–2023)((red-line indicates beginning of covid-19 recovery))",
    x = "Year", y = "Monthly Income (€)"
  ) +
  theme_minimal(base_size = 11) +
  theme(
    strip.text = element_text(size = 9, face = "bold"),
    axis.text.x = element_text(angle = 45, hjust = 1),
    plot.title = element_text(size = 16, hjust = 0.5, face = "bold"),
    panel.grid.major = element_line(color = "grey90"),
    panel.grid.minor = element_blank()
  )
