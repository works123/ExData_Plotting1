## plots Plot2 and create the Plot2.png

##get dataset
getData <- function(){
        
        if(!file.exists("household_power_consumption.txt")) {
                ##download and unzip file into current workind directory
                download.file(url="https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",destfile="ElecticPowerConsumption.zip", method="auto")
                unzip("ElecticPowerConsumption.zip",exdir=".",overwrite = TRUE )
        }    
        
        ##get dataset
        household_power_consumption  <- read.table("household_power_consumption.txt",header=TRUE,sep=";",quote="", na.strings="?" )
        
        
        ##remove missing fields observations
        household_power_consumption_complete <- household_power_consumption[complete.cases(household_power_consumption),]
        
        ##Convert Date Column  to Date Type 
        household_power_consumption_complete$Date <- as.Date(household_power_consumption_complete$Date,"%d/%m/%Y")
        
        ##Convert Time Column  to POSIXlt and POSIXct Type
        household_power_consumption_complete$Time <- strptime(paste(household_power_consumption_complete$Date, household_power_consumption_complete$Time,sep=" "), "%Y-%m-%d %H:%M:%S")
        
        ##data from the dates 2007-02-01 and 2007-02-02.
        household_consumptionFiltered <-household_power_consumption_complete[which(household_power_consumption_complete$Date>="2007-02-01" &  household_power_consumption_complete$Date<="2007-02-02"),]
        
        household_consumptionFiltered 
        
}

##Main Program
##get the data to plot
data <- getData()

##Construct a png file
png(file = "Plot2.png", bg = "transparent",width = 480, height = 480)

##Plot graph - Plot 2
plot(data$Time, data$Global_active_power,type="n",ylab = "Global Active Power (kilowatts)",xlab="")
lines(data$Time, data$Global_active_power)

##Close PNG device
dev.off()  
        



