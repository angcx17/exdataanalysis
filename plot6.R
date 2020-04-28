## Reading the tables and loading packages
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

library(dplyr)
library(ggplot2)

## Subsetting for selected fips
fipst <- NEI[NEI$fips == "24510" | NEI$fips == "06037" , ]

## Getting only vehicle source and merging fips
vehiclescc <- SCC[grep("[Vv]ehicle", SCC$EI.Sector), "SCC"]
vehiclenew <- fipst %>% filter(SCC %in% vehiclescc)
vehicle <- vehiclenew %>% group_by(fips, year) %>% 
  summarise(Emissions = sum(Emissions))

## Opening the device and plotting the totals
png("plot6.png", width = 480, height = 480)
g <- ggplot(vehicle, aes(year, Emissions, fill = year))
g <- g + geom_bar(stat = "identity") + facet_grid(.~ fips) + 
  xlab("Year") + ylab("PM[2.5] in Kilotons")
print(g)

## CLosing device
dev.off()