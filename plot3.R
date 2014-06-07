##Read data & set tidy column names
FullPower <-read.table("household_power_consumption.txt", header = TRUE, sep = ";")
colnames(FullPower) <- c("Date","Time","Active","Reactive","Voltage","Intensity","SubMeter1","SubMeter2","SubMeter3")
##Subset data by date, merge date and time
FullPower$Date <- as.Date(FullPower$Date, format="%d/%m/%Y")
Power <- subset(FullPower, Date == "2007-02-01" | Date == "2007-02-02")
Power$datetime <- paste(Power$Date, Power$Time)
Power$datetime <- strptime(Power$datetime, "%Y-%m-%d %H:%M:%S")
##Open graphic device and plot data
png(filename="plot3.png", width=480, height=480)
with(Power, {
    plot(datetime, as.numeric(as.character(SubMeter1)),type="l", xlab="", ylab="Energy sub metering")
    lines(datetime, as.numeric(as.character(SubMeter2)),type="l", col="red")
    lines(datetime, as.numeric(as.character(SubMeter3)),type="l", col="blue")
})
legend("topright", col = c("black","red","blue"), legend = c("Sub_metering_1", "Sub_metering_2","Sub_metering_3"), lwd=1)
dev.off()
