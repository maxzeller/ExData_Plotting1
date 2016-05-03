temp <- tempfile()
download.file("https://d396qusza40orc.cloudfront.net/exdata/data/household_power_consumption.zip",temp)
test <- read.table(unz(temp, "household_power_consumption.txt"),header=T,sep=";",nrows=5,na.strings="?",stringsAsFactors=F)

print(test)
data <- read.table(unz(temp, "household_power_consumption.txt"),header=T,sep=";",nrows=90*24*60,na.strings="?",stringsAsFactors=F)
unlink(temp)


data$Date<-as.Date(strptime(data$Date,format="%d/%m/%Y"))

start<-min(which(data$Date>=as.Date("2007-02-01")))
end<-max(which(data$Date<=as.Date("2007-02-02")))+1

data<-data[start:end,]



#=================================PLOT4
png(filename = "plot4.png", width = 480, height = 480,
    units = "px",
    restoreConsole = TRUE)

par(mfrow=c(2,2))

plot(data$Global_active_power,type="l",
     ylab="Global Active Power",
     xlab="",
     main="",
     axes=F)
axis(side=1,at=c(1,24*60+1,24*60*2+1),labels=c("Thu","Fri","Sat"))
axis(side=2,at=seq(0,6,by=2),labels=seq(0,6,by=2))
box(lty=1)

plot(data$Voltage,type="l",
     ylab="Voltage",
     xlab="datetime",
     main="",
     axes=F)
axis(side=1,at=c(1,24*60+1,24*60*2+1),labels=c("Thu","Fri","Sat"))
axis(side=2,at=seq(234,246,by=2),labels=seq(234,246,by=2))
box(lty=1)

plot(data$Sub_metering_1,type="l",
     ylab="Energy sub metering",
     xlab="",
     main="",
     axes=F)
axis(side=2,at=seq(0,30,by=10),labels=seq(0,30,by=10))
axis(side=1,at=c(1,24*60+1,24*60*2+1),labels=c("Thu","Fri","Sat"))
box(lty=1)
lines(data$Sub_metering_2,type="l",col="red")
lines(data$Sub_metering_3,type="l",col="blue")
legend(x="topright",legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),lty=1,col=c(1,2,4),xjust=0,yjust=0,bty="n")


plot(data$Global_reactive_power,type="l",
     ylab="Global_reactive_power",
     xlab="datetime",
     main="",
     axes=F)
axis(side=2,at=seq(0,0.5,by=0.1),labels=T)
axis(side=1,at=c(1,24*60+1,24*60*2+1),labels=c("Thu","Fri","Sat"))
box(lty=1)

dev.off()


