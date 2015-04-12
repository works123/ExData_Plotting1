## plots Plot3 and create the Plot3.png

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
png(file = "Plot4.png", bg = "transparent",width = 480, height = 480)

##setup plot with 2 rows 2 columns and set marning ane outer margin

par(mfrow =c(2,2), mar =c (4,4,2,1), oma = c(0,0,2,0))

with(data,{
        
        ##Plot graph - Plot 1 on Row 1, col 1
        plot(Time,Global_active_power,ylab = "Global Active Power", type="n" , xlab="")
        lines(Time,Global_active_power)
        
        ##Plot graph - Plot 2  on Row 2, col 1
        plot(Time,Voltage ,ylab = "Voltage", type="n", xlab="datetime")
        lines(Time,Voltage)
     
        ##Plot graph - Plot 3  on Row 1, col 2
        plot(Time, Sub_metering_1,type="n",ylab = "Energy Sub Metering", xlab="")
        lines(Time,Sub_metering_1,col="black")
         lines(Time,Sub_metering_2,col="red")
        lines(Time,Sub_metering_3,col="blue")

       legend("topright",col=c("black","red","blue"),lwd=1,bty="n", legend = c("Sub_Metering_1","Sub_Metering_2","Sub_Metering_3"))

        ##Plot graph - Plot 4  on Row 2, col 2
        plot(Time,Global_reactive_power , type="n", xlab="datetime")
        lines(Time,Global_reactive_power )
})


##Close PNG device
dev.off() 
