# plot4.R
# Syd-
# Ensure "household_power_consumption.txt" exists in the directory before calling this program!
# -------------------------------------------------------------
# Load the data
allData <- read.csv("household_power_consumption.txt", sep=";", header = TRUE, colClasses = c(rep("character", 9)))
# Coerce the date so we can subset it
allData$Date <- as.Date(strptime(allData$Date, "%d/%m/%Y"))
# Subset the data on 1st & 2nd of Febuary, 2007
data <- subset(allData, Date >= as.Date("2007-02-01 00:00:00") & Date <= as.Date("2007-02-02 23:59:59"))
# -------------------------------------------------------------
# Coerce Global Active Power, Voltage, Energy Sub Metering 1, 2, 3, Global Reactive Power as a number
data$Global_active_power <- as.numeric(data$Global_active_power)
data$Voltage <- as.numeric(data$Voltage)
data$Sub_metering_1 <- as.numeric(data$Sub_metering_1)
data$Sub_metering_2 <- as.numeric(data$Sub_metering_2)
data$Sub_metering_3 <- as.numeric(data$Sub_metering_3)
data$Global_reactive_power <- as.numeric(data$Global_reactive_power)
# Put together date AND time in a Posix format so we can plot it
data$DateTime <- as.POSIXct(paste(data$Date, data$Time))
# Create the parameters for the various plots
par(mfrow=c(2,2), mar=c(4,4,2,1), oma=c(0,0,2,0))
# Plot 1: Global active power
plot(data$Global_active_power~data$DateTime, type="l", ylab="Global Active Power (kilowatts)", xlab="")
# Plot 2: Voltage
plot(data$Voltage~data$DateTime, type="l", ylab="Voltage (volts)", xlab="")
# Plot 3: Submeters
plot(data$Sub_metering_1~data$DateTime, type="l", xlab="datetime", ylab="Energy sub metering", col="black")
# Add more lines to plot!
lines(data$Sub_metering_2~data$DateTime, col="red")
lines(data$Sub_metering_3~data$DateTime, col="blue")
# Add the legend
legend("topright", col=c("black", "red", "blue"), legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=1, cex=0.5)
# Plot 4: Global reactive power
plot(data$Global_reactive_power~data$DateTime, type="l", ylab="Global Reactive Power (kilowatts)", xlab="datetime")
# Copy the line graph to a png file (with correct dimensions)
dev.copy(png, file="plot4.png", height=480, width=480)
# Turn off dev
dev.off()