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
datetime <- paste(Feb_df$Date, Feb_df$Time)
head(datetime)
class(datetime) # character

datetime2 <- strptime(datetime, format = "%d/%m/%Y %H:%M:%S")

Feb_df <- Feb_df %>% 
  mutate(datetime = datetime2)

head(Feb_df)

# Create time series plot
with(Feb_df, plot(datetime, Global_active_power, type = "l", ylab = "Global Active Power (kilowatts)", xlab = ""))

dev.copy(png, "plot2.png", width = 480, height = 480)
dev.off()
