# Load necessary libraries
library(dplyr)
library(ggplot2)
library(maps)
library(viridis)

# View the data
View(main_data_csv)

# Define EU countries in lowercase
eu_countries <- tolower(c(
  "Austria", "Belgium", "Bulgaria", "Croatia", "Cyprus", "Czech Republic", "Denmark",
  "Estonia", "Finland", "France", "Germany", "Greece", "Hungary", "Ireland", "Italy",
  "Latvia", "Lithuania", "Luxembourg", "Malta", "Netherlands", "Poland", "Portugal",
  "Romania", "Slovakia", "Slovenia", "Spain", "Sweden"
))

# Filter 2022 data for EU countries
data_2022 <- main_data_csv %>%
  filter(year == 2022) %>%
  mutate(country = tolower(country)) %>%
  filter(country %in% eu_countries)

# Get world map data and format country names
world_map <- map_data("world") %>%
  rename(country = region) %>%
  mutate(country = tolower(country))

# Join map data with 2022 data
eu_map <- world_map %>%
  filter(country %in% eu_countries) %>%
  left_join(data_2022, by = "country")

# Plot the EU map with gender pay gap
ggplot(eu_map, aes(long, lat, group = group, fill = gender_pay_gap)) +
  geom_polygon() +
  coord_fixed(1.1) +
  scale_fill_viridis(name = "Pay Gap (%)", option = "plasma") +
  ggtitle("Gender Pay Gap in EU Countries (2022)")