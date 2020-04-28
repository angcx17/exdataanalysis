## Reading the tables
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

## Adding the total emissions per year
total <- aggregate(Emissions ~ year, NEI, FUN = sum)

## Opening the device and plotting the totals
png("plot1.png", width = 480, height = 480)
with(total, 
     barplot(height=Emissions, names.arg = year, col = year, 
             xlab = "Year", ylab ="PM[2.5] in Kilotons",
             main = "Annual Emission PM[2.5] from 1999 to 2008"))

## CLosing device
dev.off()
