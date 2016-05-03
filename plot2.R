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

#=================================PLOT2
png(filename = "plot2.png", width = 480, height = 480,
    units = "px",
    restoreConsole = TRUE)

plot(data$Global_active_power,type="l",
     ylab="Global Active Power (kilowatts)",
     xlab="",
     main="",
     axes=F)
axis(side=1,at=c(1,24*60+1,24*60*2+1),labels=c("Thu","Fri","Sat"))
axis(side=2,at=seq(0,6,by=2),labels=seq(0,6,by=2))
box(lty=1)
dev.off()
