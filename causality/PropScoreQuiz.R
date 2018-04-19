library(Matching)
library(MatchIt)
library(tableone)

data("lalonde")

#The data have n=614 subjects and 10 variables
#age age in years.
#educ years of schooling.
#black indicator variable for blacks.
#hispan indicator variable for Hispanics.
#married indicator variable for marital status.
#nodegree indicator variable for high school diploma.
#re74 real earnings in 1974.
#re75 real earnings in 1975.
#re78 real earnings in 1978.
#treat an indicator variable for treatment status.
#The outcome is re78 – post-intervention income.
#The treatment is treat – which is equal to 1 if the subject received the labor training and equal to 0 otherwise.
#The potential confounding variables are: age, educ, black, hispan, married, nodegree, re74, re75.

#Question 1: Pre-Match Standardized Difference for Married Variable
xvars <- c("age","educ","black","hispan","married","nodegree","re74","re75")
table1<- CreateTableOne(vars=xvars,strata="treat", data=lalonde, test=FALSE)
print(table1,smd=TRUE)

#Question 2: mean of real earnings in 1978(treated) minus mean of real earnings in 1978(untreated)
table2 <- CreateTableOne(vars="re78",strata = "treat",data=lalonde, test=FALSE)
print(table2)
6349.14-6984.17
# -635.03

#Question 3: Fit propensity score model with logistic regression
quizpsmodel <- glm(treat~age+educ+black+hispan+married+nodegree+re74+re75,
                   family=binomial(),data=lalonde)

#show coefficients etc
summary(quizpsmodel)
#create propensity score
quizpscore<-quizpsmodel$fitted.values
summary(quizpscore)
#min = 0.00908, max = 0.85315

#Question 4: Matching using Match Function | pair matching, no replacement, no caliper
# match on propensity score, not logit, and get smds
set.seed(931139)

quizpsmatch<-Match(Tr=lalonde$treat,M=1,X=quizpscore,replace=FALSE)
quizmatched<-lalonde[unlist(quizpsmatch[c("index.treated","index.control")]), ]

#get standardized differences
qzmatchedtab1<-CreateTableOne(vars=xvars, strata ="treat", 
                            data=quizmatched, test = FALSE)
print(qzmatchedtab1, smd = TRUE)
#Q4: married smd = 0.027
#Q5: covariate with the highest smd = black (0.852)

#Question 6: re-domatching but with 0.1 caliper
set.seed(931139)
quizpsmatchcal <- Match(Tr=lalonde$treat,M=1,X=quizpscore,replace=FALSE,caliper = 0.1)
quizmatchedcal <- lalonde[unlist(quizpsmatchcal[c("index.treated","index.control")]), ]

#get standardized differences
qzmatchedtab1cal<-CreateTableOne(vars=xvars, strata ="treat", 
                              data=quizmatchedcal, test = FALSE)
print(qzmatchedtab1cal, smd = TRUE)
# there are 111 matched pairs

#Question 7: Outcome analysis on caliper matched data
y_trt_qz <- quizmatchedcal$re78[quizmatchedcal$treat==1]
y_con_qz <- quizmatchedcal$re78[quizmatchedcal$treat==0]

#pairwise difference
diffy_qz <- y_trt_qz-y_con_qz
mean(diffy_qz)
#mean difference between trt and control for matched group is the same as the mean of the difference
#1246.806

#Q8: paired t-test
t.test(diffy_qz)
# 95% CI is (-420.0273,2913.6398)








