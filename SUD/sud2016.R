#This script is for labeling SUD and ALC
# and reduce the columns of dataset 
#Author: Ningyuan Wang

#load packages
library(readxl) #read excel
library(tidyverse)
library(dplyr)
library(haven) #read and write sas


#setwd("C:/Users/wningyua/Desktop/ED_data/raw_data")
#read in the data of 2016
sud2016 <- read_sas("nhamcsed2016.sas7bdat")
#View(sud2016$DIAG1)
diag1.character <- as.character(sud2016$DIAG1)#character
diag2.character <- as.character(sud2016$DIAG2)
diag3.character <- as.character(sud2016$DIAG3)
sud2016$SUD= ifelse(sud2016$SUBSTAB == 1, 1, 0)#create a new variable on the dataaset 
sud2016$ALC= ifelse(sud2016$ETOHAB == 1, 1, 0)#create a new variable on the dataaset 


# add matches
extra_alc = c("F101", "F102", "F109")
extra_sud = c("F191", "F11-", "F12-", "F13-", "F14-", "F16-", "F172")
for (i in 1:nrow(sud2016)){
  if (diag1.character[i] %in% extra_sud| diag2.character[i] %in% extra_sud | diag3.character[i] %in% extra_sud){
    sud2016$SUD[i]=1
  }
  if (diag1.character[i] %in% extra_alc| diag2.character[i] %in% extra_alc | diag3.character[i] %in% extra_alc){
    sud2016$ALC[i]=1
  }
}     
      

#transfer - to 0 in the column of diag1.character
diag1.character <- sub("-","0",diag1.character)#for - only
diag1.character <- paste(diag1.character, "00", sep="")

diag2.character <- sub("-","0",diag2.character)#for - only
diag2.character <- paste(diag2.character, "00", sep="")

diag3.character <- sub("-","0",diag3.character)#for - only
diag3.character <- paste(diag3.character, "00", sep="")

#read in icd10 code
icd10 <- read_excel("ICD-9 & ICD-10 codes for SUDs.xlsx")
icd10_code <- na.omit(icd10$`ICD-10-CM\r\ndiagnosis`)#remove codes with NA
icd10_code <- gsub("\\.", "", icd10_code)
icd10_code <- ifelse(!(substr(icd10_code, 6,6) %in% c("0","1", "2", "3", "4", 
                                                      "5", "6", "7", "8", "9")), paste(icd10_code, 0, sep = ""), icd10_code)
alc_code = icd10_code[1:40]
sud_code = icd10_code[41:length(icd10_code)]

#label the sud2016 dataset
for (i in 1:nrow(sud2016)){
  if (diag1.character[i] %in% alc_code ==T| diag2.character[i] %in% alc_code ==T | diag3.character[i] %in% alc_code ==T){
    sud2016$ALC[i]=1
  }
  if (diag1.character[i] %in% sud_code ==T| diag2.character[i] %in% sud_code ==T | diag3.character[i] %in% sud_code ==T){
    sud2016$SUD[i]=1
  }
}

sud2016$ALCSUD = ifelse(sud2016$ALC ==1 & sud2016$SUD ==1, 1, 0)
sud2016$AORS = ifelse(sud2016$ALC ==1 | sud2016$SUD ==1, 1, 0)
sud2016$NONE = 1- sud2016$AORS 

#------------------------------------------------------------------------------
sud2016$BLOODTEST = 0
sud2016[sud2016$ABG==1 | sud2016$BAC ==1 | sud2016$BMP ==1 | sud2016$BNP ==1 | 
        sud2016$BUNCREAT==1 | sud2016$CARDENZ ==1 | sud2016$CMP ==1 | sud2016$CBC ==1 | 
        sud2016$BLOODCX ==1 | sud2016$TRTCX ==1 | sud2016$URINECX ==1 | sud2016$WOUNDCX ==1 | 
        sud2016$OTHCX ==1 |  sud2016$DDIMER==1 | sud2016$ELECTROL ==1 | sud2016$GLUCOSE ==1 | 
        sud2016$LACTATE ==1 | sud2016$LFT ==1 | sud2016$PTTINR ==1 | sud2016$OTHERBLD ==1, 
        "BLOODTEST"] <-1

sud2016$LEFT = 0
sud2016[sud2016$LWBS==1 | sud2016$LBTC==1 | sud2016$LEFTAMA ==1, "LEFT"] <- 1

sud2016$HOS = 0
sud2016[sud2016$ADMITHOS== 1| sud2016$TRANPSYC==1 | sud2016$TRANOTH ==1 | 
        sud2016$OBSHOS ==1, "HOS"] <-1

sud2016$DEATH = 0
sud2016[sud2016$DOA ==1 | sud2016$DIEDED ==1 | sud2016$HDSTAT ==1, "DEATH"] <-1

 
          
keeps = c("ETHUN", "RACEUN", "YEAR", "PAINSCALE", "RESIDNCE", "BLOODTEST", "LEFT", "HOS",
          "ADMIT", "DEATH", "AGE", "SEX", "PAYTYPER", "VMONTH", "VDAYR", "TEMPF",
          "PULSE", "BPSYS", "BPDIAS", "SEEN72", "IMMEDR", "ARREMS", "REGION", 
          "ANYIMAGE", "XRAY", "CATSCAN", "MRI", "ULTRASND", "OTHIMAGE", "HOSPCODE",
          "WAITTIME", "PROC", "RFV1", "PATWT", "INJURY", "SUD", "ALC", "ALCSUD", "AORS", "NONE")
sud2016 = sud2016[keeps]



#write in a new csv
write.csv(sud2016, file = "sud2016.csv",row.name=T)




