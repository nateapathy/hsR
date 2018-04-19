#instrumental variables example


#install package
install.packages("ivpack")
#load package
library(ivpack)

#read dataset
data(card.data)

#IV is nearc4 (near 4 year college)
#outcome is lwage (log of wage)
#'treatment' is educ (number of years of education)

#summary stats
mean(card.data$nearc4) #roughly 68% are encouraged
par(mfrow=c(1,2))
hist(card.data$lwage)
hist(card.data$educ)
# more variability of years of education; lots had 12 (finished high school)
# this shows us variability in our treatment variable

#let's look at compliers, looking at those with more or less than 12y of education
# a complier would be that you lived close to a 4y college and have more than 12y of schooling
#make education binary
educ12<-card.data$educ>12
#estimate proportion of 'compliers'
propcomp<-mean(educ12[card.data$nearc4==1])-
  mean(educ12[card.data$nearc4==0])
propcomp #.12, 12% of population is compliers
# this is somewhat weak

#intention to treat effect: causal effect of encouragement
itt<-mean(card.data$lwage[card.data$nearc4==1])-
  mean(card.data$lwage[card.data$nearc4==0])
itt
# mean of wages among people who did live near a college minus mean of wages among those who didn't
# 0.1559

#complier average causal effect
itt/propcomp
# 1.2786 --> larger than ITT effect b/c we can make the no compliers assumption
# can also do with 2SLS

#is the IV associated with the treatment? strenght of IV; skipped this.
mean(card.data$educ[card.data$nearc4==1])
mean(card.data$educ[card.data$nearc4==0])
#two stage least squares

#stage 1: regress A on Z
s1<-lm(educ12~card.data$nearc4)
## get predicted value of A given Z for each subject
predtx <-predict(s1, type = "response")
table(predtx)
# people who lived close had a predicted probability of treatment of 0.544 (these are A-hats)
# people who lived far away had pprob of tx of 0.422

#stage 2: regress Y on predicted value of A
lm(card.data$lwage~predtx)
# coefficient of predtx is 1.28, which is exactly the same as what we got above.
# this is a simple example with no covariates
# this is "brute force" doing two separate regression models

#2SLS using ivpack
ivmodel=ivreg(lwage ~ educ12, ~ nearc4, x=TRUE, data=card.data)
robust.se(ivmodel)
# will also give you standard errors
# third variable, ~nearc4, is our instrument
# coefficient ("Estimate") is the same as our two previous methods of estimating this

#controlling for covariates
# IV assumptions may be true conditional on covariates; parsimonious model doesn't meet our criteria for the assumptions of an instrument
ivmodel=ivreg(lwage ~ educ12 + exper + reg661 + reg662 +
                reg663 + reg664 + reg665+ reg666 + reg667 + reg668, 
              ~ nearc4 + exper +
                reg661+ reg662 + reg663 + reg664 + reg665 + reg666 +
                reg667 + reg668, x=TRUE, data=card.data)
# you sort of have to write the regression twice, write the first stage least square model with only your treatment first
# ivreg(OUTCOME ~ TREATMENT + COVARIATES, ~IV + SAME COVARIATES)
# then , ~ IV + COVARIATES

robust.se(ivmodel)
