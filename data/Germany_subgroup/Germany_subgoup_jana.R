# Create empty vectors
male_income = numeric(nrow(Germany_subgroup))
female_income = numeric(nrow(Germany_subgroup))

# Loop
for (i in 1:nrow(Germany_subgroup)) {
  income = Germany_subgroup$income_eur[i]
  gpg = Germany_subgroup$gpg_2023[i] / 100
  p_f = Germany_subgroup$p_female[i]
  p_m = Germany_subgroup$p_male[i]
  
  # Compute
    male_income[i] = income / (p_m + p_f * (1 - gpg))
    female_income[i] = male_income[i] * (1 - gpg)
}

# Add results to original table
Germany_subgroup$male_income = round(male_income, 2)
Germany_subgroup$female_income = round(female_income, 2)
