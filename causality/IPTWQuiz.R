install.packages("tableone")
install.packages("Matching")
install.packages("ipw")
install.packages("survey")
install.packages("MatchIt")

library(tableone)
library(Matching)
library(ipw)
library(survey)
library(MatchIt)
data(lalonde)

# The data have n=614 subjects and 10 variables
#age age in years.
#educ years of schooling.
#black indicator variable for blacks.
#hispan indicator variable for Hispanics.
#married indicator variable for marital status.
#nodegree indicator variable for high school diploma.
#re74 real earnings in 1974.
#re75 real earnings in 1975.
#re78 real earnings in 1978.
#treat an indicator variable for treatment status

#Q1: fit PS model, get PSs, compute weights, find min and max
xvars <- c("age","educ","black","hispan","married","nodegree","re74","re75")
quiz2psmodel <- glm(treat~age+educ+black+hispan+married+nodegree+re74+re75,
                   family=binomial(),data=lalonde)
quiz2ps<-quiz2psmodel$fitted.values
weight<-ifelse(lalonde$treat==1,1/(quiz2ps),1/(1-quiz2ps))
summary(weight)
# Min: 1.009, Max: 40.077

#Q2: find SMD for each confounder on the weighted population
weightedqzdata<-svydesign(ids = ~ 1, data =lalonde, weights = ~ weight)

#weighted table 1, using the weighteddata
weightedqztable <-svyCreateTableOne(vars = xvars, strata = "treat", 
                                  data = weightedqzdata, test = FALSE)
print(weightedqztable, smd = TRUE)
# SMD for nodegree is 0.112

#Q3: using IPTW, find estimate of 95%CI for average causal effect. use svyglm
weightqzmodel<-ipwpoint(exposure= treat, family = "binomial", link ="logit",
                      denominator= ~ age+educ+black+hispan+married+nodegree+re74+re75, 
                      data=lalonde)
#numeric summary of weights
summary(weightqzmodel$ipw.weights)
#plot of weights - easier in this package
ipwplot(weights = weightqzmodel$ipw.weights, logscale = FALSE,
        main = "weights", xlim = c(0, 41))
lalonde$wt<-weightqzmodel$ipw.weights

#fit a marginal structural model (risk difference)
#using svyglm you can define your weights using the design argument
msm_qz <- (svyglm(re78 ~ treat, design = svydesign(~ 1, weights = ~wt,
                                                    data=lalonde)))
coef(msm_qz) # this is the same as the point estimate of the risk diff
confint(msm_qz) # same as above; fewer steps
# treat coef: 224.6763
# 95%CI: [-1559.321,2008.673]

#Q4: truncate at 0.01, re-do the causal estimate
weightqzmodel<-ipwpoint(exposure= treat, family = "binomial", link ="logit",
                        denominator= ~ age+educ+black+hispan+married+nodegree+re74+re75, 
                        data=lalonde, trunc = 0.01)
#numeric summary of weights
summary(weightqzmodel$weights.trunc)
#new max weight is 12.631, not 40 something
#replace wt with new truncated weights
lalonde$wt<-weightqzmodel$weights.trunc

#fit a marginal structural model (risk difference)
#using svyglm you can define your weights using the design argument
msm_qz <- (svyglm(re78 ~ treat, design = svydesign(~ 1, weights = ~wt,
                                                   data=lalonde)))
coef(msm_qz) # this is the same as the point estimate of the risk diff
confint(msm_qz) # same as above; fewer steps
#treat coef: 486.9336
#95% CI: [-1090.639,2064.506]




