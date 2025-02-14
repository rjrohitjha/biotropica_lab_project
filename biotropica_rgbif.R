install.packages("rgbif")  # Install the package
library(rgbif)             # Load the package



#o get a list of plant species with more than 1,000 observations
#in the tropical region (between 23.5°N and 23.5°S) using the rgbif package in R

#define tropical region
# Define the tropical region boundaries
min_lat <- -23.5  # Southern boundary (23.5°S)
max_lat <- 23.5   # Northern boundary (23.5°N)

# Query GBIF for plant observations in the tropical region
tropical_plants <- occ_search(
  taxonKey = 6,               # Taxon key for Plantae (plants)
  decimalLatitude = paste(min_lat, max_lat, sep = ","),  # Latitude range for tropics
  hasCoordinate = TRUE,       # Only include records with coordinates
  limit = 0                   # Set limit to 0 to get metadata only
)

# Get the total number of records for the query
total_records <- tropical_plants$meta$count

#32546475 plant reocrds on gbif



# Search for angiosperm (flowering) observations in the tropics
angiosperms <- occ_search(
  classKey = 220,                     # Class key for angiosperms (Magnoliopsida and Liliopsida)
  decimalLatitude = "-23.5,23.5",     # Latitude range for tropics
  hasCoordinate = TRUE,               # Only include records with coordinates
  limit = 500                       # Limit the number of records for initial exploration
)

# Extract the data
angiosperms_data <- angiosperms$data

# View the first few rows of the data
names(angiosperms_data)

# Query GBIF for plant observations in the tropical region (getting total observatio only)
tropical_flowering_plants <- occ_search(
  taxonKey = 220,               # Taxon key for Plantae (plants)
  decimalLatitude = paste(min_lat, max_lat, sep = ","),  # Latitude range for tropics
  hasCoordinate = TRUE,       # Only include records with coordinates
  limit = 0                   # Set limit to 0 to get metadata only
)

# Get the total number of records for the query
total_records_angiosperm <- tropical_flowering_plants$meta$count



