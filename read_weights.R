myrawdata <- read.csv('input/mydata.csv')
mywts.df <- data.frame(date = as.Date(myrawdata$Date,'%m/%d/%Y'),weight=myrawdata$Weight)
rm(list=c('myrawdata'))