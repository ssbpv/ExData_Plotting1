# Week 1 Project for Exploratory Data Analysis (Coursera): Plot1
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

# for plot1.png: plots a histogram to reflect the example graph provided

hist(as.numeric(FinalData$Global_active_power)/500,col="red",xlab="Global Active Power (kilowatts)",main="Global Active Power")
# copies to png file
dev.copy(png,"plot1.png",width = 480, height = 480)
# closes the bitmap device
dev.off()


        