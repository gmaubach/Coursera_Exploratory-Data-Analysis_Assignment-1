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

