
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

png(file = "plot3.png", width = 480, height = 480, units = "px") 

par("bg"="transparent")

#creates empty plot with correct x and y axes labels 

plot(DATES$DateTime,DATES$Sub_metering_1, ylab="Energy sub metering", xlab="", type="n")

#adding  in the three sub metering data columns as lines with appropriate colours

  points(x=DATES$DateTime, y=DATES$Sub_metering_1,type="l")
  points(x=DATES$DateTime, y=DATES$Sub_metering_2, type="l", col="red")
  points(x=DATES$DateTime, y=DATES$Sub_metering_3, type="l", col="blue")

legend("topright", lty = 1, col = c("black","red", "blue"), 
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

#closes the png device
dev.off()  