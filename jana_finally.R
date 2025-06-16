# Load required libraries
library(dplyr)
library(ggplot2)
library(sf)
library(rnaturalearth)
library(countrycode)

# Prepare data and manually fix country names
eu_data <- TableCountries %>%
  filter(year == 2022) %>%
  mutate(country = case_when(
    country == "FR" ~ "France",  # <- adjust this as needed
    TRUE ~ country
  )) %>%
  mutate(iso3 = countrycode(country, "country.name", "iso3c"))

# Check for countries that didn't get ISO3 codes
missing <- eu_data %>% filter(is.na(iso3))
if (nrow(missing) > 0) {
  print("❌ Missing ISO3 for:")
  print(unique(missing$country))
}

# Load Europe map as sf object
europe_map <- ne_countries(scale = "medium", returnclass = "sf") %>%
  filter(region_un == "Europe")

# Join data to map
map_data <- left_join(europe_map, eu_data, by = c("iso_a3" = "iso3"))

# Common plot theme
map_theme <- theme_minimal(base_size = 14) +
  theme(
    axis.text = element_blank(),
    axis.ticks = element_blank(),
    panel.grid = element_blank(),
    plot.title = element_text(size = 18, face = "bold", hjust = 0.5),
    legend.title = element_text(size = 12),
    legend.text = element_text(size = 10)
  )

# Plot 1: Female Income
ggplot(map_data) +
  geom_sf(aes(fill = female_income), color = "white", size = 0.2) +
  scale_fill_gradient(low = "#FFE5EC", high = "#C9184A", na.value = "grey90") +
  coord_sf(xlim = eu_xlim, ylim = eu_ylim, expand = FALSE) +
  labs(title = "Female Income (2022)", fill = "€ / month") +
  map_theme

# Plot 2: Male Income
ggplot(map_data) +
  geom_sf(aes(fill = male_income), color = "white", size = 0.2) +
  scale_fill_gradient(low = "#D0E8FF", high = "#00509D", na.value = "grey90") +
  coord_sf(xlim = eu_xlim, ylim = eu_ylim, expand = FALSE) +
  labs(title = "Male Income (2022)", fill = "€ / month") +
  map_theme

# Plot 3: Average Income (No-GPG)
ggplot(map_data) +
  geom_sf(aes(fill = monthly_income), color = "white", size = 0.2) +
  scale_fill_gradient(low = "#EBD4FF", high = "#6A0572", na.value = "grey90") +
  coord_sf(xlim = eu_xlim, ylim = eu_ylim, expand = FALSE) +
  labs(title = "Average Income (No-GPG, 2022)", fill = "€ / month") +
  map_theme
