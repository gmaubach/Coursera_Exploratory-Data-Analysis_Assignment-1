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
