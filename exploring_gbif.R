####################################
##exploring rgbif
########################

install.packages("rgbif")  # Install the package
library(rgbif)             # Load the package



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
