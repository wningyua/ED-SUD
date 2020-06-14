# The script is for merge mutiple datasets from 2006 - 2017, reading in as csv and cleaning data 

#packages
library(tidyverse)
library(dplyr)


# read in data
df2017 = readr::read_delim("sud2017.csv", delim = ',') 
df2016 = readr::read_delim("sud2016.csv", delim = ',') 


# clean and merge data 
merge1 = bind_rows(list(df2017, df2016)) %>% mutate(PAIN = recode(PAINSCALE, '0' = '1', 
                                                                '1' = '2', '2' = '2', '3' = '2',
                                                                '4' = '3','5' = '3', '6' = '3', '7' = '3', 
                                                                '8' = '4', '9' = '4', '10' = '4',
                                                                '-8' = '-8', '-9' = '-9')) %>%
  mutate(PAIN = as.numeric(PAIN)) %>% dplyr::select(-PAINSCALE)


# combine two dataset in one 
df = merge1 %>%  dplyr::select(-X1) 

# write in a file
write.csv(df, file = "alcsud_dat.csv",row.name=T)



                
                          

  


  
  
  




 
