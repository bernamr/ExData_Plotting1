library(date)
library(lubridate)
library(data.table)


if(!file.exists('data.zip')){
  url<-"http://archive.ics.uci.edu/ml/machine-learning-databases/00235/household_power_consumption.zip"
  
  download.file(url,destfile = "data.zip")
}

unzip("data.zip")

my_data <- read.table("household_power_consumption.txt", 
                      header = TRUE, na.strings = "?", sep=";")
my_data <- na.omit(my_data)


my_data$Date <- dmy(my_data$Date)


final_data <- subset(my_data, Date >=dmy("01/02/2007") & Date <=dmy("02/02/2007"))


dateTime <- paste(final_data$Date, final_data$Time)
dateTime<-as.POSIXct(dateTime)




final_data <- final_data[ , !names(final_data) %in% c("Date", "Time")]

final_data <- cbind(dateTime, final_data)
final_data$Global_active_power<-as.numeric(final_data$Global_active_power)


plot1 <- hist(final_data$Global_active_power, main="Global Active Power", 
              xlab = "Global Active Power (kilowatts)", col="red")

dev.copy(png,"plot1.png", width=480, height=480)
dev.off()