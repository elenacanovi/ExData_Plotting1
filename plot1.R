myfile="household_power_consumption.txt"

#Reads file lines
Lines<-readLines(myfile)

#Selects the dates 2007-02-01 and 2007-02-02
mylines<-grep("^[12]/2/2007",Lines)

#Reads in dataframe
mydata<-read.table(text=Lines[mylines],header=TRUE,sep=";",na.strings = "?")

#Assigns column names
colnames(mydata)<-strsplit(Lines[1],";")[[1]]

#Opens png device
png("plot1.png")

#Draws histogram
hist(mydata$Global_active_power,col="red",xlab = "Global Active Power (kilowatts)", ylab="Frequency",main = "Global Active Power")

#Closes the png device
dev.off()