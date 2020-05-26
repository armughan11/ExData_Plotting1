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
png(filename = "plot2.png", width = 480, height = 480, units = "px")
plot(plot2$DateTime, as.numeric(plot2$Global_active_power), type = "l", ylab = "Global Active Power (Kilowatts)", xlab = "")
dev.off()

