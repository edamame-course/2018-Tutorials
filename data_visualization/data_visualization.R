#load required packages
#install via install.packages("PACKAGE")
library(tidyverse)
library(reshape2)

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
  geom_boxplot() +
  geom_jitter(size = 3, color = "red", width = 0.2) 


#AESTHETIC layers
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
  geom_jitter(size = 3, width = 0.2, aes(color = Temperature)) +
  scale_color_continuous(low = "yellow", high = "red") +
  facet_wrap(~Gene)

ggplot(data.annotated, aes(x = Fire_history, y = Normalized.abundance)) +
  geom_boxplot() +
  geom_jitter(size = 3, width = 0.2, aes(color = Temperature)) +
  scale_color_continuous(low = "yellow", high = "red") +
  facet_wrap(~Gene, scales = "free_y")

#THEME layers
ggplot(data.annotated, aes(x = Fire_history, y = Normalized.abundance)) +
  geom_boxplot() +
  geom_jitter(size = 3, width = 0.2, aes(color = Temperature)) +
  scale_color_continuous(low = "yellow", high = "red") +
  facet_wrap(~Gene, scales = "free_y") +
  theme_light()

#ADDITIONAL AESTHETICS
ggplot(data.annotated, aes(x = Fire_history, y = Normalized.abundance)) +
  geom_boxplot() +
  geom_jitter(size = 3, width = 0.2, aes(color = Temperature)) +
  scale_color_continuous(low = "yellow", high = "red") +
  facet_wrap(~Gene, scales = "free_y") +
  theme_bw(base_size = 10) +
  ylab("Normalized abundance") +
  xlab("Fire history") +
  labs(color = "Temperature (°C)") + 
  theme(axis.text.x = element_text(angle = 45, hjust = 1, vjust = 1))

#EXERCISE #2
ggplot(data.annotated, aes(x = Site, y = Normalized.abundance)) +
  geom_bar(stat = "identity", color = "black", aes(fill = Gene)) +
  coord_flip() 

ggplot(data.annotated, aes(x = Site, y = Normalized.abundance)) +
  geom_bar(stat = "identity", color = "black", position = "dodge", aes(fill = Gene)) +
  coord_flip() 

ggplot(data.annotated, aes(x = Site, y = Normalized.abundance)) +
  geom_bar(stat = "identity", color = "black", position = "fill", aes(fill = Gene)) +
  coord_flip() 

ggplot(data.annotated, aes(x = Fire_history, y = Normalized.abundance)) +
  geom_bar(stat = "identity", position = "fill", aes(fill = Gene)) 

ggplot(subset(data.annotated, Site == "Cen01"), aes(x = Site, y = Normalized.abundance)) +
  geom_bar(stat = "identity", color = "black",  aes(fill = Gene), width = 1) +
  coord_polar(start = 0, "y") +
  theme_void() +
  theme(axis.text.x=element_blank())

#EXERCISE #3
ggplot(data.annotated, aes(x = Temperature, y = Normalized.abundance, color = Gene)) +
  geom_smooth(method = "lm", linetype = "dashed") +
  geom_point(size = 3, aes(shape = Fire_history)) +
  facet_wrap(~Gene, scales = "free_y") +
  theme_bw(base_size = 10) +
  xlab("Temperature (°C)") +
  ylab("Normalized abundance")


ggplot(data.annotated, aes(x = Site, y = Gene)) +
  geom_point(aes(size = Normalized.abundance, color = Temperature)) +
  geom_point(aes(size = Normalized.abundance), shape = 1, color = "black") +
  scale_color_continuous(low = "yellow", high = "red") +
  theme_bw()
