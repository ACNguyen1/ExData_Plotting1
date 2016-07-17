library(dplyr)

## extract the downloaded zip file in the working directory
setwd("./data")
unzip("exdata%2Fdata%2Fhousehold_power_consumption.zip", files = NULL, list = FALSE, overwrite = TRUE,
      junkpaths = FALSE, exdir = ".", unzip = "internal", setTimes = FALSE)

## read the unzip txt file into the data frame
hpc <- read.csv("household_power_consumption.txt", sep=";", header=TRUE,stringsAsFactors=FALSE,na.strings="?")

## filter only data from the dates 2007-02-01 and 2007-02-02
hpc_FEB <- filter(hpc,Date %in% c("1/2/2007","2/2/2007"))

## convert the Date and Time variables
dateTime <- strptime(paste(hpc_FEB$Date, hpc_FEB$Time, sep=" "), "%d/%m/%Y %H:%M:%S") 

## make plot
png("plot3.png", width=480, height=480)

plot(dateTime, hpc_FEB$Sub_metering_1, type="l", ylab="Energy Submetering", xlab="")
lines(dateTime, hpc_FEB$Sub_metering_2, type="l", col="red")
lines(dateTime, hpc_FEB$Sub_metering_3, type="l", col="blue")
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=1, lwd=2.5, col=c("black", "red", "blue"))

dev.off()