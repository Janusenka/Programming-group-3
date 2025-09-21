###3a###
library(tidyverse)
library(dplyr)
library(readxl)

setwd('/Users/sofiachristodoulou/Desktop/QRM ASSIGNMENT')

movies4 = read_tsv("movies4.tsv")
View(movies4)

movies4 = movies4 %>% 
  mutate(profits = revenue - budget)
movies4


movies4 %>% 
  summarise(mean_profits = mean(profits, na.rm = T),
            median_profits = median(profits, na.rm = T),
            max_profits = max(profits, na.rm = T),
            min_profits = min(profits, na.rm = T))
#RESULTS
#mean profits: 52 885 668.93
#median profits: 0.00
#max profits: 1 299 557 910.00
#min profits: (150 000 000.00)


###3b###


movies4 %>% 
  filter(profits == max(profits, na.rm = T)) %>% 
  select(title,profits)


movies4 %>% 
  filter(profits == min(profits, na.rm = T)) %>% 
  select(title,profits)

#RESULT
#max profits: 'The Avengers'- 1 299 557 910.00
#min profits: 'The Wolfman'- (150 000 000.00)




#WEEK2

#2a
actor_counts<-table(movies4$first_actor)
max(actor_counts)
actor <- which.max(actor_counts)
actor


#2b
mean(movies4$revenue[movies4$first_actor == 'Bruce Willis'], na.rm=T)
mean(movies4$revenue, na.rm=T)

#Bruce Willis' average revenue is approximately 255.7 million USD while the overall average movie revenue is approximately 82.7 milliom USD.
#Therefore, Bruce Willis' movies average revenue lies above the whole average movie revenue.


#2c
#The law of large numbers implies that when we take a large number of observations, the sample average will be close to the true population average.
#However when the number of observations is small, the average may be misleading.  
#Since Bruce Willis only has 9 movies, which is relatively a small sample, the average revenue might not be a trustworthy estimate of how his movies typically perform in the broader population.
#The conclusion in 2b is not fully trustworthy, because Bruce Willis appears in only 9 movies in the dataset. 
#According to the law of large numbers, the reliability of an average increases with the number of observations. 
#With such a small sample, a few unusually high-grossing movies can strongly influence the average, making the result less representative of his true performance across all movies.




#week3#

#2a
alpha <- 0.05

s0_sq <- 500

#step1- state the null&alternative hypothesis
# H0: Var(runtime) = 500
# H1: Var(runtime) ≠ 500

#step2
stats <- movies4 %>% 
  summarise(n = sum(!is.na(runtime)), 
            s2 = var(runtime, na.rm = T))

#s2 = sample variance 


#step3-test statistic
chisq_stat <- ((stats$n -1)*stats$s2)/s0_sq

#step4-critical values
critical_lower <- qchisq(alpha/2, df = stats$n-1)
upper_crit <- qchisq(1-(alpha/2), df = stats$n-1)


#step5- conclusion
conclusion <- ifelse(chisq_stat<critical_lower | chisq_stat>upper_crit,
                     'Reject H0 there is signifant evidence that the variance is not 500',
                     'Fail to reject H0 there is not significant evidence that the variance is not 500')



#2b

#The test is valid only if the population distribution of runtime in Normal.

x<- na.omit(movies4$runtime) #we should omit the missing values 
outfile <- 'runtime_hist.png'

png('runtime_hist.png', width = 900, height = 700) #open file device because 'figure margins too large'
hist(x, breaks = 30, freq = FALSE, 
     main = 'Runtime: histogram +Normal curve ', xlab = 'runtime')
curve(dnorm(x, mean = mean(x),sd = sd(x)), add = T, lwd = 2)


dev.off() #write file
browseURL(paste0("file://", normalizePath(outfile)))  # open it

#The histogram with a fitted Normal curve appears right-skewed and more peaked than Normal indicating that Normality is doubtful. 
#Therefore, the assumption of the chi-square variance test is not fully met.
