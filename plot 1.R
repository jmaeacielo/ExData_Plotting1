## Initialize needed package
library(data.table)

## Assuming data has already been downloaded, read the dataset and assign it to variable "consumption"
consumption <- fread("household_power_consumption.txt", na.strings="?")

## Convert dates into D-M-Y
consumption[, Date := lapply(.SD, as.Date, "%d/%m/%Y"), .SDcols = c("Date")]

## Subset two-day data from 2007-02-01 to 2007-02-02
consumption1 <- consumption[(Date >= "2007-02-01") & (Date <= "2007-02-02")]

## Pre-set plot width and specifications for the needed graph
png("plot1.png", width = 480, height = 480)

## Create histogram from the data
hist(consumption1$Global_active_power, 
     main="Global Active Power", 
     xlab="Global Active Power (kilowatts)", 
     ylab="Frequency", 
     col="Red")

## Close graphic device to finish plot creation
dev.off()
