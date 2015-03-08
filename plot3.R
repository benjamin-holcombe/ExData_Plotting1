## Download File ####
fileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileURL, destfile = "./PowerConsumption.zip")
unzip("PowerConsumption.zip")

## Read File ####
pcfile <- "household_power_consumption.txt"
pcRAW <- read.table(pcfile, header=TRUE, sep = ";")

## Subset the Data Frame ####
pcSub <- pcRAW[as.Date(strptime(pcRAW$Date, "%d/%m/%Y")) %in% as.Date(c('2007-02-01', '2007-02-02')),]

## Convert Date and Time Columns ####
DateTime <- data.frame(DateTime = strptime(paste(pcSub$Date, pcSub$Time), "%d/%m/%Y %H:%M:%S"))
Date <- data.frame(Date = as.Date(strptime(pcSub$Date, "%d/%m/%Y")))
Global_active_power <- as.numeric(as.character(pcSub$Global_active_power))
Global_reactive_power <- as.numeric(as.character(pcSub$Global_reactive_power))
Voltage <- as.numeric(as.character(pcSub$Voltage))
Global_intensity <- as.numeric(as.character(pcSub$Global_intensity))
Sub_metering_1 <- as.numeric(as.character(pcSub$Sub_metering_1))
Sub_metering_2 <- as.numeric(as.character(pcSub$Sub_metering_2))
Sub_metering_3 <- as.numeric(as.character(pcSub$Sub_metering_3))

## Convert Numerical Columns ####
pc <- cbind(DateTime,Date
            ,Global_active_power
            ,Global_reactive_power
            ,Voltage
            ,Global_intensity
            ,Sub_metering_1
            ,Sub_metering_2
            ,Sub_metering_3)

## Construct the Plot ####
png("plot3.png",width = 480, height = 480)
plot(pc$DateTime, pc$Sub_metering_1, type="l", xlab="", ylab="Energy sub metering")
lines(pc$DateTime, pc$Sub_metering_2, type="l", col = "red")
lines(pc$DateTime, pc$Sub_metering_3, type="l", col = "blue")
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lwd=1, col = c("black", "red", "blue"))
dev.off()
