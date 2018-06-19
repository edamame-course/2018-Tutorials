#load required packages
#install via install.packages("PACKAGE")
library(tidyverse)

#read in gene abundance data
data <- read_delim("data/gene_abundance_centralia.txt", delim = "\t")

#read in site metadata
meta <- read_delim("data/Centralia_temperature.txt", delim = "\t")

#annotate and tidy data
data.annotated <- data %>%
  left_join(meta, by = "Site")

write.table(data.annotated, "output/gene_data_annotated.txt", sep = "\t", row.names = FALSE, quote = FALSE)

geneA <- data.annotated %>%
  subset(Gene == "arsM")

#plot data
ggplot(geneA)

#plot data with x and y
ggplot(geneA, aes(x = Fire_history, y = Normalized.abundance))

#GEOMETRIC layers
ggplot(geneA, aes(x = Fire_history, y = Normalized.abundance)) +
  geom_point() 

ggplot(geneA, aes(x = Fire_history, y = Normalized.abundance)) +
  geom_boxplot() 

ggplot(geneA, aes(x = Fire_history, y = Normalized.abundance)) +
  geom_point() 

ggplot(geneA, aes(x = Fire_history, y = Normalized.abundance)) +
  geom_boxplot() +
  geom_jitter() 

ggplot(geneA, aes(x = Fire_history, y = Normalized.abundance)) +
  geom_boxplot() +
  geom_jitter(size = 3, color = "red", width = 0.2) 

#AESTHETIC layers
ggplot(geneA, aes(x = Fire_history, y = Normalized.abundance)) +
  geom_boxplot() +
  geom_jitter(size = 3, width = 0.2, aes(color = Temperature)) 

#SCALE layers
ggplot(geneA, aes(x = Fire_history, y = Normalized.abundance)) +
  geom_boxplot() +
  geom_jitter(size = 3, width = 0.2, aes(color = Temperature)) +
  scale_color_continuous(low = "yellow", high = "red")

#COORDINATE layers
ggplot(geneA, aes(x = Fire_history, y = Normalized.abundance)) +
  geom_boxplot() +
  geom_jitter(size = 3, width = 0.2, aes(color = Temperature)) +
  scale_color_continuous(low = "yellow", high = "red") +
  coord_flip()

#FACET layers
ggplot(data.annotated, aes(x = Fire_history, y = Normalized.abundance)) +
  geom_boxplot() +
  geom_jitter(size = 2, width = 0.2, aes(color = Temperature)) +
  scale_color_continuous(low = "yellow", high = "red") +
  facet_wrap(~Gene)

ggplot(data.annotated, aes(x = Fire_history, y = Normalized.abundance)) +
  geom_boxplot() +
  geom_jitter(size = 2, width = 0.2, aes(color = Temperature)) +
  scale_color_continuous(low = "yellow", high = "red") +
  facet_wrap(~Gene, scales = "free_y")

#THEME layers
ggplot(data.annotated, aes(x = Fire_history, y = Normalized.abundance)) +
  geom_boxplot() +
  geom_jitter(size = 3, width = 0.2, aes(color = Temperature)) +
  scale_color_continuous(low = "yellow", high = "red") +
  facet_wrap(~Gene, scales = "free_y") +
  theme_bw()

ggplot(data.annotated, aes(x = Fire_history, y = Normalized.abundance)) +
  geom_boxplot() +
  geom_jitter(size = 3, width = 0.2, aes(color = Temperature)) +
  scale_color_continuous(low = "yellow", high = "red") +
  facet_wrap(~Gene, scales = "free_y") +
  theme_bw(base_size = 12) +
  theme(axis.text.x = element_text(angle = 45, hjust = 1, vjust = 1))

#ADDITIONAL AESTHETICS
(boxplot <- ggplot(data.annotated, aes(x = Fire_history, y = Normalized.abundance)) +
  geom_boxplot() +
  geom_jitter(size = 2, width = 0.2, aes(color = Temperature)) +
  scale_color_continuous(low = "yellow", high = "red") +
  facet_wrap(~Gene, scales = "free_y") +
  theme_bw(base_size = 10) +
  theme(axis.text.x = element_text(angle = 45, hjust = 1, vjust = 1)) +
  ylab("Normalized abundance") +
  xlab("Fire history") +
  labs(color = "Temperature (°C)"))

#SAVING a plot
ggsave(boxplot, filename = "figures/gene.boxplot.eps", units = "in", width = 6, height = 4)

#EXERCISE #2: bar charts
(bar <- ggplot(geneA, aes(x = Fire_history)) +
  geom_bar()) 

(bar_full <- ggplot(data.annotated, aes(x = Fire_history)) +
  geom_bar())

(bar_facet <- ggplot(data.annotated, aes(x = Fire_history)) +
  geom_bar() +
  facet_wrap(~Gene))

(bar_color <- ggplot(geneA, aes(x = Fire_history)) +
  geom_bar(color = "black"))

(bar_fill <- ggplot(geneA, aes(x = Fire_history)) +
  geom_bar(fill = "black"))

(bar_site <- ggplot(data.annotated, aes(x = Site, y = Normalized.abundance)) +
  geom_bar(stat = "identity", color = "black", aes(fill = Gene)))

ggplot(data.annotated, aes(x = Site, y = Normalized.abundance)) +
  geom_bar(stat = "identity", color = "black", position = "dodge", aes(fill = Gene)) 

ggplot(data.annotated, aes(x = Site, y = Normalized.abundance)) +
  geom_bar(stat = "identity", color = "black", position = "fill", aes(fill = Gene))

(pie <- ggplot(subset(data.annotated, Site == "Cen01"), aes(x = Site, y = Normalized.abundance)) +
  geom_bar(stat = "identity", color = "black",  aes(fill = Gene), width = 1) +
  coord_polar(start = 0, "y") +
  theme_void() +
  theme(axis.text.x=element_blank()))

#Challenge 1
(c1 <- ggplot(data.annotated, aes(x = Temperature, y = Normalized.abundance)) +
  geom_smooth(method = "lm", linetype = "dashed", color = "black") +
  geom_point(size = 3, aes(shape = Fire_history, color = Gene)) +
  facet_wrap(~Gene, scales = "free_y") +
  theme_classic(base_size = 10) +
  xlab("Temperature (°C)") +
  ylab("Normalized abundance") +
  labs(size = "Normalized abundance"))

#Challenge 2
(c2 <- ggplot(data.annotated, aes(x = Site, y = Gene)) +
  geom_point(aes(size = Normalized.abundance, color = Temperature)) +
  geom_point(aes(size = Normalized.abundance), shape = 1, color = "black") +
  scale_color_continuous(low = "yellow", high = "red") +
  theme_bw(base_size = 10) +
  theme(axis.text.x = element_text(angle = 45, hjust = 1, vjust = 1)) +
  labs(color = "Temperature (°C)", size = "Normalized abundance") +
  coord_flip())
