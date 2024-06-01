

setwd("C:/Users/odlia/Desktop")

# Reads the data file using the read.csv command
data <- read.csv("household_power_consumption.txt", sep = ";", na.strings = "?")


#Changes the values into numeric
data$Global_active_power <- as.numeric(data$Global_active_power)

#Makes a POSIXct date which is capable of being filtered and graphed by time of day
data$dateTime <- as.POSIXct(paste(data$Date, data$Time), format = "%d/%m/%Y %H:%M:%S")

# Filter the data for dates between 2007-02-01 and 2007-02-02
data <- data[data$dateTime >= as.POSIXct("2007-02-01") & data$dateTime < as.POSIXct("2007-02-03"), ]

#Prints the plot to a png file with the specified dimensions
png("plot2.png", width=480, height=480)

# Plot 2 without the x axis
plot(x = data$dateTime, 
     y = data$Global_active_power, 
     type="l", xlab="", ylab="Global Active Power (kilowatts)", xaxt='n')

#Creates a custom x-axis with the specified days of the week
axis(1, at = seq(from = as.POSIXct("2007-02-01"), to = as.POSIXct("2007-02-03"), by = "day"), 
     labels = c("Thu", "Fri", "Sat"))

#closes the connection with png
dev.off()
