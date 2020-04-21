library(dplyr)

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

library(stringr)
d <- inner_join(NEI, SCC, by = "SCC")

#Compare emissions from motor vehicle sources in Baltimore City vs Los Angeles County
# baltimore
d5 <- d %>% filter(str_detect(EI.Sector,"Mobile - On-Road") & fips=="24510") %>%
  select(year, Emissions) %>% 
  group_by(year) %>% summarise(E = sum(Emissions))
# los angeles
d6 <- d %>% filter(str_detect(EI.Sector,"Mobile - On-Road") & fips=="06037") %>%
  select(year, Emissions) %>% 
  group_by(year) %>% summarise(E = sum(Emissions))

par(mfrow=c(1,1))
plot(d6$year, d6$E, type="n",  
     ylab = "Emissions", xlab ="Year", ylim = c(0, max(d6$E)+2000))
lines(d5$year, d5$E, type = "l", col = "blue")
lines(d6$year, d6$E, type = "l", col = "red")
legend("topright", lty = 1, col = c("red", "blue"), cex = .75, 
       legend = c("Los Angeles", "Baltimore"), bty = "n")
dev.copy(png, file = "plot6.png")
dev.off()
