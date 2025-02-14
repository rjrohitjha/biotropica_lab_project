install.packages("rgbif")  # Install the package
library(rgbif)             # Load the package


####################################
##exploring rgbif
########################

# Search for observations of Panthera tigris
tiger_data <- occ_search(scientificName = "Panthera tigris", limit = 100)
print(tiger_data)


#filter by time
tiger_data_recent <- occ_search(
  scientificName = "Panthera tigris",
  year = "2020,2023",  # Observations between 2020 and 2023
  limit = 100
)
print(tiger_data_recent)

#filter by location
tiger_data_asia <- occ_search(
  scientificName = "Panthera tigris",
  decimalLatitude = "10,40",  # Latitude range (e.g., 10°N to 40°N)
  decimalLongitude = "60,120", # Longitude range (e.g., 60°E to 120°E)
  limit = 100
)
print(tiger_data_asia)


#filter by country
tiger_data_india <- occ_search(
  scientificName = "Panthera tigris",
  country = "IN",  # ISO country code for India
  limit = 100
)
print(tiger_data_india)

#Step 6: Filter by basis of record
tiger_data_human <- occ_search(
  scientificName = "Panthera tigris",
  basisOfRecord = "HUMAN_OBSERVATION",  # Only human observations
  limit = 100
)
print(tiger_data_human)


#Step 7: Combine multiple filters
tiger_data_filtered <- occ_search(
  scientificName = "Panthera tigris",
  country = "IN",
  year = "2020,2023",
  limit = 100
)
print(tiger_data_filtered)


#Step 8: Explore the data
occurrence_data <- tiger_data_filtered$data
head(occurrence_data)  # View the first few rows of the data

#Step 9: Visualize the data (optional)
install.packages("leaflet")  # Install leaflet if not already installed
library(leaflet)

# Create a map
leaflet(data = occurrence_data) %>%
  addTiles() %>%
  addCircleMarkers(
    lng = ~decimalLongitude,
    lat = ~decimalLatitude,
    popup = ~as.character(eventDate)
  )

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


# Load the rgbif package
library(rgbif)

# Search for angiosperm observations in the tropics
angiosperms <- occ_search(
  classKey = 220,                     # Class key for angiosperms (Magnoliopsida and Liliopsida)
  decimalLatitude = "-23.5,23.5",     # Latitude range for tropics
  hasCoordinate = TRUE,               # Only include records with coordinates
  limit = 1000                        # Limit the number of records for initial exploration
)

# Extract the data
angiosperms_data <- angiosperms$data

# View the first few rows of the data
head(angiosperms_data)

# Query GBIF for plant observations in the tropical region
tropical_flowering_plants <- occ_search(
  taxonKey = 220,               # Taxon key for Plantae (plants)
  decimalLatitude = paste(min_lat, max_lat, sep = ","),  # Latitude range for tropics
  hasCoordinate = TRUE,       # Only include records with coordinates
  limit = 0                   # Set limit to 0 to get metadata only
)

# Get the total number of records for the query
total_records <- tropical_flowering_plants$meta$count



