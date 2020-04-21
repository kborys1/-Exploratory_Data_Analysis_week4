library(dplyr)
NEI <- readRDS("summarySCC_PM25.rds")

# Have total emissions from PM2.5 decreased in the Baltimore City  from 1999 to 2008?
d2 <- NEI %>% filter(fips=="24510") %>% select(year, Emissions) %>% 
  group_by(year) %>% summarise(E = sum(Emissions))

par(mfrow=c(1,1))
plot(d2$year, d2$E, type="n",  
     ylab = "Emissions in Baltimore", xlab ="Year", ylim = c(0, max(d2$E)))
lines(d2$year, d2$E, type = "l")
dev.copy(png, file = "plot2.png")
dev.off()
