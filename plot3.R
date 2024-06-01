

setwd("C:/Users/odlia/Desktop")

# Reads the data file using the read.csv command
data <- read.csv("household_power_consumption.txt", sep = ";", na.strings = "?")


#Changes the values into numeric
data$Global_active_power <- as.numeric(data$Global_active_power)

#Makes a POSIXct date which is capable of being filtered and graphed by time of day
data$dateTime <- as.POSIXct(paste(data$Date, data$Time), format = "%d/%m/%Y %H:%M:%S")

# Filter the data for dates between 2007-02-01 and 2007-02-02
data <- data[data$dateTime >= as.POSIXct("2007-02-01") & 
                 data$dateTime < as.POSIXct("2007-02-03"), ]

#Prints the plot to a png file with the specified dimensions
png("plot3.png", width=480, height=480)

# Plot 3 without the x-axis
plot(x = data$dateTime, 
     y = data$Sub_metering_1, 
     type="l", xlab="", ylab="Energy sub metering", xaxt='n')
lines(data$dateTime, data$Sub_metering_2, col="red")
lines(data$dateTime, data$Sub_metering_3, col="blue")

#Creates a custom x-axis with the specified days of the week
axis(1, at = seq(from = as.POSIXct("2007-02-01"), to = as.POSIXct("2007-02-03"), by = "day"), 
     labels = c("Thu", "Fri", "Sat"))

#Adds a legend to the plot
legend("topright", col=c("black","red","blue"), 
       legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
       lty=c(1,1), lwd=c(1,1))

#closes the connection with png
dev.off()
