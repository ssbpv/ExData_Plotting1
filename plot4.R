# Week 1 Project for Exploratory Data Analysis (Coursera): Plot4

rm(list=ls()) # clears variables in the environment
library(dplyr)



#fileURL has the url for the zip file to be downloaded for the assignment or the filepath for the zip file in your folder
fileURL<-"https://archive.ics.uci.edu/ml/machine-learning-databases/00235/household_power_consumption.zip"
#download the file to the working directory and unzip it
download.file(fileURL,dest="EDAProj1.zip", mode="wb")


# dataURL contains the file path for each of the files in their respective subfolder
dataURL<-unzip ("EDAProj1.zip")

# reads the data in the text file into R
dataPowerCons<-read.table(dataURL,header = TRUE,sep=";") 

# to convert  Date and Time variables to Date/Time classes
# I used paste so that the dates from the data set are used otherwise strptime uses the current date
DateTime<-strptime(paste(dataPowerCons$Date,dataPowerCons$Time),"%d/%m/%Y %H:%M:%S")
dataPowerCons$Date<-as.Date(as.character(dataPowerCons$Date),"%d/%m/%Y")

# the next step removes the "Time" column and column binds the "DateTime" variable in the POSIXlt class 
subData<-select(dataPowerCons,-Time)
TestData<-cbind.data.frame(DateTime,subData)

# This step selects the data between 2007-02-01 and 2007-02-02

FinalData<-filter(TestData,Date>="2007-02-01" & Date<= "2007-02-02")

# for plot4.png: plots multiple line data to reflect the example graph provided

par(mfrow=c(2,2)) # creates plot with 2 columns and 2 rows
 with(FinalData,plot(DateTime,as.numeric(Global_active_power),xlab="",ylab="Global Active Power (kilowatts)",pch=NA))
 with(FinalData,lines.default(DateTime,as.numeric(Global_active_power)))
 with(FinalData,plot(DateTime,as.numeric(Voltage),ylab="Voltage",pch=NA))
 with(FinalData,lines.default(DateTime,as.numeric(Voltage)))
 with(FinalData,plot(DateTime,as.numeric(Sub_metering_1),xlab="",ylab="Energy sub metering",pch=NA))
 with(FinalData,lines(DateTime,as.numeric(Sub_metering_1)))
 with(FinalData,lines(DateTime,as.numeric(Sub_metering_2),col="red"))
 with(FinalData,lines(DateTime,as.numeric(Sub_metering_3),col="blue"))
 legend("topright", lwd = 1, col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2","Sub_metering_3"),text.font = 2,text.width = strwidth("Sub_metering_1         "))
 
 with(FinalData,plot(DateTime,as.numeric(Global_reactive_power),ylab="Global_reactive_power",pch=NA))
 with(FinalData,lines.default(DateTime,as.numeric(Global_reactive_power)))

 dev.copy(png,"plot4.png",width = 480, height = 480)
 dev.off()