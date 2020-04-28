## Reading the tables and loading packages
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

library(ggplot2)

## Subsetting the data for fips 24510
maryland <- NEI[NEI$fips == "24510", ]

## Adding the total emissions per year and type
total <- aggregate(Emissions ~ year + type, maryland, FUN = sum)

## Opening the device and plotting the totals
png("plot3.png", width = 480, height = 480)
g <- ggplot(total, aes(year, Emissions, fill = type))
g <- g + geom_bar(stat = "identity") + facet_grid(.~ type) + 
  xlab("Year") + ylab("PM[2.5] in Kilotons")
print(g)

## CLosing device
dev.off()