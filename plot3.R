### Line chart of Sub Meter 1,2,3 vs Time -- plot3
## Break up plot_energy_consumption as required by assignment. 
## Setup the right path in setWorking_ExploratoryData_Assgn1 function before use
plot3  <- function () {
        library(lubridate)
        library(data.table)
        library(dplyr)
        library(plyr)
        library("stringr")
        library(datasets)## plotting package
        setWorking_ExploratoryData_Assgn1()
        df <- extract_data()
        
        plot_file_name="plot3.png"
        unlink(plot_file_name)
        pngfile = png(filename=plot_file_name)
        device_num <- dev.cur() 
        plot(df$Time,df$Sub_metering_1,type="s", col="grey", main="",xlab="", ylab ="Energy sub metering")
        lines(df$Time,df$Sub_metering_2,type="s", col="red")
        lines(df$Time,df$Sub_metering_3,type="s", col="blue")
        legend("topright", lty=c(1,1,1), col = c("grey","red","blue"), legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3" ))
        dev.off(device_num)
        
}

## Read all data into a dataframe
extract_data <- function() {
        data_table <- read.table("./household_power_consumption.txt",sep = ";", header = TRUE, stringsAsFactors = FALSE, na.strings = "?")
        ## Convert "Date" char column to Date format 
        ##data_table$Date <- as.Date(data_table$Date,"%d/%m/%y")
        ##data_table$Time <- strptime(data_table$Time, "%T")
        
        data_table$Time <- dmy_hms(paste(data_table$Date,data_table$Time))
        data_table$Date <- dmy(data_table$Date)
        ##data_table$Date <- as.Date(data_table$Date,"%d/%m/%Y")
        
        frDate <- as.POSIXct('2007-02-01 00:00')
        toDate <- as.POSIXct('2007-02-03 00:00')
        
        ##We will only be using data from the dates 2007-02-01 and 2007-02-02 
        subset(data_table, Date >= frDate & Date < toDate)
}

setWorking_ExploratoryData_Assgn1 <- function() {
        homedir <- "D:/Users/Koo Wee Leong/My Documents/My Education/Coursera/Data Science - John Hopkins/R-Workspace/Exploratory Data Analysis - Programming Assignment 1/"
        setwd(homedir)       
}

clearMemory <- function() {
        rm(list = ls())
}