#####################################################
## PLOT 1
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

	## ALTERNATE IMPORT METHOD -- SKIP ROWS ---------------------------------------------------
	## headers <- read.table("household_power_consumption.txt", nrows = 1, header = FALSE, sep = ";") ## headers
	## mydata <- read.table("household_power_consumption.txt", header = FALSE, sep =";", skip = 66637, nrows = 2880) ##, colClasses = c("date","time",rep("factor",6),"numeric"))
	## colnames( mydata ) <- unlist(headers)
	## END ALTERNATE METHOD ---------------------------------------------------------------------

	## CHECK IMPORT
		ncol(mydata)  ## should be 9 columns
		nrow(mydata)  ## should be 2,880 rows
		head(mydata)
		str(mydata)

## 2. CHANGE TO DATETIME
	mydata$Date <- as.Date(mydata$Date, format="%d/%m/%Y")
	mydata$DateTime <- strptime(paste(mydata[,1],mydata[,2], sep=" "), format="%Y-%m-%d %T")
	str(mydata)

## 3. PLOT TO PNG
	png(file="plot1.png", width=480, height=480)
	hist(mydata$Global_active_power, col = "red", main="Global Active Power", xlab="Global Active Power (kilowatts)")
	dev.off()