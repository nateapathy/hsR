# get our packages loaded... you may have to install some of these
# install.packages("XML")
# install.packages("RCurl")
# install.packages("rlist")
# install.packages("ggplot2")

library(XML)
library(RCurl)
library(rlist)
library(ggplot2)

theurl <- getURL("https://infogalactic.com/info/List_of_current_United_States_Senators_by_age",.opts = list(ssl.verifypeer = FALSE) )
sen_ages <- readHTMLTable(theurl)
sen_ages <- sen_ages$`NULL`

# the last row is erroneously included, trim it off
sen_ages <- sen_ages[1:100,]

# convert the current age field to character for parsing
as.character(sen_ages$`Current age`)

# grab the age in years out of that string
sen_ages$yrs <- as.numeric(substr(sen_ages$`Current age`, 21,22))

# char conversion for party
sen_ages$Party <- as.character(sen_ages$Party)
# independent has some weird [1] after it, remove that
sen_ages$Party <- str_replace_all(sen_ages$Party,regex("^Indep.*$"),"Independent")
# make it a factor to use in the colorization
sen_ages$Party <- as.factor(sen_ages$Party)

# grab the term length variable
sen_ages$termlen <- as.numeric(substr(as.character(sen_ages[,7]), 21,22))
# some are single digits, so just trim off that white space
sen_ages$termlen <- trimws(sen_ages$termlen,which = "right")
# make sure they are numeric
sen_ages$termlen <- as.numeric(sen_ages$termlen)

# define our colors for the parties
plotcols <- c('Democratic'='blue','Republican'='red','Independent'='green')

# plot it
ggplot(sen_ages, aes(x=yrs)) + geom_histogram(aes(yrs), alpha=0.3, bins=10) +
  scale_fill_manual(values=plotcols) +
  scale_color_manual(values = plotcols) +
  geom_vline(xintercept = 81) +
  geom_vline(xintercept = 65) +
  geom_point(aes(y=termlen, color=Party), alpha=0.6, size=4) +
  labs(x="Current Age in Years",
       y="Years in Office",
       caption="Vertical lines at 65y (retirement age) and 81y (female life expectancy)",
       title = "Age Distribution and Term Length of Current Senate") +
  annotate("text", x = 50, y = 19, label = "Histogram shows overall distribution of ages in Senate") +
  theme(legend.position=c(0.20,0.75))
