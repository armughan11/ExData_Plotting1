library(dplyr)
library(lubridate)
# Downloading the data and saving it to a file data.zip. Once downloaded, we extract the data.
# If the file exists it doesn't download it
if(!file.exists("./data")){dir.create("./data")
  fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
  download.file(fileUrl,destfile="./data/data.zip",method="curl")
  unzip(zipfile="./data/data.zip",exdir="./data")}

#Reading data and converting date string to Date format
path <- file.path("./data")
plot1  <- read.table(file.path(path, "household_power_consumption.txt" ), sep = ";", header = TRUE)
plot1[,1] <- as.Date(plot1[,1], format = "%d/%m/%Y")

#Subsettingg data and removing missing values.Creating new Date Time column with both date and time values
plot2 <- subset(plot1, plot1[,1]>="2007-02-01" & plot1[,1]<="2007-02-02")
plot2 <- plot2[!grepl("\\?", plot2[,2]),]
plot2$DateTime <- ymd(plot2[,1])+hms(plot2[,2])

# Setting graphic device as PNG and then saving the plot with relevant parameters
png(filename = "plot4.png", width = 480, height = 480, units = "px")
par(mfrow=c(2,2), mar=c(4,4,2,1))


plot(plot2$DateTime, as.numeric(plot2$Global_active_power), type = "l", xlab = "", ylab = "Global Active Power")

plot(plot2$DateTime, plot2$Voltage, type = "l", xlab = "datetime", ylab = "Voltage")

plot(plot2$DateTime, plot2$Sub_metering_1, type = "l", xlab = "", ylab = "Energy sub metering")
points(plot2$DateTime, plot2$Sub_metering_2, type = "l", col = "red")
points(plot2$DateTime, plot2$Sub_metering_3, type = "l", col = "blue")
legend("topright", lty = c(1,1,1), col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), cex = 0.5, y.intersp = 0.5)

plot(plot2$DateTime, plot2$Global_reactive_power, type = "l", xlab = "datetime", ylab = "Global_reactive_power")

dev.off()