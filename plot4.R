library(dplyr)

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

library(stringr)
d <- inner_join(NEI, SCC, by = "SCC")

# how have emissions from coal combustion-related sources changed from 1999–2008?
d4 <- d %>% filter(str_detect(EI.Sector,"Comb") & str_detect(EI.Sector,"Coal") & fips=="24510") %>%
  select(year, Emissions) %>% 
  group_by(year) %>% summarise(E = sum(Emissions))
par(mfrow=c(1,1))
plot(d4$year, d4$E, type="n",  
     ylab = "Emissions", xlab ="Year")
lines(d4$year, d4$E, type = "l")
dev.copy(png, file = "plot4.png")
dev.off()
