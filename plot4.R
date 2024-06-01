

setwd("C:/Users/odlia/Desktop")

# Reads the data file using the read.csv command
data <- read.csv("household_power_consumption.txt", sep = ";", na.strings = "?")

#Changes the values into numeric
data$Global_active_power <- as.numeric(data$Global_active_power)
data$Voltage <- as.numeric(data$Voltage)
data$Global_reactive_power <- as.numeric(data$Global_reactive_power)
data$Sub_metering_1 <- as.numeric(data$Sub_metering_1)
data$Sub_metering_2 <- as.numeric(data$Sub_metering_2)
data$Sub_metering_3 <- as.numeric(data$Sub_metering_3)

#Makes a POSIXct date which is capable of being filtered and graphed by time of day
data$dateTime <- as.POSIXct(paste(data$Date, data$Time), format = "%d/%m/%Y %H:%M:%S")

# Filter the data for dates between 2007-02-01 and 2007-02-02
data <- data[data$dateTime >= as.POSIXct("2007-02-01") & 
                 data$dateTime < as.POSIXct("2007-02-03"), ]

#Prints the plot to a png file with the specified dimensions
png("plot4.png", width=480, height=480)

#Sets the plotting area to be 2x2
par(mfrow=c(2,2))

# Plot 1
plot(data$dateTime, data$Global_active_power, type="l", xlab="", ylab="Global Active Power", xaxt='n')
axis(1, at = seq(from = as.POSIXct("2007-02-01"), to = as.POSIXct("2007-02-03"), by = "day"), labels = c("Thu", "Fri", "Sat"))

# Plot 2
plot(data$dateTime, data$Voltage, type="l", xlab="datetime", ylab="Voltage", xaxt='n')
axis(1, at = seq(from = as.POSIXct("2007-02-01"), to = as.POSIXct("2007-02-03"), by = "day"), labels = c("Thu", "Fri", "Sat"))

# Plot 3
plot(data$dateTime, data$Sub_metering_1, type="l", xlab="", ylab="Energy sub metering", xaxt='n')
lines(data$dateTime, data$Sub_metering_2, col="red")
lines(data$dateTime, data$Sub_metering_3, col="blue")
legend("topright", col=c("black","red","blue"), 
       legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
       lty=1, bty="n", cex=.5)
axis(1, at = seq(from = as.POSIXct("2007-02-01"), to = as.POSIXct("2007-02-03"), by = "day"), labels = c("Thu", "Fri", "Sat"))

# Plot 4
plot(data$dateTime, data$Global_reactive_power, type="l", xlab="datetime", ylab="Global Reactive Power", xaxt='n')
axis(1, at = seq(from = as.POSIXct("2007-02-01"), to = as.POSIXct("2007-02-03"), by = "day"), labels = c("Thu", "Fri", "Sat"))

#closes the connection with png
dev.off()
