## this file create plot4

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
png(filename = "plot4.png")

#there will be panels
par(mfrow=c(2,2))

#plot top left
with(df, plot(x = df$moment, y = df$GlAcPower, type = "l", 
              xlab = "", ylab = "Global Active Power") )

#plot top right
with(df, plot(x = df$moment, y = df$Voltage, type = "l", 
              xlab = "datatime", ylab = "Voltage") )

#plot bottom left
with(df, plot(x = df$moment, y = df$sm1, col = "black", type = "l",
              xlab = "", ylab = "Energy sub metering")  )
lines(        x = df$moment, y = df$sm2, col = "red",   type = "l")
lines(        x = df$moment, y = df$sm3, col = "blue",   type = "l")
legend("topright", lty = c(1, 1, 1), col=c("black","red", "blue"),
       legend=c("Sub_meting_1","Sub_meting_2", "Sub_meting_3"))


#plot bottom right
with(df, plot(x = df$moment, y = df$GlRPower, type = "l", 
              xlab = "datatime", ylab = "Global_reactive_power") )

# closing the png file
dev.off()

