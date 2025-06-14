df = Germany_subgroup

# Create income matrix
income_matrix = t(as.matrix(df[, c("male_income", "female_income", "income_eur")]))
colnames(income_matrix) = df$sector
rownames(income_matrix) = c("Male", "Female", "Average")

# Plot and capture bar midpoints
mp = barplot(income_matrix,
  col = colors()[c(430, 420, 468)],
  border = "white",
  beside = TRUE,
  las = 2,
  names.arg = rep("", ncol(income_matrix)),
  font.axis = 2,
  xlab = "Sector",
  ylab = "Monthly Income (€)",
  main = "Male vs. Female Income by Sector (Germany 2023)",
  ylim = c(0, 7000),  
  legend = rownames(income_matrix),
  args.legend = list(x = "topright", bty = "n", inset = 0.01),
  font.lab = 2)
  text(x = colMeans(mp), y = -250,labels = colnames(income_matrix),
  xpd = TRUE, srt = 30, adj = 1, cex = 0.5)
