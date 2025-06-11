library(ggplot2)
library(tidyr)
library(dplyr)

# Reshape to long format across years and genders
df_long_gender <- TableCountries %>%
  filter(year %in% c(2021, 2022, 2023)) %>%
  select(country, year, p_female, p_male) %>%
  pivot_longer(cols = c(p_female, p_male),
    names_to = "gender",
    values_to = "proportion") %>%
  mutate(gender = recode(gender,
    p_female = "Female",
    p_male = "Male"))

# Plot as stacked bar chart with one panel per year
ggplot(df_long_gender, aes(x = reorder(country, -proportion), y = proportion, fill = gender)) +
  geom_col(position = "stack") +
  coord_flip() +
  facet_wrap(~ year) +
  labs(
    title = "Share of Male and Female Employees by Country (2021–2023)",
    x = "Country",
    y = "Proportion of Full-Time Employees",
    fill = "Gender"
  ) +
  scale_fill_manual(values = c("Female" = "pink", "Male" = "lightblue")) +
  theme_minimal(base_size = 11)+
  theme(
    plot.title.position = "plot",   
    plot.title = element_text(hjust = 0.6, size = 12, face = "bold"), 
    panel.spacing = unit(0.5, "cm"),      
    axis.text.x = element_text(size = 8), 
    strip.text = element_text(size = 12)  
  )

