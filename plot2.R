
### Line chart of Global Active Power graph vs Time -- plot2
## Break up plot_energy_consumption as required by assignment. 
## Setup the right path in setWorking_ExploratoryData_Assgn1 function before use
plot2 <- function () {
        library(lubridate)
        library(data.table)
        library(dplyr)
        library(plyr)
        library("stringr")
        library(datasets)## plotting package
        setWorking_ExploratoryData_Assgn1()
        df <- extract_data()

        plot_file_name="plot2.png"
        unlink(plot_file_name)
        pngfile = png(filename=plot_file_name)
        device_num <- dev.cur() 
        plot(df$Time,df$Global_active_power,type="s",main="",xlab="", ylab ="Global Active Power (kilowatts)")
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