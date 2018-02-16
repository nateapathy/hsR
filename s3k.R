##################################################
############# Session 3 Exercise Key #############
################## hsR tutorials #################
################## Feb 15, 2018 ##################
################### Nate Apathy ##################
##################################################
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

ca17 <- un_hix1418[un_hix1418$ST=="CA" & un_hix1418$YEAR=="2017",1:19]
table(ca17$AREA) #19
mean(ca17[ca17$AREA=="CA10",]$PREMI27) # $317.27
mean(ca17$PREMI27) # $339.32

##################################################
## Casey
#   Subset the data frame down to the 2016 plans from two states of your choice (create a new data frame object)
#   How many plans are in each of the metallic tiers for each state?
#   Which area (from the state first in alphabetical order) had the most silver plan options in 2016?
#   Which state had the higher average premium for a 50-year-old purchasing a silver plan? What was that amount?

alnm16 <- un_hix1418[(un_hix1418$ST=="AL" | un_hix1418$ST=="NM") & un_hix1418$YEAR=="2016",]
table(alnm16$METAL,alnm16$ST)
table(alnm16[alnm16$ST=="AL" & alnm16$METAL=="Silver",]$AREA,alnm16[alnm16$ST=="AL" & alnm16$METAL=="Silver",]$ST) # AL05
mean(alnm16[alnm16$ST=="AL" & alnm16$METAL=="Silver",]$PREMI50) # $466.87
mean(alnm16[alnm16$ST=="NM" & alnm16$METAL=="Silver",]$PREMI50) # $381.24

##################################################
## Saurabh
#   Subset the data frame down to plans in Illinois in 2018 (create a new data frame object)
#   How many plans did each insurance carrier offer in 2018 in the state?
#   What was the most common plan type in area 3?
#   Among HMO plans, what is the average premium for a 27-year-old?

il18 <- un_hix1418[un_hix1418$ST=="IL" & un_hix1418$YEAR=="2018",]
table(il18$CARRIER)
table(il18$PLANTYPE,il18$AREA) #type 2, which is HMO
mean(il18[il18$PLANTYPE=="2",]$PREMI27)

##################################################
## Tim
#   Subset the data frame down to plans in Colorado and Wyoming in 2017 (create a new data frame object)
#   How many plans are in each of the metallic tiers for each state?
#   Are there any areas in either state without a silver plan option? Without a gold option?
#   Which state had the higher average premium for a family of four purchasing a silver plan? What was that amount?

alnm16 <- un_hix1418[(un_hix1418$ST=="AL" | un_hix1418$ST=="NM") & un_hix1418$YEAR=="2016",]
table(alnm16$METAL,alnm16$ST)
table(alnm16[alnm16$ST=="AL" & alnm16$METAL=="Silver",]$AREA,alnm16[alnm16$ST=="AL" & alnm16$METAL=="Silver",]$ST) # AL05
mean(alnm16[alnm16$ST=="AL" & alnm16$METAL=="Silver",]$PREMC2C30) # $925.38
mean(alnm16[alnm16$ST=="NM" & alnm16$METAL=="Silver",]$PREMC2C30) # $755.64

##################################################
## Riz
#   Subset the data frame down to plans in Indiana in 2015 (create a new data frame object)
#   How many "areas" were there in Indiana in 2015?
#   How many plans did each insurance carrier offer in 2015 in the state?
#   What was the average premium for a family of four among the insurance carrier with the most plans offered?

in15 <- un_hix1418[un_hix1418$ST=="IN" & un_hix1418$YEAR=="2015",]
table(in15$AREA) # 17
table(in15$CARRIER) # most plans = 624 from Assurant Health
mean(in15[in15$CARRIER=="Assurant Health",]$PREMI2C30) # $956.28