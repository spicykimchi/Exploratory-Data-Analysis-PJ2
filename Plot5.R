library(dplyr)
library(ggplot2)

# Lead datasets
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# filter NEI data by fips = '24510' and type = 'ON-ROAD'
NEI_24510 <- filter(NEI, fips=='24510')
NEI_24510_ONROAD <- filter(NEI_24510, type=="ON-ROAD")

# group and sum up Emissions by year
NEI_group_year <- group_by(NEI_24510_ONROAD,year)
NEI_byYearSummary <- summarize(NEI_group_year, total = sum(Emissions))
NEI_byYearSummary <- mutate(NEI_byYearSummary, PM25_kilo = round(total/1000,2))

# plot barchart by x=year, y=PM25_kilo
ggplot(NEI_byYearSummary, aes(year, PM25_kilo)) +
  geom_line() + geom_point() +
  labs(title = "Total Emissions from Coal Combustion-Related Sources",
       x = "Year", y = expression("Total PM"[2.5]*" Emission (Tons)"))

barplot(NEI_byYearSummary$PM25_kilo, names.arg=NEI_byYearSummary$year,
        main=expression('Total Emission of PM'[2.5]),
        xlab='Year', ylab=expression(paste('PM', ''[2.5], ' in Kilotons')))

dev.copy(png, file="plot5.png", width=480, height=480)
dev.off()