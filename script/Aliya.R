my_data <- read.csv("Tablecountries.csv")
# sort gender pay gap from lowest
my_data_sorted <- my_data[order(my_data$Gender_Pay_Gap), ]
View (my_data_sorted)
# check if female participation is ascending or descending 
change <- diff(my_data_sorted$Female_Participation)

# analyze the female participation
if (all(change >=0)) {
  print("Female partciption is in ascending order, there is a positive correlation")
} else if (all(change<= 0)) {
  print("Female participation is in descending order, there is a negative correlation")
} else { 
  print("Female participation changes randomly, there is no correlation")
} 
  
  
    
  