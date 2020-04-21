library(dplyr)

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Have total emissions from PM2.5 decreased in the United States from 1999 to 2008?
d1 <- NEI %>% select(year, Emissions)%>% 
  group_by(year) %>% summarise(E = sum(Emissions))

par(mfrow=c(1,1))
plot(d1$year, d1$E, type="n",  
     ylab = "Emissions", xlab ="Year", ylim = c(0, max(d1$E)))
lines(d1$year, d1$E, type = "l")
dev.copy(png, file = "plot1.png")
dev.off()

