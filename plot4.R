# Download the household power consumption zip file
download.file(url='https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip', destfile='household_power_consumption.zip', method='curl')

# Unzip the file
unzip('household_power_consumption.zip')

# Read the data from the household power consumption file into a data frame. 
household_power <- read.table('household_power_consumption.txt', sep=';', header=T, stringsAsFactors=F)

# Convert the Date column to the Date data type
household_power$Date <- as.Date(household_power$Date, '%d/%m/%Y')

# Subset the data frame to contain only entries from the two day period 2007-02-01 and 2007-02-02
lower_date = as.Date('01/02/2007', '%d/%m/%Y')
upper_date = as.Date('02/02/2007', '%d/%m/%Y')
household_power_subset <- household_power[household_power$Date == lower_date | household_power$Date == upper_date, ]

# Convert the Global_active_power column to numeric
household_power_subset$Global_active_power <- as.numeric(household_power_subset$Global_active_power)

# Convert the Time column to POSIXlt
household_power_subset$Time <- strptime(paste(household_power_subset$Date, household_power_subset$Time, sep = ' '), 
                                        format='%Y-%m-%d %H:%M:%S')

# Open a PNG device
png(filename = 'plot4.png', width = 480, height = 480)

par(mfcol=c(2,2))
plot(household_power_subset$Time, household_power_subset$Global_active_power, type='l', 
     ylab='Global Active Power', xlab='')
plot(household_power_subset$Time, household_power_subset$Sub_metering_1, type='l', 
     ylab='Energy sub metering', xlab='')
points(household_power_subset$Time, household_power_subset$Sub_metering_2, type='l', 
       ylab='Energy sub metering', xlab='', col='red')
points(household_power_subset$Time, household_power_subset$Sub_metering_3, type='l', 
       ylab='Energy sub metering', xlab='', col='blue')
legend('topright', c('Sub_metering_1', 'Sub_metering_2', 'Sub_metering_3'), 
       lty=1, col=c('black', 'red', 'blue'), bty='n')
plot(household_power_subset$Time, household_power_subset$Voltage, type='l', 
     ylab='Voltage', xlab='datetime')
plot(household_power_subset$Time, household_power_subset$Global_reactive_power, type='l', 
     ylab='Global_reactive_power', xlab='datetime')

# Close the graphics device
dev.off()
