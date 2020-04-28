## Reading the tables and loading packages
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

library(dplyr)
library(ggplot2)

## Subsetting for only coal source and putting data together
coalscc <- SCC[grep("[Cc][Oo][Aa][Ll]", SCC$EI.Sector), "SCC"]
coalnei <- NEI %>% filter(SCC %in% coalscc)
coal <- coalnei %>% group_by(year) %>% summarise(Emissions = sum(Emissions))

## Opening device and plotting
png("plot4.png", width = 480, height = 480)
g <- ggplot(coal, aes(x=year, y=Emissions, fill=year))
g <- g + geom_bar(stat = "identity") + ylab("PM [2.5] in Kilotons") + 
  xlab("Year") + ggtitle("Coal Emission from 1999 to 2008")
print(g)

## Closing device
dev.off()
