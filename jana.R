income_results = list()

for (i in 1:nrow(TableCountries)) {
  row = TableCountries[i, ]
  
  country = row$country
  year = row$year
  avg_income = row$monthly_income
  gpg = row$gender_pay_gap / 100
  p_f = row$p_female
  p_m = row$p_male
  
  #  print("---- Row", i, "----")
  #  print("Country:", country, "Year:", year)
  #  print("Monthly Income:", avg_income)
  #  print("GPG:", gpg)
  #  print("p_female:", p_f, "p_male:", p_m)
  
  # Check for missing or invalid values
  if (any(is.na(c(avg_income, gpg, p_f, p_m))) || (p_m + p_f * (1 - gpg) == 0)) {
    #   print("Skipping row due to missing or invalid values")
    next
  }
  
  # Calculate incomes
  male_inc = avg_income / (p_m + p_f * (1 - gpg))
  female_inc = male_inc * (1 - gpg)
  
  #  print("Male income:", round(male_inc, 2))
  #  print("Female income:", round(female_inc, 2))
  
  # Save result
  income_results[[length(income_results) + 1]] = data.frame(
    country = country,
    year = year,
    male_income = round(male_inc, 2),
    female_income = round(female_inc, 2)
  )
}

# Combine all saved rows into one data frame
income_matrix = do.call(rbind, income_results)
