
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

head(DATES)

#opens the png graphics device and assigns file name

png(file = "plot4.png", width = 480, height = 480, units = "px") 

#sets background to transparent
par("bg"="transparent")

##sets up the formate of the graphs 2 rows and 2 columns
par(mfrow = c(2,2), mar = c(4, 4, 2, 1), oma = c(0, 0, 2, 0))

#creates Global active power and time graph

plot(DATES$DateTime, DATES$Global_active_power, 
     ylab="Global Active Power (kilowatts)", xlab="",type="l")

#creates voltage and time graph
plot(DATES$DateTime, DATES$Voltage, 
     ylab="Voltage", xlab="datetime",type="l")

#creates empty plot with correct x and y axes labels for sub-meter plots 

plot(DATES$DateTime,DATES$Sub_metering_1, ylab="Energy sub metering", xlab="", type="n")

#adding  in the three sub metering data columns as lines with appropriate colours

  points(x=DATES$DateTime, y=DATES$Sub_metering_1,type="l")
  points(x=DATES$DateTime, y=DATES$Sub_metering_2, type="l", col="red")
  points(x=DATES$DateTime, y=DATES$Sub_metering_3, type="l", col="blue")

legend("topright", lty = 1, col = c("black","red", "blue"), 
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

#creates Global_reactive_power and time graph
plot(DATES$DateTime, DATES$Global_reactive_power, 
     ylab="Global_reactive_power", xlab="datetime", type="l")

#closes the png device
dev.off()  

