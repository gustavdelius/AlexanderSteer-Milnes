#load packages

library(tidyverse)
library(readxl)
library(lubridate)
library(rmarkdown)

#import and show the data frame

landings_data <- read_csv("data/sample_landings_data_raw.csv")
landings_data

#descriptive column headings

landings_data <- landings_data %>%
  rename(Year = yy,
         Date = dat,
         Trip_ID = trip,
         Effort_Hours = effort,
         Gear = gr,
         Species = sp,
         Length_cm = l_cm,
         Weight_g = w_cm) 
landings_data <- landings_data %>%
  mutate(Date = mdy(Date))

landings_data

#remove missing data

landings_data <- na.omit(landings_data)
landings_data

#correct the "trap" typo to "Trap", and similarly "Caesoi cunning" to "Caesio cuning"

landings_data <- landings_data %>%
  mutate(Gear = replace(Gear,Gear == "trap", "Trap")) %>%
  mutate(Species = replace(Species,Species == "Caesoi cunning", "Caesio cuning"))

landings_data

#remove species with length over 100cm

landings_data <- landings_data %>%
  filter(Length_cm < 100)

plot(landings_data$Length_cm)

#save cleaned data

write_csv(landings_data,"data/sample_landing_data_clean.csv")

