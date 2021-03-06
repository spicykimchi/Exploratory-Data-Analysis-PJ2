library(dplyr)
library(ggplot2)


# Lead datasets
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# filter NEI data by SCC contains 'coal' or 'comb'
SCC_comb <- filter(SCC, grepl("Comb.*Coal",Short.Name))

# merge SCC_coal with NEI 
NEI_coal_comb <- merge(x=NEI, y=SCC_comb, by='SCC')

# group and sum up Emissions by year
NEI_group_year <- group_by(NEI_coal_comb,year)
NEI_byYearSummary <- summarize(NEI_group_year, total = sum(Emissions))
NEI_byYearSummary <- mutate(NEI_byYearSummary, PM25_kilo = round(total/1000,2))

# plot line chart by x=year, y=PM25_kilo
ggplot(data=NEI_byYearSummary, aes(x=year, y=PM25_kilo)) + 
  geom_line(aes(group=1, col=PM25_kilo)) + geom_point(aes(size=2, col=PM25_kilo)) + 
  ggtitle(expression('Total Emissions of PM'[2.5])) + 
  ylab(expression(paste('PM', ''[2.5], ' in kilotons'))) + 
  geom_text(aes(label=PM25_kilo, size=2, hjust=1.5, vjust=1.5)) + 
  theme(legend.position='none') + scale_colour_gradient(low='black', high='red')

ggplot(NEI_byYearSummary, aes(year, PM25_kilo)) +
  geom_line() + geom_point() +
  labs(title = "Total Emissions from Coal Combustion-Related Sources",
       x = "Year", y = expression("Total PM"[2.5]*" Emission (Kilotons)"))

dev.copy(png, file="plot4.png", width=480, height=480)
dev.off()
