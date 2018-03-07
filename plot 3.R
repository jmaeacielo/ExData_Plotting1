## Initialize package
library(data.table)

## Assuming data has already been downloaded, read the dataset and assign it to variable "consumption"
consumption <- fread("household_power_consumption.txt", na.strings="?")

## Convert dates into D-M-Y
consumption[, Date := lapply(.SD, as.Date, "%d/%m/%Y"), .SDcols = c("Date")]

## Subset two-day data from 2007-02-01 to 2007-02-03 (to capture the three days of consumption)
consumption3 <- consumption[(Date >= "2007-02-01") 
                            & (Date <= "2007-02-02") 
                            & (Date <= "2007-02-03")]

## Create new column merging the variable Date and Time
datetime <- paste(as.Date(consumption3$Date), consumption3$Time)
consumption3$Datetime <- as.POSIXct(datetime)

## Pre-set plot width and specifications for the needed graph
png("plot3.png", width = 480, height = 480)

## Create plot
with(consumption3, {
  plot(Sub_metering_1~Datetime, type="l",
       ylab="Energy sub metering", 
       xlab="")
  lines(Sub_metering_2~Datetime,col='Red')
  lines(Sub_metering_3~Datetime,col='Blue')
})

## Create appropriate legend
legend("topright", 
       col=c("black", "red", "blue"), 
       lty=1, 
       lwd=2, 
       legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

## Close device to finish plot
dev.off()