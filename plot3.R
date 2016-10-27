myfile="household_power_consumption.txt"

#Reads file lines
Lines<-readLines(myfile)

#Selects the dates 2007-02-01 and 2007-02-02
mylines<-grep("^[12]/2/2007",Lines)

#Reads in dataframe
mydata<-read.table(text=Lines[mylines],header=TRUE,sep=";",na.strings = "?")

#Assigns column names
colnames(mydata)<-strsplit(Lines[1],";")[[1]]

library(lubridate)
library(dplyr)

#Sets locale to English (if it is not the default language)
Sys.setlocale("LC_TIME", "C")

#Adds a column with the merging of date and time
mydata<-mutate(mydata,DateTime=dmy_hms(paste(Date,Time)))

#Opens png device
png("plot3.png")

#Draws empty plot
with(mydata,plot(DateTime,Sub_metering_1,type="n",ylab="Energy sub metering",xlab=""))

#Draws the line of Sub_metering_1 data
with(mydata,lines(DateTime,Sub_metering_1,col="black"))

#Draws the line of Sub_metering_2 data
with(mydata,lines(DateTime,Sub_metering_2,col="red"))

#Draws the line of Sub_metering_3 data
with(mydata,lines(DateTime,Sub_metering_3,col="blue"))

#Draws legend
legend("topright",col = c("black","red","blue"),legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),lty=c(1,1,1))

#Closes png device
dev.off()