# plot2.R
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
# Coerce Global active power as a number
data$Global_active_power <- as.numeric(data$Global_active_power)
# Put together date AND time in a Posix format so we can plot it
data$DateTime <- as.POSIXct(paste(data$Date, data$Time))
# Plot it!
plot(data$Global_active_power~data$DateTime, type="l", xlab="", ylab="Global Active Power (kilowatts)")
# Copy the line graph to a png file (with correct dimensions)
dev.copy(png, file="plot2.png", height=480, width=480)
# Turn off dev
dev.off()