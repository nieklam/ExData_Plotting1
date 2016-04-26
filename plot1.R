## this file create plot plot1

# reading the records
library(data.table)
library(plyr)
myfile = "household_power_consumption.txt"
myData <- fread(myfile, skip=1, select = c(1:9), na.strings = "?",
              col.names=c( "Date", "Time", "GlAcPower", "GlRPower", "Voltage", "GI", "sm1", "sm2", "sm3") )

# selection of the days 2007-02-01 and 2007-02-02
library(lubridate)
myData <- mutate(myData, Date = dmy(myData$Date) ) 
myData <- subset(myData, Date<"2007-02-03")
myData <- subset(myData, Date>"2007-01-31")

# opening png file (width and height both default 480)
png(filename = "plot1.png")

# plot the required figure
hist( myData$GlAcPower, col = "red", xlab = "Global Active Power (kilowatts)",  main = "Global Active Power")

# closing the png file
dev.off()