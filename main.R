# Load necessary libraries
library(rvest)

# Define the URL of the Wikipedia page
url <- "https://en.wikipedia.org/wiki/List_of_towns_and_cities_in_England_by_population"

# Read the HTML content from the URL
webpage <- read_html(url)

# Extract the table containing the list of cities
city_table <- html_table(html_nodes(webpage, "table")[[1]])

# Check if city table was extracted successfully
if (is.null(city_table)) {
  stop("Failed to extract city table. Please verify the webpage structure.")
}

# Print column names
print(colnames(city_table))

# After checking the printed column names, replace the column names in the next line accordingly
required_columns <- city_table[, c("#", "Town or city", "County", "2021 Pop.[1]")]

# Remove any rows with NA values
required_columns <- na.omit(required_columns)

# Rename columns
colnames(required_columns) <- c("rank 2021", "Town or city", "County", "2021 population")

# Save the data to a CSV file
write.csv(required_columns, file = "cities_england_population.csv", row.names = FALSE)

# Print a message indicating that the data has been saved
cat("Cities in England with their 2021 population have been saved to 'cities_england_population.csv'\n")
