# plot1.R
# Syd-
# Ensure "household_power_consumption.txt" exists in the directory before calling this program!
# -------------------------------------------------------------
# Load the data
allData <- read.csv("household_power_consumption.txt", sep=";", header = TRUE, colClasses = c(rep("character", 9)))
# Coerce the date so we can subset it
allData$Date <-  as.Date(strptime(allData$Date, "%d/%m/%Y"))
# Subset the data on 1st & 2nd of Febuary, 2007
data <- subset(allData, Date >= as.Date("2007-02-01") & Date <= as.Date("2007-02-02"))
# -------------------------------------------------------------
# Coerce Global active power as a number
data$Global_active_power <- as.numeric(data$Global_active_power)
# Draw the histogram of Global active power vs Frequency
hist(data$Global_active_power, col="red", xlab="Global Active Power (kilowatts)", ylab="Frequency", main="Global Active Power")
# Copy the histogram to a png file (with correct dimensions)
dev.copy(png, file="plot1.png", height=480, width=480)
# Turn off dev
dev.off()