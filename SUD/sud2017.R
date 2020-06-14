#This script is for labeling SUD  and ALC
#Author: Ningyuan Wang

#load packages
library(readxl) #read excel
library(tidyverse)
library(dplyr)
library(haven) #read and write sas


#setwd("C:/Users/wningyua/Desktop/ED_data/raw_data")
#read in the data of 2017
sud2017 <- read_sas("nhamcsed2017.sas7bdat")
#View(sud2017$DIAG1)
diag1.character <- as.character(sud2017$DIAG1)#character
diag2.character <- as.character(sud2017$DIAG2)
diag3.character <- as.character(sud2017$DIAG3)
sud2017$SUD= ifelse(sud2017$SUBSTAB == 1, 1, 0)#create a new variable on the dataaset 
sud2017$ALC= ifelse(sud2017$ETOHAB == 1, 1, 0)#create a new variable on the dataaset 



# add matches
extra_alc = c("F10-")
extra_sud = c("F11-", "F12-","F13-", "F14-", "F15-", "F16-", "F17-","F19-")
for (i in 1:nrow(sud2017)){
  if (diag1.character[i] %in% extra_sud| diag2.character[i] %in% extra_sud | diag3.character[i] %in% extra_sud){
    sud2017$SUD[i]=1
  }
  if (diag1.character[i] %in% extra_alc| diag2.character[i] %in% extra_alc | diag3.character[i] %in% extra_alc){
    sud2017$ALC[i]=1
  }
}     


# #transfer - to 0 in the column of diag1.character
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

#label the sud2017 dataset
for (i in 1:nrow(sud2017)){
  if (diag1.character[i] %in% alc_code ==T| diag2.character[i] %in% alc_code ==T | diag3.character[i] %in% alc_code ==T){
    sud2017$ALC[i]=1
  }
  if (diag1.character[i] %in% sud_code ==T| diag2.character[i] %in% sud_code ==T | diag3.character[i] %in% sud_code ==T){
    sud2017$SUD[i]=1
  }
}


sud2017$ALCSUD = ifelse(sud2017$ALC ==1 & sud2017$SUD ==1, 1, 0)
sud2017$AORS = ifelse(sud2017$ALC ==1 | sud2017$SUD ==1, 1, 0)
sud2017$NONE = 1- sud2017$AORS 
#------------------------------------------------------------------------------
sud2017$BLOODTEST = 0
sud2017[sud2017$ABG==1 | sud2017$BAC ==1 | sud2017$BMP ==1 | sud2017$BNP ==1 | 
          sud2017$BUNCREAT==1 | sud2017$CARDENZ ==1 | sud2017$CMP ==1 | sud2017$CBC ==1 | 
          sud2017$BLOODCX ==1 | sud2017$TRTCX ==1 | sud2017$URINECX ==1 | sud2017$WOUNDCX ==1 | 
          sud2017$OTHCX ==1 |  sud2017$DDIMER==1 | sud2017$ELECTROL ==1 | sud2017$GLUCOSE ==1 | 
          sud2017$LACTATE ==1 | sud2017$LFT ==1 | sud2017$PTTINR ==1 | sud2017$OTHERBLD ==1, 
        "BLOODTEST"] <-1

sud2017$LEFT = 0
sud2017[sud2017$LWBS==1 | sud2017$LBTC==1 | sud2017$LEFTAMA ==1, "LEFT"] <- 1

sud2017$HOS = 0
sud2017[sud2017$ADMITHOS== 1| sud2017$TRANPSYC==1 | sud2017$TRANOTH ==1 | 
          sud2017$OBSHOS ==1, "HOS"] <-1

sud2017$DEATH = 0
sud2017[sud2017$DOA ==1 | sud2017$DIEDED ==1 | sud2017$HDSTAT ==1, "DEATH"] <-1



keeps = c("ETHUN", "RACEUN", "YEAR", "PAINSCALE", "RESIDNCE", "BLOODTEST", "LEFT", "HOS",
          "ADMIT", "DEATH", "AGE", "SEX", "PAYTYPER", "VMONTH", "VDAYR", "TEMPF",
          "PULSE", "BPSYS", "BPDIAS", "SEEN72", "IMMEDR", "ARREMS", "REGION", 
          "ANYIMAGE", "XRAY", "CATSCAN", "MRI", "ULTRASND", "OTHIMAGE", "HOSPCODE",
          "WAITTIME",  "PROC", "RFV1", "PATWT", "INJURY", "SUD", "ALC", "ALCSUD", "AORS", "NONE")
sud2017 = sud2017[keeps]


#write in a new csv
write.csv(sud2017, file = "sud2017.csv",row.name=T)




