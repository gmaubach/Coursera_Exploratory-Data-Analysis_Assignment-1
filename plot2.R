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
