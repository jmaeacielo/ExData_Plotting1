## Initialize package
library(data.table)

## Assuming data has already been downloaded, read the dataset and assign it to variable "consumption"
consumption <- fread("household_power_consumption.txt", na.strings="?")

## Convert dates into D-M-Y
consumption[, Date := lapply(.SD, as.Date, "%d/%m/%Y"), .SDcols = c("Date")]

## Subset two-day data from 2007-02-01 to 2007-02-03 (to capture the three days of consumption)
consumption4 <- consumption[(Date >= "2007-02-01") 
                            & (Date <= "2007-02-02") 
                            & (Date <= "2007-02-03")]

## Create new column merging the variable Date and Time
datetime <- paste(as.Date(consumption4$Date), consumption4$Time)
consumption4$Datetime <- as.POSIXct(datetime)

## Pre-set plot width and specifications for the needed graph
png("plot4.png", width = 480, height = 480)


## Define specific parameters for the graph
par(mfrow=c(2,2), mar=c(4,4,2,1), oma=c(0,0,2,0))

## Construct uppermost left plot: Global Active Power x Day
with(consumption4, {
  plot(Global_active_power~Datetime, 
       type="l", 
       ylab="Global Active Power", 
       xlab="")
  
## Construct uppermost right plot: Voltage x Day
  plot(Voltage~Datetime, 
       type="l", 
       ylab="Voltage", 
       xlab="datetime")
  
## Construct lowermost left plot: Sub metering x Day
  plot(Sub_metering_1~Datetime, type="l", 
       ylab="Energy sub metering", 
       xlab="")
  lines(Sub_metering_2~Datetime,col='Red')
  lines(Sub_metering_3~Datetime,col='Blue')
  
  ## Create legend of lowermost left plot
  legend("topright", 
         col=c("black", "red", "blue"), 
         lty=1, 
         lwd=2, 
         bty="n",
         legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

## Construct lowermost right plot: Global Reactive Power x Day
  plot(Global_reactive_power~Datetime, 
       type="l", 
       ylab="Global_reactive_power",
       xlab="datetime")
  
})

## Close device to finish plot
dev.off()