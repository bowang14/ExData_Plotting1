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

##change the class into numeric in order to create the plot
dt1$Global_active_power<-as.numeric(as.character(dt1$Global_active_power))
dt1$Global_reactive_power<-as.numeric(as.character(dt1$Global_reactive_power))
dt1$Voltage<-as.numeric(as.character(dt1$Voltage))
dt1$Sub_metering_1<-as.numeric(as.character(dt1$Sub_metering_1))
dt1$Sub_metering_2<-as.numeric(as.character(dt1$Sub_metering_2))
dt1$Sub_metering_3<-as.numeric(as.character(dt1$Sub_metering_3))

##create a new png file
png(file="plot4.png",width=480,height=480,units="px")

##call the par() command to create 4 plots
par(mfrow=c(2,2))

##plot 1
plot(ts(dt1$Global_active_power),xaxt='n',xlab="",ylab="Global Active Power")
axis(1,c(0,1440,2880),c("Thu","Fri","Sat"))

##plot 2
plot(ts(dt1$Voltage),xaxt='n',xlab="",ylab="Voltage",sub="datetime")
axis(1,c(0,1440,2880),c("Thu","Fri","Sat"))

##plot 3
plot(ts(dt1$Sub_metering_1),xaxt="n",xlab="",ylab="Energy sub merting")
lines(ts(dt1$Sub_metering_2),col="red")
lines(ts(dt1$Sub_metering_3),col="blue")
axis(1,c(0,1440,2880),c("Thu","Fri","Sat"))
legend("topright",col=c("black","red","blue"),lty=1,legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),cex=0.7)

##plot 4
plot(ts(dt1$Global_reactive_power),xaxt='n',xlab="",ylab="Global_active_power",sub="datetime")
axis(1,c(0,1440,2880),c("Thu","Fri","Sat"))

##close the file
dev.off()