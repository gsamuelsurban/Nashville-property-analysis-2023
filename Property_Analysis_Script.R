library(tidyverse)
property_data <- read_csv("assessor_nashville_counties.csv")
prop_data <- read_csv("assessor_nashville_counties_2022.csv")

#Intro: Data cleaning

#make NAs false for owner1corpind, owner2corpind
Q1[c("owner1corpind", "owner2corpind")] [is.na(Q1[c("owner1corpind", "owner2corpind")])] <- FALSE

#combine lat and long
prop_data$latlong <- paste(prop_data$situslatitude, prop_data$situslongitude, sep = ":")

#shorten Apn. APN allows us to combine different properties by shared parcel
prop_data$apn_short <- substr(prop_data$apn,1,6)

#check class of each variable with data dictionary, mutate as needed
class(prop_data$fips)
prop_data$fips <- as.character(prop_data$fips)

class(prop_data$propertyid)
prop_data$propertyid <- as.character(prop_data$propertyid)

class(prop_data$situsfullstreetaddress)
class (prop_data$situscity)

class (prop_data$situszip5)
prop_data$situszip5 <- as.character(prop_data$situszip5)

class (prop_data$latlong)
class (prop_data$zoning)
class (prop_data$owner1corpind)
class (prop_data$owner2corpind)
class (prop_data$apn_short)
class (prop_data$propertyclassid)

class (prop_data$landusecode)
prop_data$landusecode <- as.character(prop_data$landusecode)

class (prop_data$sumresidentialunits)
class (prop_data$assdimprovementvalue)

class (prop_data$lotsizeacres)
prop_data$lotsizeacres <- as.numeric(prop_data$lotsizeacres)

class (prop_data$lotsizesqft)
class (prop_data$ownername1full)
class (prop_data$ownername2full)

#checking acreage and sq feet totals to make sure they are consistent with eachother
#as well as with Davidson totals

total_acres <- sum(prop_data$lotsizeacres)
total_acres_div_by_1k <- total_acres/1000
total_acres_div_by_1k * 43560
sum(prop_data$lotsizesqft)
#in the above, I found that the acreage totals divided by 1000 were much closer
#to sqft equivalent, so I will change the variable by dividing by 1000
prop_data$acclotsizeacres <- prop_data$lotsizeacres/1000
#the sum of lot size square feet (1.28 e+10) is slightly smaller than size of
#Davidson County (1.46 e+10), as it should be.

#Question 1: What land is owned by institutional entities?#
#taking a subset of the most important variables to this question
Q1 <- prop_data %>% 
  select(fips, propertyid, situsfullstreetaddress, situscity, situszip5, latlong,
        zoning, owner1corpind, owner2corpind, apn_short,
         propertyclassid, landusecode, sumresidentialunits, assdimprovementvalue,
         lotsizeacres, lotsizesqft,
         ownername1full, ownername2full)

#Question 1a: determine percentage of all land owned by institutional entities
#what metric?

#percentage of trues in owner1corpind, owner2corpind

#get a count of land use codes for our specific types of institutions


# figure out (with some logical work) how to sort through owner1 and owner2, avoid
#duplication

#Question 2: How much of this land might be made available for residential development?

#determine owners by zoning code
#groupby: group land by zoning code
#figure out percentage of corporate ownership by zone

#Question 3: How much housing would current zoning allow on this land?

#Question 4: How much of this land is located in places with access to transportation and jobs?