# Load required packages
library(dplyr)
library(ggplot2)
library(sf)
library(rnaturalearth)
library(rnaturalearthdata)


# 1. Load full Europe map (for background)
all_europe <- rnaturalearth::ne_countries(scale = "medium", returnclass = "sf") %>%
  filter(region_un == "Europe")

# 2. Prepare TableCountries 2022 EU data
eu_data_2022 <- TableCountries %>%
  filter(year == 2022) %>%
  mutate(country = recode(country,
    "European Union - 27 countries (from 2020)" = "EU"
  ))

# 3. Merge to get only income countries for fill
europe_map <- all_europe %>%
  left_join(eu_data_2022, by = c("name" = "country")) %>%
  filter(!is.na(monthly_income))

# 4. Shared theme and zoom
big_map_theme <- theme_minimal(base_size = 16) +
  theme(
    plot.title = element_text(size = 20, face = "bold", hjust = 0.5),
    legend.title = element_text(size = 16),
    legend.text = element_text(size = 14)
  )

zoom_europe <- coord_sf(xlim = c(-25, 45), ylim = c(34, 72), expand = FALSE)

# 5. Female Income Map
p_female <- ggplot() +
  geom_sf(data = all_europe, fill = "grey90", color = "grey70", size = 0.2) +
  geom_sf(data = europe_map, aes(fill = female_income), color = "white", size = 0.3) +
  scale_fill_gradient(low = "#FFE5EC", high = "#C9184A", name = "€") +
  labs(title = "Female Monthly Income (2022)") +
  zoom_europe + big_map_theme
p_female


# 6. Male Income Map
p_male <- ggplot() +
  geom_sf(data = all_europe, fill = "grey90", color = "grey70", size = 0.2) +
  geom_sf(data = europe_map, aes(fill = male_income), color = "white", size = 0.3) +
  scale_fill_gradient(low = "#D0E8FF", high = "#00509D", name = "€") +
  labs(title = "Male Monthly Income (2022)") +
  zoom_europe + big_map_theme
p_male


# 8. Display all three
p_female
p_male
