  df = Germany_subgroup
  
  # Create income matrix
  income_matrix = t(as.matrix(df[, c("male_income", "female_income", "income_eur")]))
  colnames(income_matrix) = df$sector
  rownames(income_matrix) = c("Male", "Female", "Average")
  
  # Grouped barplot
  barplot(income_matrix,
    col = colors()[c(430, 420, 468)],
    border = "white",
    beside = TRUE,
    las = 2,
    cex.names = 0.2, #ask-45
    font.axis = 2,
    xlab = "Sector",
    ylab = "Monthly Income (€)",
    main = "Male vs. Female Income by Sector (Germany 2023)",
    legend = rownames(income_matrix),
    args.legend = list(x = "topright", bty = "n", inset = 0.01),
    font.lab = 2)
