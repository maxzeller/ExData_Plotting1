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

#=================================PLOT1
png(filename = "plot1.png", width = 480, height = 480,
    units = "px",
    restoreConsole = TRUE)


hist(data$Global_active_power,freq=TRUE,
     xlab="Global Active Power (kilowatts)",
     ylab="Frequency",
     main="Global Active Power",
     col="red")
dev.off()