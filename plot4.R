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
png(filename = "plot4.png", width = 480, height = 480)
par(mfrow=c(2,2))
#Plot1
plot(sub_power$DateTime, sub_power$Global_active_power,
     type="l",
     xlab="",
     ylab="Global Active Power")
#Plot2
plot(sub_power$DateTime, sub_power$Voltage,
     type="l",
     xlab="datetime",
     ylab="Voltage")
#Plot3
plot(sub_power$DateTime, sub_power$Sub_metering_1,
     type="l",
     col="black",
     xlab="",
     ylab="Energy sub metering")
lines(sub_power$DateTime, sub_power$Sub_metering_2, col="red")
lines(sub_power$DateTime, sub_power$Sub_metering_3, col="blue")
legend("topright",
       lty=1,
       bty="n",
       col=c("black", "red", "blue"),
       legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
#Plot4
plot(sub_power$DateTime, sub_power$Global_reactive_power,
     type="l",
     xlab="datetime",
     ylab="Global_reactive_power")
dev.off()
