###################
#RHC Example

#install packages (if needed)
install.packages("tableone")
install.packages("ipw")
install.packages("sandwich") #for robust variance estimation
install.packages("survey")

#load packages
library(tableone)
library(ipw)
library(sandwich) #for robust variance estimation
library(survey)

expit <- function(x) {1/(1+exp(-x)) }
logit <- function(p) {log(p)-log(1-p)}

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
died<-as.integer(rhc$death=='Yes')
age<-rhc$age
treatment<-as.numeric(rhc$swang1=='RHC')
meanbp1<-rhc$meanbp1

#new dataset
mydata<-cbind(ARF,CHF,Cirr,colcan,Coma,lungcan,MOSF,sepsis,
              age,female,meanbp1,treatment,died)
mydata<-data.frame(mydata)

#covariates we will use (shorter list than you would use in practice)
xvars<-c("age","female","meanbp1","ARF","CHF","Cirr","colcan",
         "Coma","lungcan","MOSF","sepsis")

#look at a table 1
table1<- CreateTableOne(vars=xvars,strata="treatment", data=mydata, test=FALSE)
## include standardized mean difference (SMD)
print(table1,smd=TRUE)

#propensity score model
psmodel <- glm(treatment ~ age + female + meanbp1+ARF+CHF+Cirr+colcan+
                 Coma+lungcan+MOSF+sepsis,
               family  = binomial(link ="logit"))

## value of propensity score for each subject
ps <-predict(psmodel, type = "response")

#create weights
#using an if else, if treatment =1, make weight 1/ps if it isnt, make the weight 1/1-ps
weight<-ifelse(treatment==1,1/(ps),1/(1-ps))

#apply weights to data
#apply weight to my data, create a new weighted version of the dataset
weighteddata<-svydesign(ids = ~ 1, data =mydata, weights = ~ weight)

#weighted table 1, using the weighteddata
weightedtable <-svyCreateTableOne(vars = xvars, strata = "treatment", 
                                  data = weighteddata, test = FALSE)
## Show table with SMD
# ignore standard deviations; weighted data uses weighted sample sizes
# ignore sample sizes and std devs. do use the means and SMDs
print(weightedtable, smd = TRUE)
#very good standardized diff in this group

#to get a weighted mean for a single covariate directly:
# this is doing the actual calculation yourself with R
# trying to get the weighted mean of age in the treatment group
# X is age; i want for the treated group. restrict to the treated group andc calculate weight among treated group
mean(weight[treatment==1]*age[treatment==1])/(mean(weight[treatment==1]))

#get causal relative risk. Weighted GLM - use log link
glm.obj<-glm(died~treatment,weights=weight,family=quasibinomial(link=log))
#summary(glm.obj)
#extract the coefficients
betaiptw<-coef(glm.obj)
#to properly account for weighting, use asymptotic (sandwich) variance
# vcov from sandwich package, to account for me having weighted data
# will give you a2x2 covariance matrix, but i only care about the diagonal and i take the square root of that diagonal
SE<-sqrt(diag(vcovHC(glm.obj, type="HC0")))

#get point estimate and CI for relative risk (need to exponentiate)
causalrr<-exp(betaiptw[2])
lcl<-exp(betaiptw[2]-1.96*SE[2]) #lower bound
ucl<-exp(betaiptw[2]+1.96*SE[2]) #upper bound
c(lcl,causalrr,ucl)

#get causal risk difference - use identity link (no log in front of the E(Ya))
glm.obj<-glm(died~treatment,weights=weight,family=quasibinomial(link="identity"))
#summary(glm.obj)
betaiptw<-coef(glm.obj)
SE<-sqrt(diag(vcovHC(glm.obj, type="HC0")))

causalrd<-(betaiptw[2])
lcl<-(betaiptw[2]-1.96*SE[2])
ucl<-(betaiptw[2]+1.96*SE[2])
c(lcl,causalrd,ucl)

#get causal risk difference
glm.obj<-glm(died~treatment,weights=truncweight,family=quasibinomial(link="identity"))
#summary(glm.obj)
betaiptw<-coef(glm.obj)
SE<-sqrt(diag(vcovHC(glm.obj, type="HC0")))

causalrd<-(betaiptw[2])
lcl<-(betaiptw[2]-1.96*SE[2])
ucl<-(betaiptw[2]+1.96*SE[2])
c(lcl,causalrd,ucl)

#############################
#alternative: use ipw package
#############################

#first fit propensity score model to get weights
#you can do this instead of the whole propensity score model; this is essentially doing that
#denom is your PS model, exposure is your treatment variable
weightmodel<-ipwpoint(exposure= treatment, family = "binomial", link ="logit",
                      denominator= ~ age + female + meanbp1+ARF+CHF+Cirr+colcan+
                        Coma+lungcan+MOSF+sepsis, data=mydata)
#numeric summary of weights
summary(weightmodel$ipw.weights)
#plot of weights - easier in this package
ipwplot(weights = weightmodel$ipw.weights, logscale = FALSE,
        main = "weights", xlim = c(0, 22))
mydata$wt<-weightmodel$ipw.weights

#fit a marginal structural model (risk difference)
#using svyglm you can define your weights using the design argument
msm <- (svyglm(died ~ treatment, design = svydesign(~ 1, weights = ~wt,
                                                    data =mydata)))
coef(msm) # this is the same as the point estimate of the risk diff
confint(msm) # same as above; fewer steps

#truncate weights at 10
# replace the weight; if it is greater than 10, use ten
truncweight<-replace(weight,weight>10,10)
# then instead of "weight" in your model, you'd put "truncweight" to use the truncated weights

# fit propensity score model to get weights, but truncated
# this has a built in truncation option (trunc option) - have to put in a percentile, not an actual value
# .01 means truncate at 1st and 99th percentile
weightmodel<-ipwpoint(exposure= treatment, family = "binomial", link ="logit",
                      denominator= ~ age + female + meanbp1+ARF+CHF+Cirr+colcan+
                        Coma+lungcan+MOSF+sepsis, data=mydata,trunc=.01)

#numeric summary of weights
#have to say weights.trun to get the truncated ones
# now the max is only 6.3; was 21 something
summary(weightmodel$weights.trun)
#plot of weights
ipwplot(weights = weightmodel$weights.trun, logscale = FALSE,
        main = "weights", xlim = c(0, 22))

#replace weights with the truncated weights
mydata$wt<-weightmodel$weights.trun

#fit a marginal structural model (risk difference)
# using the newly defined "wt" weights that have the truncated weights in them
msm <- (svyglm(died ~ treatment, design = svydesign(~ 1, weights = ~wt,
                                                    data =mydata)))
coef(msm)
confint(msm)