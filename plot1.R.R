
rm(list = ls())

##Read in dataset converting the ? to NA data

data<-read.table("household_power_consumption.txt", header = TRUE,sep=";", na.strings="?")

##Subset data for the required dates 
as.character(data$Date)

DATES<-data[data$Date == "1/2/2007"| data$Date == "2/2/2007",]

#checks subsetting data is oka
head(DATES)
nrow(DATES)

##converts Date and Time columns to Date and Time

as.Date(DATES$Date, "%d/%m/%Y", tz="GMT")

as.character(DATES$Time)
strptime(DATES$Time, "%H:%M:%S")

DATES$DateTime<-as.POSIXct(paste (DATES$Date, DATES$Time), format="%d/%m/%Y %H:%M:%S")

#opens the png graphics device and assigns file name

png(file = "plot1.png", width = 480, height = 480, units = "px") 

#sets background to transparent
par("bg"="transparent")

#creates histogram then adds the main Title to it

hist(DATES$Global_active_power, col = "red",  main="Global Active Power", xlab = "Global Active Power (kilowatts)")

#closes the png device
dev.off()  