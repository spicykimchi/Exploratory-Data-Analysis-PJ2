library(dplyr)

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# filter NEI data by fips = '24510'
NEI_24510 <- filter(NEI, fips=='24510')

# group and get sum of Emissions by year
NEI_group_year <- group_by(NEI_24510,year)
NEI_byYearSummary <- summarize(NEI_group_year, count= n(), total = sum(Emissions))

# plot barchart by x=year, y=total
barplot(NEI_byYearSummary$total, names.arg=NEI_byYearSummary$year,
        main=expression(paste('Total Emission of PM'[2.5], ' in Baltimore City, Maryland')),
        xlab='Year', ylab=expression(paste('PM', ''[2.5],' in kilotons')))

dev.copy(png, file="plot2.png", width=480, height=480)
dev.off()
