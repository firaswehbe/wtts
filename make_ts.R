library(xts)
mywts.xts <- xts(mywts.df$weight,order.by = mywts.df$date)
names(mywts.xts)<-'Weight'

# Uncomment this block if you want to make it a regular series
# blanks.xts <- xts(rep(NA,1+end(mywts.xts)-start(mywts.xts)),
#                   order.by = seq.Date(start(mywts.xts), end(mywts.xts), by = 'day'))
# 
# mywts.xts<-merge(mywts.xts,blanks.xts)[,1]
