library(dplyr)

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

library(stringr)
d <- inner_join(NEI, SCC, by = "SCC")

#How have emissions from motor vehicle sources changed from 1999–2008 in Baltimore City?
d5 <- d %>% filter(str_detect(EI.Sector,"Mobile - On-Road") & fips=="24510") %>%
  select(year, Emissions) %>% 
  group_by(year) %>% summarise(E = sum(Emissions))
par(mfrow=c(1,1))
plot(d5$year, d5$E, type="n",  
     ylab = "Emissions", xlab ="Year")
lines(d5$year, d5$E, type = "l")
dev.copy(png, file = "plot5.png")
dev.off()

