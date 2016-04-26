## this file create plot2

#reading the records
library(data.table)
library(dplyr)
myfile = "household_power_consumption.txt"
mydata <- fread(myfile, skip=1, select = c(1:9), na.strings = "?",
                col.names=c( "Date", "Time", "GlAcPower", "GlRPower", "Voltage", "GI", "sm1", "sm2", "sm3") )
df <- data.frame( mydata )

#selecting the proper days
library(lubridate)
df <- mutate(df, day = dmy(df$Date) ) 
df <- subset(df, day<"2007-02-03")
df <- subset(df, day>"2007-01-31")

#combine date and time, and setting a format
df <- mutate(df, moment = paste(Date, Time))
df$moment <- strptime( df$moment, "%d/%m/%Y %H:%M:%S" )

# opening png file (width and height both default 480)
png(filename = "plot2.png")

#plot
with(df, plot(x = df$moment, y = df$GlAcPower, type = "l", xlab = "", ylab = "Global Active Power (kilowatts)") )

# closing the png file
dev.off()