
rm(list = ls())

##Read in dataset converting the ? to NA data

data<-read.table("household_power_consumption.txt", header = TRUE,sep=";", na.strings="?")
head(data)

##Check class of Date column and levels of factors
class(data$Date)
levels(data$Date)

##Subset data for the required dates 
as.character(data$Date)

DATES<-data[data$Date == "1/2/2007"| data$Date == "2/2/2007",]

#checks subsetting data is okay
head(DATES)
nrow(DATES)

##converts Date and Time columns to Date and Time

as.Date(DATES$Date, "%d/%m/%Y", tz="GMT")

as.character(DATES$Time)
strptime(DATES$Time, "%H:%M:%S")

DATES$DateTime<-as.POSIXct(paste (DATES$Date, DATES$Time), format="%d/%m/%Y %H:%M:%S")

#opens the png graphics device and assigns file name

png(file = "plot2.png", width = 480, height = 480, units = "px") 

par("bg"="transparent")

#creates the plot

plot(DATES$DateTime, DATES$Global_active_power, 
  ylab="Global Active Power (kilowatts)", xlab="", type="l")

#closes the png device
dev.off()  