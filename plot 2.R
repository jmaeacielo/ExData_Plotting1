## Initialize needed package
library(data.table)

## Assuming data has already been downloaded, read the dataset and assign it to variable "consumption"
consumption <- fread("household_power_consumption.txt", na.strings="?")

## Convert dates into D-M-Y
consumption[, Date := lapply(.SD, as.Date, "%d/%m/%Y"), .SDcols = c("Date")]

## Subset two-day data from 2007-02-01 to 2007-02-03 (to capture the three days of consumption)
consumption2 <- consumption[(Date >= "2007-02-01") 
                              & (Date <= "2007-02-02") 
                              & (Date <= "2007-02-03")]

## Create new column merging the variable Date and Time
datetime <- paste(as.Date(consumption2$Date), consumption2$Time)
consumption2$Datetime <- as.POSIXct(datetime)

## Pre-set plot width and specifications for the needed graph
png("plot1.png", width = 480, height = 480)

## Create plot
with(consumption2, {
  plot(Global_active_power~Datetime, 
       type="l",
       ylab="Global Active Power (kilowatts)", 
       xlab="")
})

## Close device to finish plot
dev.off()