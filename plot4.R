#reads in huge data file
HHPower <- read.table("./data/household_power_consumption.txt", header=TRUE,
 sep=";", na.strings="?",stringsAsFactors=FALSE)

#mashes together date and time and then strptimes it
HHPower$DateTime <- paste(HHPower$Date, HHPower$Time) 
HHPower$DateTime <- as.Date(HHPower$DateTime, format = "%d/%m/%Y %H:%M:%S")

#using dplyr allows you to select dates in a given range
library(dplyr)
HHPowerSub <- filter(HHPower, DateTime >= as.Date("2007-02-01 00:00:00"), DateTime < as.Date("2007-02-03 00:00:00"))

#Creating a final time var to use for tables
HHPowerSub$Date_Time <- paste(HHPowerSub$Date, HHPowerSub$Time) 
HHPowerSub$Date_Time <- strptime(HHPowerSub$Date_Time, format = "%d/%m/%Y %H:%M:%S")

#Plot 4 - plot with 4 plots
par(mfrow=c(2,2))
plot(HHPowerSub$Date_Time, HHPowerSub$Global_active_power, type="l",
 xlab="", ylab="Global Active Power")
plot(HHPowerSub$Date_Time, HHPowerSub$Voltage, type="l",
 xlab="datetime", ylab="Voltage")
plot(HHPowerSub$Date_Time, HHPowerSub$Sub_metering_1, type="l",
 xlab="", ylab="Energy sub metering")
 lines(HHPowerSub$Date_Time, HHPowerSub$Sub_metering_2, type="l", col="red")
 lines(HHPowerSub$Date_Time, HHPowerSub$Sub_metering_3, type="l", col="blue")
 legend("topright", legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
  cex=.5, col=c("black", "red", "blue"), lty=1, bty="n")
plot(HHPowerSub$Date_Time, HHPowerSub$Global_reactive_power, type="l",
 xlab="datetime", ylab="Global_reactive_power")
dev.copy(png, file="./data/plot4.png", width=480, height=480)
dev.off()
