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
mydata<-mutate(mydata,datetime=dmy_hms(paste(Date,Time)))

#Opens png device
png("plot4.png")
par(mfrow = c(2, 2))
with(mydata,{
        #Plot1
        plot(datetime,Global_active_power,type="n",ylab="Global Active Power",xlab="")
        lines(datetime,Global_active_power)
        
        #Plot2
        plot(datetime,Voltage,ylab="Voltage",xlab="datetime",type="n")
        lines(datetime,Voltage)
        
        #Plot3
        plot(datetime,Sub_metering_1,type="n",ylab="Energy sub metering",xlab="")
        lines(datetime,Sub_metering_1,col="black")
        lines(datetime,Sub_metering_2,col="red")
        lines(datetime,Sub_metering_3,col="blue")
        legend("topright",col = c("black","red","blue"),legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),lty=c(1,1,1), bty = "n")
        
        #Plot4
        plot(datetime,Global_reactive_power,type="n")
        lines(datetime,Global_reactive_power)
        
        
})

#Closes png device
dev.off()