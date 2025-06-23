# Create empty vectors
male_income = numeric(nrow(TableCountries))
female_income = numeric(nrow(TableCountries))

# Loop
for (i in 1:nrow(TableCountries)) {
  income = TableCountries$monthly_income[i]
  gpg = TableCountries$gender_pay_gap[i] / 100
  p_f = TableCountries$p_female[i]
  p_m = TableCountries$p_male[i]
  
  # Skip if missing data
  if (any(is.na(c(income, gpg, p_f, p_m))) || (p_m + p_f * (1 - gpg) == 0)) {
    male_income[i] = NA
    female_income[i] = NA
  } else {
    male_income[i] = income / (p_m + p_f * (1 - gpg))
    female_income[i] = male_income[i] * (1 - gpg)
  }
}

# Add results to original table
TableCountries$male_income = round(male_income, 2)
TableCountries$female_income = round(female_income, 2)
