library(ggplot2)
library(tidyr)
library(dplyr)


#Reshape to long format
df_long_gender <- Germany_subgroup %>%
  select(sector, p_female, p_male) %>%
  pivot_longer(cols = c(p_female, p_male),
    names_to = "gender",
    values_to = "proportion") %>%
  mutate(gender = recode(gender,
    p_female = "Female",
    p_male = "Male"))

#Plot as stacked bar chart
ggplot(df_long_gender, aes(x = reorder(sector, -proportion), y = proportion, fill = gender)) +
  geom_col(position = "stack") +
  coord_flip() +
  labs(
    title = "Percentage of Male and Female Employees",
    x = "Sector",
    y = "Proportion of Full-Time Employees",
    fill = "Gender"
  ) +
  scale_fill_manual(values = c("Female" = "pink", "Male" = "lightblue")) +
  theme_minimal(base_size = 11)
