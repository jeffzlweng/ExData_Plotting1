# doanload and unzip file
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",
              destfile = "power_comsuption.zip")
unzip("power_comsuption.zip", exdir = ".")

# read and clean data
df <- read.csv("./household_power_consumption.txt", sep = ";", na.strings = c("?"))
df$Datetime <- paste(df$Date, df$Time, sep = " ")
df$Datetime <- strptime(df$Datetime, format = "%d/%m/%Y %H:%M:%S")
upperbound <- strptime("03/02/2007", "%d/%m/%Y")
lowerbound <- strptime("01/02/2007", "%d/%m/%Y")
twoday <- subset(df, Datetime < upperbound & Datetime >= lowerbound)
head(twoday)

## ploting
dev.new(width=480, height=480)
par(mfrow = c(2, 2))
plot(twoday$Datetime,
     twoday$Global_active_power,
     type = "l",
     xlab = "",
     ylab = "Global Active Power (kilowatts)")
plot(twoday$Datetime,
     twoday$Voltage,
     type = "l",
     xlab = "datetime",
     ylab = "Voltage")
plot(twoday$Datetime,
     twoday$Sub_metering_1,
     type = "l",
     xlab = "",
     ylab = "Energy sub metering",
     col = "black")
lines(twoday$Datetime,
      twoday$Sub_metering_2,
      type = "l",
      col = "red")
lines(twoday$Datetime,
      twoday$Sub_metering_3,
      type = "l",
      col = "blue")
legend("topright", 
       lty = 1,
       col = c("black", "red", "blue"), 
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
plot(twoday$Datetime,
     twoday$Global_reactive_power,
     type = "l",
     xlab = "datetime",
     ylab = "Global_reactive_power",
     col = "black")
dev.copy2pdf(file = "plot4.pdf")
dev.off()