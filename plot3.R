# plot3.R
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
# Coerce Sub_metering_1, 2, 3 as a number
data$Sub_metering_1 <- as.numeric(data$Sub_metering_1)
data$Sub_metering_2 <- as.numeric(data$Sub_metering_2)
data$Sub_metering_3 <- as.numeric(data$Sub_metering_3)
# Put together date AND time in a Posix format so we can plot it
data$DateTime <- as.POSIXct(paste(data$Date, data$Time))
# Plot it!
plot(data$Sub_metering_1~data$DateTime, type="l", xlab="", ylab="Energy sub metering", col="black")
# Add more lines to plot!
lines(data$Sub_metering_2~data$DateTime, col="red")
lines(data$Sub_metering_3~data$DateTime, col="blue")
# Add the legend
legend("topright", col=c("black", "red", "blue"), legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=1,  cex=0.5)
# Copy the line graph to a png file (with correct dimensions)
dev.copy(png, file="plot3.png", height=480, width=480)
# Turn off dev
dev.off()