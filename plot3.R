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
