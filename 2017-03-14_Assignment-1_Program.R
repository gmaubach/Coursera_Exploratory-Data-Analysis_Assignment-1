#!/usr/bin/Rscript –vanilla
#-----------------------------------------------------------
# Project     : Coursera - Exploratory Data Analysis
#               Week 1 - Programming Assignment 1
# Organisation:
# Department  :
# Author      : Georg Maubach
# Contributors:
# Date        : 2017-03-15
# Update      : 2017-03-15
#
# Copyright (C) 2017, Georg Maubach
# All rights reserved.
#-----------------------------------------------------------

# Ressources:
# - https://www.r-bloggers.com/opening-large-csv-files-in-r/
# - https://www.r-bloggers.com/importing-data-into-r-part-two/
# - https://stat.ethz.ch/pipermail/r-help/2007-August/138323.html

cat("===================================================\n")
cat("#= [ Module ]: Coursera_Explore-Data_Assignment-1.R\n")
cat("===================================================\n")

cat("#= [ Configuration ] ==============================\n")

# Required packages to read data
if (require(dtplyr) == FALSE)
{
  try(
    install.packages(
      "dtplyr",
      dependencies = TRUE,
      type = "source"))  # on Linux

  try(
    install.packages(
      "dtplyr",
      dependencies = TRUE,
      type = "binary"))  # on Windows
}

# Set device units
dev.size(units = "px")

cat("#= [ Libraries ] ==================================\n")

library(dtplyr)

cat("#= [ Declarations ] ===============================\n")
cat("#- [ Constants ] ----------------------------------\n")
cat("#- [ Variables ] ----------------------------------\n")
cat("#- [ Functions ] ----------------------------------\n")
cat("#- [ Modules ] ------------------------------------\n")

source(
  paste0(
    "https://raw.githubusercontent.com/",
    "gmaubach/R-Project-Utilities/master/",
    "t_report_memory.R"))

cat("#= [ BEGIN ] ======================================\n")
cat("#  [ At First ] -----------------------------------\n")

base_dir <- getwd()
dir.create(
  file.path(
    base_dir,
    "temp"))
work_dir <- file.path(
  base_dir,
  "temp")

# Check memory
t_report_memory()

cat("#  [ Input ] --------------------------------------\n")

# Download and unzip data
if (!file.exists(
  file.path(
    work_dir,
    "household_power_consumption.txt")))
{
  download.file(
    url = paste0(
      "https://d396qusza40orc.cloudfront.net/",
      "exdata%2Fdata%2Fhousehold_power_consumption.zip"),
    destfile = file.path(
      work_dir,
      "downloaded_file.zip"))
  unzip(
    zipfile = file.path(
      work_dir,
      "downloaded_file.zip"),
    list = TRUE)
  unzip(
    zipfile = file.path(
      work_dir,
      "downloaded_file.zip"),
    exdir = file.path(
      work_dir))
}

# Switch warnings off temporarily cause
# fread bumps back to correct classes of columns.
save_opt_warn <- getOption("warn")
options(warn = -1)
ihepc <- data.table::fread(
  file = file.path(
    work_dir,
    "household_power_consumption.txt"))
options(warn = save_opt_warn)

cat('#  [ Processing ] ---------------------------------\n')
cat("#  [ Inspect ] ....................................\n")

# If anythings goes wrong re-create my_data from ihepc
my_data <- ihepc

str(my_data)
summary(my_data)

cat("#  [ Clean ] ......................................\n")

my_data$Date <- as.Date(my_data$Date, format = "%d/%m/%Y")
my_data <- my_data[my_data$Date >= as.Date("2007-02-01") &
                   my_data$Date <= as.Date("2007-02-02") , ]
table(my_data$Date)

my_data <- my_data[order(my_data$Date) , ]
my_data$time <- my_data$Time

cat("#  [ Prepare ] ....................................\n")

# Type conversion
my_numbers <- my_data %>%
  select(Global_active_power:Sub_metering_2) %>%
  mutate_each(funs(as.numeric))

# Copy variable without conversion
my_numbers$time <- my_data$Time
my_numbers$date <- my_data$Date
my_numbers$Sub_metering_3 <- my_data$Sub_metering_3

my_numbers$weekdays <- as.factor(weekdays(as.Date(my_data$Date)))
summary(my_numbers$weekdays)

my_numbers$datetime <- with(
  my_data,
  as.POSIXct(
    paste(Date, Time),
    format="%Y-%m-%d %H:%M"))

cat("#  [ Merge ] ......................................\n")
cat("#  [ Analyse ] ....................................\n")

cat("Plot 1 .......... \n")

png(
  filename = file.path(
    work_dir,
    "plot1.png"),
  width = 480,
  height = 480)

hist(
  my_numbers$Global_active_power,
  col = "red",
  main = "Global Active Power",
  xlab = "Global Active Power (kilowatts)")
dev.off()

cat("Plot 2 .......... \n")

png(
  filename = file.path(
    work_dir,
    "plot2.png"),
  width = 480,
  height = 480)

with(my_numbers,
     plot(
       x = datetime,
       y = Global_active_power,
       type = 'l',
     xlab = "",
     ylab = "Global Active Power (kilowatts)"))
dev.off()

cat("Plot 3 .......... \n")

png(
  filename = file.path(
    work_dir,
    "plot3.png"),
  width = 480,
  height = 480)

with(
  my_numbers,
  plot(
    x = datetime,
    y = Sub_metering_1,
    type = 'n',
    xlab = "",
    ylab = "Energy Sub Metering"))

with(
  my_numbers,
  lines(
    x = datetime,
    y = Sub_metering_1,
    col = "grey"))

with(
  my_numbers,
  lines(
    x = datetime,
    y = Sub_metering_2,
    col = "red"))

with(
  my_numbers,
  lines(
    x = datetime,
    y = Sub_metering_3,
    col = "blue"))

legend(
  x = "topright",
  pch = "-",
  col = c("grey", "red", "blue"),
  legend = c("Sub Metering 1", "Sub Metering 2", "Sub Metering 3"))

dev.off()

cat("Plot 4 .......... \n")

png(
  filename = file.path(
    work_dir,
    "plot4.png"),
  width = 480,
  height = 480)

par(
  mfrow = c(2,2))

with(my_numbers,
     plot(
       x = datetime,
       y = Global_active_power,
       type = 'l',
       xlab = "",
       ylab = "Global Active Power (kilowatts)"))

with(my_numbers,
     plot(
       x = datetime,
       y = Voltage,
       type = 'l',
       xlab = "datetime",
       ylab = "Voltage"))

with(
  my_numbers,
  plot(
    x = datetime,
    y = Sub_metering_1,
    type = 'n',
    xlab = "",
    ylab = "Energy Sub Metering"))

with(
  my_numbers,
  lines(
    x = datetime,
    y = Sub_metering_1,
    col = "grey"))

with(
  my_numbers,
  lines(
    x = datetime,
    y = Sub_metering_2,
    col = "red"))

with(
  my_numbers,
  lines(
    x = datetime,
    y = Sub_metering_3,
    col = "blue"))

legend(
  x = "topright",
  pch = "-",
  col = c("grey", "red", "blue"),
  legend = c("Sub Metering 1", "Sub Metering 2", "Sub Metering 3"))

with(my_numbers,
     plot(
       x = datetime,
       y = Global_reactive_power,
       type = 'l',
       xlab = "datetime",
       ylab = "Global reactive power"))

dev.off()

cat("#  [ Present ] ....................................\n")
cat("#  [ Output ] -------------------------------------\n")
cat("#  [ Export ] .....................................\n")
cat("#  [ Save ] .......................................\n")
cat("#  [ Cleanup ] ------------------------------------\n")

# rm(list = c(
#   "base_dir",
#   "ihepc",
#   "my_data",
#   "save_opt_warn",
#   "work_dir"))
#
# unlink(file.path(
#   work_dir,
#   recursive = TRUE))

cat("#  [ At End ] -------------------------------------\n")
cat("#= [ END ] ========================================\n")

cat("#                   [ End Module ]                 \n")

# EOF .
