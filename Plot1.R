
library(dplyr)

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

##Q1 - Have total emissions from PM2.5 decreased in the United States from 1999 to 2008? Using the base plotting system, make a plot showing the total PM2.5 emission from all sources for each of the years 1999, 2002, 2005, and 2008.
NEI_group_year <- group_by(NEI,year)
NEI_byYearSummary <- summarize(NEI_group_year, count = n(), total = sum(Emissions))

barplot(
  (NEI_byYearSummary$total)/1000,
  names.arg=NEI_byYearSummary$year,
  xlab="Year",
  ylab=expression(paste('PM', ''[2.5], ' in Kilotons')),
  main=expression('Total Emission of PM'[2.5])
)

dev.copy(png, file="plot1.png", width=480, height=480)
dev.off()
