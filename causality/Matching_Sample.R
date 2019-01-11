###################
#RHC Example

#install packages
install.packages("tableone")
install.packages("Matching")

#load packages
library(tableone)
library(Matching)

#read in data
load(url("http://biostat.mc.vanderbilt.edu/wiki/pub/Main/DataSets/rhc.sav"))
#view data
View(rhc)

#treatment variables is swang1
#x variables that we will use
#cat1: primary disease category
#age
#sex
#aps1: APACHE score
#meanbp1: mean blood pressure

#create a data set with just these variables, for simplicity
ARF<-as.numeric(rhc$cat1=='ARF')
CHF<-as.numeric(rhc$cat1=='CHF')
Cirr<-as.numeric(rhc$cat1=='Cirrhosis')
colcan<-as.numeric(rhc$cat1=='Colon Cancer')
Coma<-as.numeric(rhc$cat1=='Coma')
COPD<-as.numeric(rhc$cat1=='COPD')
lungcan<-as.numeric(rhc$cat1=='Lung Cancer')
MOSF<-as.numeric(rhc$cat1=='MOSF w/Malignancy')
sepsis<-as.numeric(rhc$cat1=='MOSF w/Sepsis')
female<-as.numeric(rhc$sex=='Female')
died<-as.numeric(rhc$death=='Yes')
age<-rhc$age
treatment<-as.numeric(rhc$swang1=='RHC')
meanbp1<-rhc$meanbp1

#new dataset
psdata<-data.frame(cbind(ARF,CHF,Cirr,colcan,Coma,lungcan,MOSF,sepsis,
              age,female,meanbp1,treatment,died))
save(psdata,file="PS_ex.Rdata")
#covariates we will use (shorter list than you would use in practice)
xvars<-c("ARF","CHF","Cirr","colcan","Coma","lungcan","MOSF","sepsis",
         "age","female","meanbp1")

#look at a table 1, stratified on treatment status (0/1)
table1<- CreateTableOne(vars=xvars,strata="treatment", data=psdata, test=FALSE)
## include standardized mean difference (SMD)
print(table1,smd=TRUE)
# a few of these show imbalance (i.e. SMD > 0.1)
#tells you how much imbalance you might have

############################################
#do greedy matching on Mahalanobis distance
############################################
# match package
# Tr is what is the treatment variable
# M=1 is pair matching, set to the number of k matches you want
# X is the set of variables you want to match on
greedymatch<-Match(Tr=treatment,M=1,X=psdata[xvars],replace=FALSE)
# greedymatch creates an index by treated and control based on original pairs
matched<-psdata[unlist(greedymatch[c("index.treated","index.control")]), ]
# ^^ this is a new dataset with the indices assigned per pair

#get table 1 for matched data with standardized differences
matchedtab1<-CreateTableOne(vars=xvars, strata ="treatment", 
                            data=matched, test = FALSE)
print(matchedtab1, smd = TRUE)
#much better balance on this group (all SMDs are less than 0.1 except meanbp1)

#outcome analysis now that we are happy with outcome analysis
# this is a paired t-test
# this subsets the data to two outcome variables, one for treatment==1 and one for treatment==0
# first row of y_trt = paired with first row of y_con
y_trt<-matched$died[matched$treatment==1]
y_con<-matched$died[matched$treatment==0]

#pairwise difference one pair at a time
diffy<-y_trt-y_con

#paired t-test is a regular t-test on the difference between pairs
t.test(diffy)
# this is a causal risk difference because we are balanced
# point est is 0.045, difference in probability of death if everyone recieved RHC vs no one receiving RHC is 0.045, i.e. higher risk of death)

#McNemar test
table(y_trt,y_con)

mcnemar.test(matrix(c(973,513,395,303),2,2))
# both find that treated subjects were at higher risk of death


##########################
#propensity score matching
#########################

#fit a propensity score model. logistic regression
# treatment is the outcome, with all of the covariates. family=binomial means the outcome is binary, which makes it carry out a logistic regression
psmodel<-glm(treatment~ARF+CHF+Cirr+colcan+Coma+lungcan+MOSF+
               sepsis+age+female+meanbp1,
             family=binomial(),data=mydata)

#show coefficients etc
summary(psmodel)
#create propensity score
pscore<-psmodel$fitted.values
#fitted values are the values per subject of the fitted logistic model
#he graphs the propensity score, but doesn't include the code
#matching in MatchIt
library(MatchIt)
#using matchit
m.out <- matchit(treatment~ARF+CHF+Cirr+colcan+Coma+lungcan+MOSF+sepsis+age+female+meanbp1, 
                 data = mydata, method = "nearest")
summary(m.out)
#propensity score plots
plot(m.out, type = "jitter")
plot(m.out, type = "hist")

#do greedy matching on logit(PS), using matching package
# caliper argument means 0.2 * the standard deviation of what you have X defined as
logit <- function(p) {log(p)-log(1-p)}
psmatch<-Match(Tr=mydata$treatment,M=1,X=logit(pscore),replace=FALSE,caliper=.2)
matched<-mydata[unlist(psmatch[c("index.treated","index.control")]), ]
xvars<-c("ARF","CHF","Cirr","colcan","Coma","lungcan","MOSF","sepsis",
         "age","female","meanbp1")

#get standardized differences
matchedtab1<-CreateTableOne(vars=xvars, strata ="treatment", 
                            data=matched, test = FALSE)
print(matchedtab1, smd = TRUE)
#fewer subjects matched because of the restriction by the caliper
#previously, we tolerated wider distances
#we are now forcing better matches with the caliper

#outcome analysis
y_trt<-matched$died[matched$treatment==1]
y_con<-matched$died[matched$treatment==0]

#pairwise difference
diffy<-y_trt-y_con

#paired t-test
t.test(diffy)




