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
#Get the two days subset
#No need to convert dates (not used)
sub_power <- subset(power, Date=="1/2/2007" | Date=="2/2/2007")

#Plot to png
png(filename = "plot1.png", width = 480, height = 480)
hist(sub_power$Global_active_power,
     main="Global Active Power",
     xlab = "Global Active Power (kilowatts)",
     col="red")
dev.off()
