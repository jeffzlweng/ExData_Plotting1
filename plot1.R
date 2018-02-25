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

# ploting
dev.new(width=480, height=480)
hist(twoday$Global_active_power,
     main = "Global Active Power",
     xlab = "Global Active Power (kilowatts)",
     ylab = "Frequence", 
     col = "red")
dev.copy2pdf(file = "plot1.pdf")
dev.off()
