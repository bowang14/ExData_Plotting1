##read the data
dt<-read.table(".\\household_power_consumption.txt",sep=";",header=TRUE)

##change the class of $Date and $Time and extract components
dt$Date<-as.character(dt$Date)
dt$Time<-as.character(dt$Time)
p<-paste(dt$Date,dt$Time)
time<-unclass(as.POSIXlt(p,format="%d/%m/%Y %H:%M:%S"))

##select rows we need
t0<-(time$year+1900==2007&time$mon+1==2&time$mday==1)|(time$year+1900==2007&time$mon+1==2&time$mday==2)
dt1<-dt[t0,]

##change $Sub_metering_1/2/3 into numeric in order to create the plot
dt1$Sub_metering_1<-as.numeric(as.character(dt1$Sub_metering_1))
dt1$Sub_metering_2<-as.numeric(as.character(dt1$Sub_metering_2))
dt1$Sub_metering_3<-as.numeric(as.character(dt1$Sub_metering_3))

##create a new png file
png(file="plot3.png",width=480,height=480,units="px")

##plot dt1$Sub_metering_1 as time sequence and change the lables
plot(ts(dt1$Sub_metering_1),xaxt="n",xlab="",ylab="Energy sub merting")

##add lines of dt1$Sub_metering_2/3
lines(ts(dt1$Sub_metering_2),col="red")
lines(ts(dt1$Sub_metering_3),col="blue")

##add axis
axis(1,c(0,1440,2880),c("Thu","Fri","Sat"))

##add legend
legend("topright",col=c("black","red","blue"),lty=1,legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))

##close the file
dev.off()