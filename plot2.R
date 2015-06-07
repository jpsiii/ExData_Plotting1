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

#Plot 2 - Plot with solid line for Global_Power var between Thurs-Fri
plot(HHPowerSub$Date_Time, HHPowerSub$Global_active_power, type="l",
 xlab="", ylab="Global Active Power (kilowatts)")
dev.copy(png, file="./data/plot2.png", width=480, height=480)
dev.off()
