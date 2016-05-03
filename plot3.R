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


#=================================PLOT3
png(filename = "plot3.png", width = 480, height = 480,
    units = "px",
    restoreConsole = TRUE)

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
legend(x="topright",legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),lty=1,col=c(1,2,4))
dev.off()

