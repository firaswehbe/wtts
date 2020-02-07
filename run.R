library(TTR)
rm(list=ls())

# Skip the following if you have a `mywtsdf` frame with the following columns
# * date with Date values
# * weight with numeric weight values
source('read_weights.R')

# Skip the following if you have a zoo object `mywtszoo` 
source('make_ts.R')

# You can modify this
mystartdate = as.POSIXct(Sys.Date() - 365)
mystartdate = as.POSIXct('2018-10-01')

# Calculate then cut the window
mywts.xts <- merge(mywts.xts, EMA(mywts.xts$Weight, n = 90))
mywts.xts <- merge(mywts.xts, EMA(mywts.xts$Weight, n = 21))
mymacd <- MACD(mywts.xts$Weight, nFast = 21, nSlow = 90, nSig = 14, percent = FALSE)
mywts.xts <- merge(mywts.xts, mymacd)
myhist <- mywts.xts[,4] - mywts.xts[,5]
mywts.xts <- merge(mywts.xts, myhist)

names(mywts.xts) <- c("Weight", "Slow", "Fast", "MACD", "Signal","Hist")
rm(myhist,mymacd,mywts.df)

mywts.xts<-window(mywts.xts, start = mystartdate)

png(filename = 'output/wt_macd.png',width = 1600,height = 900,res = 150)
plot.xts(mywts.xts$Weight,type = 'p',pch=16,col="blue",main=NA,cex=0.8,
         ylim=c(min(mywts.xts[,c(1:3)],na.rm = TRUE)-1,max(mywts.xts[,c(1:3)],na.rm = TRUE)+1))
lines(mywts.xts$Slow,on=0,col="green", lwd=2)
lines(mywts.xts$Fast,on=0,col="black", lwd=2)

lines(mywts.xts$MACD,on=NA,col="blue", lwd=2,
      ylim=c(min(mywts.xts[,c(4:6)],na.rm = TRUE)-1,max(mywts.xts[,c(4:6)],na.rm = TRUE)+1))
lines(mywts.xts$Signal,on=0,col="red", lwd=2)
print(lines(mywts.xts$Hist,on=0,col="black",type="h")) #Need print for lattice graphics to print when sourced
dev.off()
