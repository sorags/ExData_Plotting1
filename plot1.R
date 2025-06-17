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

view(Feb_df)


# Create Global Active Power Frequency Plot

hist(Feb_df$Global_active_power, col = "red", 
     main = "Global Active Power", 
     xlab = "Global Active Power (killowats)")

# copy plot to png
dev.copy(png, "plot1.png", width = 480, height = 480)
dev.off()
