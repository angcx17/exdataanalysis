## Reading the tables and loading packages
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

library(dplyr)
library(ggplot2)

## Subsetting for only vehicle source and putting data together
vehiclescc <- SCC[grep("[Vv]ehicle", SCC$EI.Sector), "SCC"]
vehiclenei <- NEI %>% filter(SCC %in% vehiclescc & fips == "24510")
vehicle <- vehiclenei %>% group_by(year) %>% summarise(Emissions = sum(Emissions))

## Opening device and plotting
png("plot5.png", width = 480, height = 480)
g <- ggplot(vehicle, aes(x=year, y=Emissions, fill=year))
g <- g + geom_bar(stat = "identity") + ylab("PM [2.5] in Kilotons") + 
  xlab("Year") + ggtitle("Vehicle Emission from 1999 to 2008 in BC")
print(g)

## Closing device
dev.off()
