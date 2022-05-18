#loading libraries
library(data.table)
library(dplyr)
library(tibble)

dat <- fread('household_power_consumption.txt', na.strings = c('?')) %>% filter(Date =='1/2/2007' | Date == '2/2/2007')

#opening device
png(file = 'plot2.png')

#adding column with date and time information in the dataframe
date_with_time <- strptime(paste(dat$Date,dat$Time), format = '%d/%m/%Y %H:%M:%S')
dat <- add_column(dat,Date_with_time = date_with_time, .after = 'Time')

#plot
plot(dat$Date_with_time, dat$Global_active_power, type = 'l', ylab = 'Global Active Power (kilowatts)', xlab = '')

#closing device
dev.off()
