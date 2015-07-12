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

##change $Global_active_power into numeric in order to create the plot
dt1$Global_active_power<-as.numeric(as.character(dt1$Global_active_power))

##plot it into a png file
png(file="plot1.png",width=480,height=480,units="px")
hist(dt1$Global_active_power,col="red",xlab="Global Active Power (Kilowatts)",main="Global Active Power")
dev.off()