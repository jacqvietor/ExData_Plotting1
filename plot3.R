# program project1 - Exploratory Data Analysis - creates plot3
# Date 15-05-2016


## read data from file all_data.txt
##  all_data.txt contains the extracted data of exdata_data_household_poer_consumption.zip
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
## 1. Sub_metering_1
dt_select$sub1_char <- as.character(dt_select$Sub_metering_1)
dt_select$sub1_num <- as.numeric(dt_select$sub1_char)
## 2. Sub_metering_2
dt_select$sub2_char <- as.character(dt_select$Sub_metering_2)
dt_select$sub2_num <- as.numeric(dt_select$sub2_char)


## plot 3
png(filename = "./plot3.png",width = 480, height = 480, units = "px", pointsize = 12, bg = "white", res = NA)
plot(dt_select$DateTime,dt_select$sub1_num,type="n",xlab = "", ylab="Energy sub metering")
lines(dt_select$DateTime,dt_select$sub1_num, col="black")
lines(dt_select$DateTime,dt_select$sub2_num, col="red")
lines(dt_select$DateTime,dt_select$Sub_metering_3, col="blue")
legend("topright",lwd=c(2,2,2),col=c("black","red","blue"),legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))
dev.off()
dev.cur()


