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
png("plot2.png")

#Draws empty plot
with(mydata,plot(DateTime,Global_active_power,type="n",ylab="Global Active Power (kilowatts)",xlab=""))

#Draws the line of Global_active_power data
with(mydata,lines(DateTime,Global_active_power))

#Closes the png device
dev.off()