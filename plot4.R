##Read data & set tidy column names
FullPower <-read.table("household_power_consumption.txt", header = TRUE, sep = ";")
colnames(FullPower) <- c("Date","Time","Active","Reactive","Voltage","Intensity","SubMeter1","SubMeter2","SubMeter3")
##Subset data by date, merge date and time
FullPower$Date <- as.Date(FullPower$Date, format="%d/%m/%Y")
Power <- subset(FullPower, Date == "2007-02-01" | Date == "2007-02-02")
Power$datetime <- paste(Power$Date, Power$Time)
Power$datetime <- strptime(Power$datetime, "%Y-%m-%d %H:%M:%S")
##Open graphic device and plot data
png(filename="plot4.png", width=480, height=480)
##create structure for plots
par(mfcol=c(2,2))
##1st plot
plot(Power$datetime, as.numeric(as.character(Power$Active)), type="l", xlab="", ylab="Global Active Power")
##2nd plot
with(Power, {
    plot(datetime, as.numeric(as.character(SubMeter1)),type="l", xlab="", ylab="Energy sub metering")
    lines(datetime, as.numeric(as.character(SubMeter2)),type="l", col="red")
    lines(datetime, as.numeric(as.character(SubMeter3)),type="l", col="blue")
})
legend("topright",bty = "n",col = c("black","red","blue"), legend = c("Sub_metering_1", "Sub_metering_2","Sub_metering_3"), lwd=1)
##3rd plot
plot(Power$datetime, as.numeric(as.character(Power$Voltage)), type="l", xlab="datetime", ylab="Voltage")
##4th plot
plot(Power$datetime, as.numeric(as.character(Power$Reactive)), type="l", xlab="datetime", ylab="Global_reactive_power")
##close device
dev.off()
