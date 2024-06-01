

setwd("C:/Users/odlia/Desktop")

# Reads the data file using the read.csv command
data = read.csv("household_power_consumption.txt", sep = ";", na.strings = "?")


#Changes the values into numeric
data$Global_active_power = as.numeric(data$Global_active_power)

#Changes Date Column to Date Type
data$Date = as.Date(data$Date, format = "%d/%m/%Y")


# Filter the data for dates between 2007-02-01 and 2007-02-02
data = data[data$Date >= as.Date("2007-02-01") 
            & data$Date <= as.Date("2007-02-02"), ]

#Prints the plot to a png file with the specified dimensions
png("plot1.png", width=480, height=480)

# Plot 1
hist(data$Global_active_power, main="Global Active Power", 
     xlab="Global Active Power (kilowatts)", ylab="Frequency", col="Red")

#closes the connection with png
dev.off()

