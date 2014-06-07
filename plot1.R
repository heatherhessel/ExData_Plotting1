##Read data & set tidy column names
FullPower <-read.table("household_power_consumption.txt", header = TRUE, sep = ";")
colnames(FullPower) <- c("Date","Time","Active","Reactive","Voltage","Intensity","SubMeter1","SubMeter2","SubMeter3")
##Subset data by date, merge date and time
FullPower$Date <- as.Date(FullPower$Date, format="%d/%m/%Y")
Power <- subset(FullPower, Date == "2007-02-01" | Date == "2007-02-02")
Power$datetime <- paste(Power$Date, Power$Time)
Power$datetime <- strptime(Power$datetime, "%Y-%m-%d %H:%M:%S")
##Open graphic device and plot data
png(filename="plot1.png", width=480, height=480)
hist(as.numeric(as.character(Power$Active)), breaks = 12, col="red", yaxt="n", xlab="Global Active Power (kilowatts)", main="Global Active Power")
axis(2, at = seq(0, 1200, by = 200), las=2)
dev.off()
