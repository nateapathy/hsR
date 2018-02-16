##################################################
############### Session 3 R Script ###############
################## hsR tutorials #################
################## Feb 15, 2018 ##################
################### Nate Apathy ##################
##################################################

## LOAD PACKAGES ##
# In case you need to install these packages, uncomment and run this first line.
# install.packages("dplyr","expss","ggplot2","tidyverse","reshape2","ggthemes","skimr")
library(dplyr)
library(expss)
library(ggplot2)
library(tidyverse)
library(reshape2)
library(ggthemes)
library(skimr)
# Reminder: *always* include the necessary packages at the top of any script.
# It makes life so much easier, and enables easy replicability.

##################################################
## LOAD DATA FILES
# Load the data files from your working directory
# You should already have the five files downloaded, unzipped, and moved into your project folder
# Five files: hix14.Rdata, hix15.Rdata, hix16.Rdata, hix17.Rdata, hix18.Rdata
# These are the raw, unprocessed flat files simply imported and then saved as .Rdata files for import
# The download link is: https://github.iu.edu/natea/hsR/blob/master/hix_rdata_files.zip
# You will need an IU GitHub account and to be added to the repository in order to download

# Double-check that the files are in your project folder (bottom right panel, "Files" tab in RStudio)
load(file="hix14.Rdata")
load(file="hix15.Rdata")
load(file="hix16.Rdata")
load(file="hix17.Rdata")
load(file="hix18.Rdata")
# All five should now appear as "Data" objects in your "Environment" tab (top right panel)

##################################################
## MERGE THE DATASETS INTO ONE & SUBSET TO WHAT WE WANT
# We use the tidyverse for this, and utilize what are called "pipes"
# These pass updated data step by step and apply things all in a row
# This allows us to stack everything one by one to create a master data set
hix1418 <- hix14 %>% rbind(hix15) %>% rbind(hix16) %>% rbind(hix17) %>% rbind(hix18)

# Subset the data down to non-child-only and non-CSR plans
# These complicate analysis and the HIX Compare documentation recommends dropping them
hix1418 <- hix1418[hix1418$CHILDONLY==0 & hix1418$CSR==0,]

# Now cut out the duplicate plans using the HIX Compare methodology for identifying unique plans
# The following fields are used to match:
#   year st carrier metal plantype planmarket networkid 
#   ab_copayinn_tiers *thru* rh_coinsoutofneta
#   sp_copayinn_tiers *thru* tehboutofnetfamilymoopa
# This leaves out skilled nursing columns (there are 14 of them) because they are an EHB that can be changed by a rider
# We're going to use the UNIQUE field (col #1) once we compress the data to hold our unique ID for each plan that remains

# check for duplications T/F
# not actually going to run this duplicated() function 
# returns a logical vector that matches with the rows that are duplicated
# duplicated(hix1418[,c(2,5,7,9,10,17,19,20:383,398:503)])

# we can also check to make sure the fields we kept are correct
# not going to run this either; huge output
# colnames(hix1418[1:3,c(2,5,7,9,10,17,19,20:383,398:503)])

# now we can just use the duplicated() function and its arguments as our subset for rows
un_hix1418 <- hix1418[duplicated(hix1418[,c(2,5,7,9,10,17,19,20:383,398:503)]),]
# this cuts us down to 146,941 unique plans, down from 168,177
# so there are 21,236 duplicate plans by the hixcompare definition

# now we can generate our unique identifier in the UNIQUE field
un_hix1418$UNIQUE <- 1:length(un_hix1418$UNIQUE)
# notice we still have 503 variables. UNIQUE was already a field (the first one)
# so we just overwrote whatever was there (they were all NAs, but this is worth checking)

# Note: in 10 lines of code, we have:
####  1. loaded 5 data sets
####  2. merged them all into a longitudinal data set
####  3. removed observations we aren't concerned with analyzing
####  4. applied a method for identifying unique observations
####  5. created a new unique identifier field

##################################################
## YOUR TURN
# Each of you have a section below to do something with the un_hix1418 dataset we've created
# Find your section and write whatever you need in order to get the answer/do the thing.
# Some things that may come in handy:
#     - A few of these will require the data dictionary as a reference
#     - Keep in mind that subsetting by column number is much easier when fields have unweildy names and there are lots of them
#     - You'll only need the first 19 columns for all the steps below
#     - colnames() can help identify the number of the column you are trying to find
#     - the syntax for subsetting is dataframename[rows,columns]
#     - table() can help with cross-tabs/counts of variable pairs
#     - length() counts how many elements are in a given object
#     - skim(dataframename) can be very useful. try it! no need to create an object, just look at it in the Console output
#     - you can subset within other functions without changing the object you are subsetting (if you don't overwrite it)
#        - example: length(dataframename[dataframename$column1==1 & dataframename$column2==4,])
#        - will count the number of observations that match your criteria (like filtering in excel)

##################################################
## Kevin
#   Subset the data frame down to just 2017 California plans (create a new data frame object)
#   How many "areas" were there in California in 2017?
#   What is the average premium in 2017 for a 27-year-old in area 10?
#   How does this premium compare to the average premium for a 27-year-old in the whole state?

##################################################
## Casey
#   Subset the data frame down to the 2016 plans from two states of your choice (create a new data frame object)
#   How many plans are in each of the metallic tiers for each state?
#   Which area (from the state first in alphabetical order) had the most silver plan options in 2016?
#   Which state had the higher average premium for a 50-year-old purchasing a silver plan? What was that amount?

##################################################
## Saurabh
#   Subset the data frame down to plans in Illinois in 2018 (create a new data frame object)
#   How many plans did each insurance carrier offer in 2018 in the state?
#   What was the most common plan type in area 3?
#   Among HMO plans, what is the average premium for a 27-year-old?

##################################################
## Tim
#   Subset the data frame down to plans in Colorado and Wyoming in 2017 (create a new data frame object)
#   How many plans are in each of the metallic tiers for each state?
#   Are there any areas in either state without a silver plan option? Without a gold option?
#   Which state had the higher average premium for a family of four purchasing a silver plan? What was that amount?

##################################################
## Riz
#   Subset the data frame down to plans in Indiana in 2015 (create a new data frame object)
#   How many "areas" were there in Indiana in 2015?
#   How many plans did each insurance carrier offer in 2015 in the state?
#   What was the average premium for a family of four among the insurance carrier with the most plans offered?
