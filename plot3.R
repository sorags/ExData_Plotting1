# read the file
file_path <- "household_power_consumption.txt"
lines <- readLines(file_path)
header <- readLines(file_path, n=1)
target_lines <- grep("^(1|2)/2/2007", lines, value = TRUE)

filtered_data <- c(header, target_lines)
view(filtered_data)

temp_file <- tempfile()
writeLines(filtered_data, temp_file)

Feb_df <- read.table(temp_file, header = TRUE, sep = ";", na.strings = "?")

# Combine date and time
datetime2 <- strptime(paste(Feb_df$Date, Feb_df$Time), format = "%d/%m/%Y %H:%M:%S")

Feb_df <- Feb_df %>% 
  mutate(datetime = datetime2)

head(Feb_df)

# create plot 3
with(Feb_df, plot(datetime, Sub_metering_1, type = "n",
                  ylab = "Energy sub metering", xlab = ""))
     
with(Feb_df, lines(datetime, Sub_metering_1, type = "l", col = "black"))
with(Feb_df, lines(datetime, Sub_metering_2, type = "l", col = "red"))
with(Feb_df, lines(datetime, Sub_metering_3, type = "l", col = "blue"))
legend("topright", inset = c(0.06,0) ,lty = 1, col = c("black", "red", "blue"), 
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       cex = 0.85)


dev.copy(png, "plot3.png", width = 480, height = 480)
dev.off()

