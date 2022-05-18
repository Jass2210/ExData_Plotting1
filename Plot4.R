#loading libraries
library(data.table)
library(dplyr)
library(tibble)

dat <- fread('household_power_consumption.txt', na.strings = c('?')) %>% filter(Date =='1/2/2007' | Date == '2/2/2007')

#opening device
png(file = 'plot4.png')

#adding column with date and time information in the dataframe
date_with_time <- strptime(paste(dat$Date,dat$Time), format = '%d/%m/%Y %H:%M:%S')
dat <- add_column(dat,Date_with_time = date_with_time, .after = 'Time')

#plot
par(mfrow = c(2,2))
#first plot
plot(dat$Date_with_time, dat$Global_active_power, type = 'l', ylab = 'Global Active Power (kilowatts)', xlab = '')
#second plot
plot(dat$Date_with_time, dat$Voltage, type = 'l', ylab = 'Voltage', xlab = 'datetime')
#third plot
plot(dat$Date_with_time, dat$Sub_metering_1, type = 'n', xlab = '', ylab = 'Energy sub metering' )
points (dat$Date_with_time, dat$Sub_metering_1, type = 'l', col= 'black')
points(dat$Date_with_time, dat$Sub_metering_2, type = 'l', col = 'red')
points(dat$Date_with_time, dat$Sub_metering_3, type = 'l', col = 'blue')
legend('topright', lty =1,col = c('black', 'red', 'blue'), legend = c('Sub_metering_1', 'Sub_metering_2', 'Sub_metering_3'))
#last plot
plot(dat$Date_with_time, dat$Global_reactive_power, type = 'l', ylab = 'Global_reactive_power', xlab = 'datetime')

#closing device
dev.off()
