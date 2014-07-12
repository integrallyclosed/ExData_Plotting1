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

# Open a PNG device
png(filename = 'plot1.png', width = 480, height = 480)

# Construct the histogram
hist(household_power_subset$Global_active_power, col='Red', xlab='Global Active Power (kilowatts)', ylab='Frequency', main='Global Active Power')

# Close the graphics device
dev.off()