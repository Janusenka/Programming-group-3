library(dplyr)

# EU
eu_df = TableCountries %>% filter(country == "European Union - 27 countries (from 2020)")

# Incomes
income_matrix = rbind(
  Male = eu_df$male_income,
  Female = eu_df$female_income,
  Average = eu_df$monthly_income
)
colnames(income_matrix) = eu_df$year
rownames(income_matrix) = c("Male", "Female", "Average")

# Plot
mp = barplot(income_matrix,
  beside = TRUE,
  col = colors()[c(430, 420, 468)],
  border = "white",
  las = 1,
  font.axis = 2,
  xlab = "Year",
  ylab = "Monthly Income (€)",
  main = "EU: Male vs. Female Income by Year",
  ylim = c(0, 3500),  
  legend = rownames(income_matrix),
  args.legend = list(x = "topright", bty = "n", inset = c(0.01, -0.3257)),
  font.lab = 2,
  names.arg = rep("", ncol(income_matrix))
)

# Add x-axis labels
text(x = colMeans(mp), y = -200, labels = colnames(income_matrix),
  xpd = TRUE, srt = 0, adj = 0.5, cex = 0.9)
