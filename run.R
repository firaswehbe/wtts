library(TTR)
rm(list=ls())

# Skip the following if you have a `mywtsdf` frame with the following columns
# * date with Date values
# * weight with numeric weight values
source('read_weights.R')

# Skip the following if you have a zoo object `mywtszoo` 
source('make_ts.R')

# You can modify this
mystartdate = as.POSIXct(Sys.Date() - 90)
mystartdate = as.POSIXct('2012-10-01')

# Calculate then cut the window
mywts.EMA26<-window( EMA(mywts.xts, n = 90), start = mystartdate)
names(mywts.EMA26) = 'EMA26'
mywts.EMA12<-window( EMA(mywts.xts, n = 21), start = mystartdate)
names(mywts.EMA12) = 'EMA12'
mymacd <- window( MACD(mywts.xts, nFast = 21, nSlow = 90, nSig = 14), start = mystartdate)
mymacd$hist <- mymacd$macd - mymacd$signal
mywts.xts<-window(mywts.xts, start = mystartdate)


png(filename = 'output/values.png',width = 1600,height = 900,res = 150)
plot(mywts.xts, type='p', pch=16, main=NA, col="blue")
lines(mywts.EMA12, col="black", lwd = 2)
lines(mywts.EMA26, col="green", lwd = 2)
dev.off()

png(filename = 'output/macd.png',width = 1600,height = 900,res = 150)
plot(mymacd[,c(1,2)],lwd=2,col=c('blue','red'), main=NA)
lines(mymacd$hist,type='h', on=NA)
dev.off()
