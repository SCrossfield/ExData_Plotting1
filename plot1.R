# Exploratory Data Analysis
# Course Project 1, Plot 1

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

#make plot 1
hist(mySubset$Global_active_power, main="Global Active Power",
     xlab="Global Active Power (kilowatts)", col="red")

#save to a PNG file with a width of 480 pixels and a height of 480 pixels
dev.copy(png, file="plot1.png", width=480, height=480, units="px")
dev.off() #close the png 
