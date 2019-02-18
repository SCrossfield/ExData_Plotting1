# Exploratory Data Analysis
# Course Project 1, Plot 4

#create a project folder and set to it
if(!file.exists("Project1")) {dir.create("Project1")}
setwd("./Project1")

# Read in the data (download, unzip and read)
webUrl<-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(webUrl, destfile="./Project1/household.zip", method="wininet")
zipF<-"./household.zip"
outDir<-"./householdData"
unzip(zipF, exdir=outDir)
mydata<-read.table("./householdData/household_power_consumption.txt",
                   nrows=69518, na.strings="?",
                   sep=";", header=T) #stop reading after 3.2.2007, convert ? to NA

#take the subset, 1-2 Feb 2007 to work with
mySubset<-subset(mydata, mydata$Date == "1/2/2007" | mydata$Date == "2/2/2007")
head(mySubset)
summary(mySubset)

#load the graphics packages
library(graphics)
library(grDevices)

#prepare the datetime format for the plot x axis
dateTime<- strptime(paste(mySubset$Date, mySubset$Time, sep=" "), "%d/%m/%Y %H:%M:%S")

#make plot 4 in png (480 * 480)
png("plot4.png", width=480, height=480, units="px") #making the png first, so the legend fits

#make a 2*2 plot
par(mfcol=c(2,2))

#make the 4 plots
plot(dateTime, as.numeric(mySubset$Global_active_power), type = "l", xlab="",
     ylab="Global Active Power")

plot(dateTime, as.numeric(mySubset$Sub_metering_1), type="l", xlab="", 
     col="black", ylab="Energy sub metering")
points(dateTime, as.numeric(mySubset$Sub_metering_2), type="l", col="red")
points(dateTime, as.numeric(mySubset$Sub_metering_3), type="l", col="blue")
legend("topright", lty=1, lwd=1, col=c("black", "red", "blue"), 
       legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
       bty="n", cex=0.9)
plot(dateTime, as.numeric(mySubset$Voltage), type="l", xlab="datetime", ylab="Voltage")
plot(dateTime, as.numeric(mySubset$Global_reactive_power), type="l", xlab="datetime",
     ylab="Global_reactive_power")

dev.off() #close the png 
