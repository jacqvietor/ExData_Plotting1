# program project1 - Exploratory Data Analysis - creates plot4
# Date 15-05-2016


## read data from file all_data.txt
##  all_data.txt contains the extracted data of exdata_data_household_power_consumption.zip
alldata <- read.table("all_data.txt", header=TRUE, sep=';')

## Concatenate Date and Time into new variable DateTimeString
alldata$DateTimeString <- paste(alldata$Date,alldata$Time,sep=" ")

## Convert DateTimeString to POSIXlt format
alldata$DateTime <- strptime(alldata$DateTimeString,"%d/%m/%Y %H:%M:%S")

## create new date variable $Dt that contains the measurement date in format yyyymmdd
alldata$Dt <- format(alldata$DateTime,"%Y%m%d")

## only records from date 01/02/2007 and 02/02/2007 need to be included in the plots
## create boolean var that indicates if Date = "20070201" or date = "20070202"
dates_ok <- alldata$Dt=="20070201" | alldata$Dt=="20070202"

## create dt_select which contains only the records with the correct dates
dt_select <- alldata[dates_ok,]

## print the number of records with date "20070201" or date = "20070202"
nrow(dt_select)

##  Change the datatype of the following 4 variables from Factor to numeric (via char - it does not work dirtectly from Factor to numeric)
## 1. Global_active_power
dt_select$gap_char <- as.character(dt_select$Global_active_power)
dt_select$gap_num <- as.numeric(dt_select$gap_char)
## 2. Sub_metering_1
dt_select$sub1_char <- as.character(dt_select$Sub_metering_1)
dt_select$sub1_num <- as.numeric(dt_select$sub1_char)
## 3. Sub_metering_2
dt_select$sub2_char <- as.character(dt_select$Sub_metering_2)
dt_select$sub2_num <- as.numeric(dt_select$sub2_char)
## 4. Voltage
dt_select$volt_char <- as.character(dt_select$Voltage)
dt_select$volt_num <- as.numeric(dt_select$volt_char)
## 5. Global_reactive_power
dt_select$grp_char <- as.character(dt_select$Global_reactive_power)
dt_select$grp_num <- as.numeric(dt_select$grp_char)

## plot 4
png(filename = "./plot4.png",width = 480, height = 480, units = "px", pointsize = 11, bg = "white", res = NA)
par(mfrow=c(2,2), mar=c(7,6,3,2))
# upper-left plot: plot 2 re-use with slight modification
plot(dt_select$DateTime,dt_select$gap_num,type="n",xlab = "", ylab="Global Active Power", cex.lab=1.0)
lines(dt_select$DateTime,dt_select$gap_num)
# upper-right plot: create plot DateTime vs Voltage
plot(dt_select$DateTime,dt_select$volt_num,type="n",xlab = "datetime", ylab="Voltage",cex.lab=1.0)
lines(dt_select$DateTime,dt_select$volt_num)
# lower-left plot: plot 3 re-use with slight modification
plot(dt_select$DateTime,dt_select$sub1_num,type="n",xlab = "", ylab="Energy sub metering",cex.lab=1.0)
lines(dt_select$DateTime,dt_select$sub1_num, col="black")
lines(dt_select$DateTime,dt_select$sub2_num, col="red")
lines(dt_select$DateTime,dt_select$Sub_metering_3, col="blue")
legend("topright", inset=0.05, lwd=c(2,2,2),col=c("black","red","blue"),legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),cex=0.8, box.lty=0)
# lower-right plot: 
# create plot DateTime vs Global reactive power
plot(dt_select$DateTime,dt_select$grp_num,type="n",xlab = "datetime", ylab="Global_reactive_power", cex.lab=1.0)
lines(dt_select$DateTime,dt_select$grp_num)
dev.off()



