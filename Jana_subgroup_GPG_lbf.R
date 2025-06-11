library(ggplot2)

ggplot(data = Germany_subgroup, aes(x = income_eur, y = gpg_2023)) +
  geom_point(size = 2) +
  geom_smooth(method = "lm", se = TRUE, color = "deeppink") +
  scale_y_continuous("Unadjusted Gender Pay Gap (%)",
                     breaks = seq(-5, 30, 5),
                     limits = c(-5, 30)) +
  scale_x_continuous("Average Monthly Income (€)",
                     breaks = seq(2500, 6000, 500),
                     limits = c(2500, 6000)) +
  theme_minimal(base_size = 12) +
  labs(
    title = "GPG vs. Average Monthly Income by Sector (Germany 2023)",
    subtitle = "Each point is a sector • Line is linear regression (method = 'lm')"
  )
