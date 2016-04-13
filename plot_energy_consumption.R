## Calling this function plot_energy_consumption routine will invoke the required functions to plot all graphs
## Setup the right path in setWorking_ExploratoryData_Assgn1 function before use
plot_energy_consumption <- function() {
        library(lubridate)
        library(data.table)
        library(dplyr)
        library(plyr)
        library("stringr")
        library(datasets)## plotting package
        setWorking_ExploratoryData_Assgn1()
        energy_consumption_data <- extract_data()
        plot1(energy_consumption_data)
        plot2(energy_consumption_data)
        plot3(energy_consumption_data)
        plot4(energy_consumption_data)
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

### Histogram of Global Active Power graph -- plot1
plot1 <- function (df) {
        plot_file_name="plot1.png"
        unlink(plot_file_name)
        pngfile = png(filename=plot_file_name)
        device_num <- dev.cur() 
        hist(df$Global_active_power,xlab ="Global Active Power (kilowatts)",col="red",main="")
        title (main="Global Active Power")
        dev.off(device_num)
}

### Line chart of Global Active Power graph vs Time -- plot2
plot2 <- function (df) {
        plot_file_name="plot2.png"
        unlink(plot_file_name)
        pngfile = png(filename=plot_file_name)
        device_num <- dev.cur() 
        plot(df$Time,df$Global_active_power,type="s",main="",xlab="", ylab ="Global Active Power (kilowatts)")
        dev.off(device_num)
}

### Line chart of Sub Meter 1,2,3 vs Time -- plot3
plot3 <- function (df) {
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

### Line chart of 4 charts -- plot4
plot4 <- function (df) {
        plot_file_name="plot4.png"
        unlink(plot_file_name)
        attach(df)
        pngfile = png(filename=plot_file_name)  
        par(mfrow=c(2,2))       ## par will set pngfile
        device_num <- dev.cur() 
        
        ## plot graph - Line chart of Global Active Power graph vs Time
        plot(df$Time,df$Global_active_power,type="s",main="",xlab="", ylab ="Global Active Power")
        
        ## plot graph - Line chart of Voltage graph vs Time
        plot(df$Time,df$Voltage,type="s",main="",xlab="datetime", ylab ="Voltage")
        
        ## plot Line chart of Sub Meter 1,2,3 vs Time
        plot(df$Time,df$Sub_metering_1,type="s", col="grey", main="",xlab="", ylab ="Energy sub metering")
        lines(df$Time,df$Sub_metering_2,type="s", col="red")
        lines(df$Time,df$Sub_metering_3,type="s", col="blue")
        legend("topright", border = "white" , lty=c(1,1,1), col = c("grey","red","blue"), legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3" ))
        
        ## plot Line chart of Global Reactive Power vs Time
        plot(df$Time,df$Global_reactive_power,type="s",main="",xlab="datetime", ylab ="Global_reactive_power")
        
        dev.off(device_num)
}

setWorking_ExploratoryData_Assgn1 <- function() {
        homedir <- "D:/Users/Koo Wee Leong/My Documents/My Education/Coursera/Data Science - John Hopkins/R-Workspace/Exploratory Data Analysis - Programming Assignment 1/"
        setwd(homedir)       
}

clearMemory <- function() {
        rm(list = ls())
}
