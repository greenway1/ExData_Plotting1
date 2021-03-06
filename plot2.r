#####################################################
## PLOT 2
##
## 1. Import only the data from
##		2007-02-01 and 2007-02-02
##
## 2. Change format to DateTime
##
## 3. Open png file and plot to file


library(sqldf) ## include sqldf library for loading only select rows
setwd("~/R/R_Assign/Exploratory/power") 

## 1. IMPORT DATA
	wp <- file("household_power_consumption.txt") ## set file for import
	attr(wp, "file.format") <- list(sep = ";", header = TRUE) ## attributes of the import file

	# use sqldf to read it in keeping only indicated rows
	mydata <- sqldf("select * from wp where wp.Date = '1/2/2007' OR wp.Date = '2/2/2007'")

	## CHECK IMPORT
		ncol(mydata)  ## should be 9 columns
		nrow(mydata)  ## should be 2,880 rows
		str(mydata)

## 2. CHANGE TO DATETIME
	mydata$Date <- as.Date(mydata$Date, format="%d/%m/%Y")
	mydata$DateTime <- strptime(paste(mydata[,1],mydata[,2], sep=" "), format="%Y-%m-%d %T")
	str(mydata)

## 3. PLOT TO PNG
	png(file="plot2.png", width=480, height=480)
	plot(mydata$DateTime, mydata$Global_active_power, type="n", ylab="Global Active Power (kilowatts)", xlab="")
	lines(mydata$DateTime, mydata$Global_active_power)
	dev.off()