tbl_df("titanic3")
head(titanic3)
library(dplyr)
library(tidyr)
# 1.Add missing value to embarked column
titanic3$embarked[is.na(titanic3$embarked)] <- "S"

#2.Add missing age column
#check group of age column
titanic3 %>% group_by(age) %>% tally(sort = TRUE)
median_age <- median(titanic4$age, na.rm = TRUE)
titanic3$age[is.na(titanic3$age)] <- median_age
#check if missing value of age has been changed
titanic3 %>% group_by(age) %>% tally(sort = TRUE)

#3.Fill these empty slots of column lifeboat with a dummy value 'None'
titanic3$boat[is.na(titanic3$boat)] <- "None"

#4. Create new column has_cabin_number with value 1 means has cabin number and 0 measn no cabin number
titanic5 <-titanic3 %>% mutate("has_cabin_number" = ifelse(cabin == is.na(cabin),0, 1))
titanic5$has_cabin_number[is.na(titanic5$has_cabin_number)] <- 0
#check number of missing value in cabin
titanic5 %>% group_by(cabin) %>% tally(sort = TRUE)
# there is 1015 missing value. Add "NA" to missing value in cabin
titanic5$cabin[is.na(titanic5$cabin)] <- "NA"

#5. create csv file named titanic_clean
write_csv(titanic5, "titanic_clean.csv")