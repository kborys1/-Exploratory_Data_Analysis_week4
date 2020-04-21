library(dplyr)
NEI <- readRDS("summarySCC_PM25.rds")

# Which of four types  have seen decreases in emissions from 1999–2008 for Baltimore City?
d3 <- NEI %>% filter(fips=="24510") %>% select(year, type, Emissions) %>% 
  group_by(year, type) %>% summarise(Emission = sum(Emissions))

library(ggplot2)
p<-ggplot(d3, aes(x=year, y=Emission, group=type)) +
  geom_line(aes(color=type))+
  geom_point(aes(color=type))
p
ggsave("plot3.png", plot = p)
