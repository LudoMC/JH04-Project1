#Retrieve and unzip the file
fileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
if (!file.exists("data")) {
    dir.create("data")
}
download.file(fileURL, destfile = "./data/power.zip", method="curl")
unzip("data/power.zip", exdir = "./data")

#Read entire file
power <- read.table("data/household_power_consumption.txt",
                    sep = ";",
                    na.strings = "?",
                    header = TRUE)
#Get the two days subset and convert date and time variables
sub_power <- subset(power, Date=="1/2/2007" | Date=="2/2/2007")
sub_power$DateTime <- strptime(paste(sub_power$Date, sub_power$Time), format="%d/%m/%Y %H:%M:%S")

#Plot to png
png(filename = "plot2.png", width = 480, height = 480)
plot(sub_power$DateTime, sub_power$Global_active_power,
     type="l",
     xlab="",
     ylab="Global Active Power (kilowatts)")
dev.off()
