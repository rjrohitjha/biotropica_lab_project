#install.packages("rgbif")  # Install the package
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
  taxonKey = 220,               # Taxon key for floweeri (plants)
  decimalLatitude = paste(min_lat, max_lat, sep = ","),  # Latitude range for tropics
  hasCoordinate = TRUE,       # Only include records with coordinates
  limit = 0                   # Set limit to 0 to get metadata only
)

# Get the total number of records for the query
total_records_angiosperm <- tropical_flowering_plants$meta$count



# Load required libraries
library(rgbif)
library(dplyr)

# Get taxon key for flowering plants (Angiosperms)
angiosperm_key <- name_backbone(name = "Magnoliophyta")$usageKey


# Define tropical region (approximate latitudinal bounds: 23.5°N to 23.5°S)
tropics_lat_range <- c(-23.5, 23.5)

# Query GBIF for iNaturalist observations of flowering plants in the tropics
occ_data <- occ_search(
  taxonKey = 220,
  datasetKey = "50c9509d-36f3-4b9b-9cbd-2c6a5c5dc271", # iNaturalist datasetKey on GBIF
  decimalLatitude = paste(tropics_lat_range, collapse = ","),
  limit = 200000, # Get a large number of records for filtering
  fields = c("speciesKey", "species")
)

occ_test <- occ_search(
  taxonKey = angiosperm_key,
  datasetKey = "50c9509d-36f3-4b9b-9cbd-2c6a5c5dc271", # iNaturalist dataset
  limit = 10 # Small limit to test if it works
)

occ_test$data

# Summarize counts per species
species_counts <- occ_data$data %>%
  group_by(speciesKey, species) %>%
  summarise(observation_count = n(), .groups = "drop") %>%
  filter(observation_count > 1000)

# Display result
print(species_counts)





library(rgbif)
library(dplyr)

# Get the taxonomic key for flowering plants (Magnoliopsida)
flowering_plants_key <- name_backbone(name = "Magnoliopsida", rank = "class")$usageKey

# Check the key
print(flowering_plants_key)



# Define the geographic region (tropics)
tropics_bbox <- c(-180, -23.43687, 180, 23.43687)  # Bounding box for the tropics

# Search for occurrences of flowering plants in the tropics
occ_data <- occ_search(
  taxonKey = flowering_plants_key,
  geometry = paste("POLYGON((", tropics_bbox[1], tropics_bbox[2], ",", 
                   tropics_bbox[3], tropics_bbox[2], ",", 
                   tropics_bbox[3], tropics_bbox[4], ",", 
                   tropics_bbox[1], tropics_bbox[4], ",", 
                   tropics_bbox[1], tropics_bbox[2], "))"),
  limit = 200000 # Adjust limit as needed
)

# Filter species with more than 1000 observations
species_counts <- occ_data$data %>%
  group_by(species) %>%
  summarise(observations = n()) %>%
  filter(observations > 1000)
