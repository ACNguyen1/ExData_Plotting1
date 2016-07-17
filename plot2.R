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
png("plot2.png", width=480, height=480)
plot(dateTime, hpc_FEB$Global_active_power, type="l", xlab="", ylab="Global Active Power (kilowatts)")
dev.off()