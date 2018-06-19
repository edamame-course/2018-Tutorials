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

#EXERCISE #2
ggplot(data.annotated, aes(x = Site, y = Normalized.abundance)) +
  geom_bar(stat = "identity", color = "black", aes(fill = Gene)) +
  coord_flip() 

ggplot(data.annotated, aes(x = Site, y = Normalized.abundance)) +
  geom_bar(stat = "identity", color = "black", position = "fill", aes(fill = Gene)) +
  coord_flip() 

ggplot(data.annotated, aes(x = Site, y = Normalized.abundance)) +
  geom_bar(stat = "identity", color = "black", position = "fill", aes(fill = Gene)) +
  coord_polar(start = 0, "y") +
  facet_wrap(~Site)

ggplot(data.annotated, aes(x = Fire_history, y = Normalized.abundance)) +
  geom_bar(stat = "identity", position = "fill", aes(fill = Gene)) 
  coord_flip()

ggplot(data.annotated, aes(x = Site, y = Normalized.abundance)) +
  geom_bar(stat = "identity", color = "black", position = "dodge", aes(fill = Gene)) +
  coord_flip() 

#EXERCISE #3
ggplot(data.annotated, aes(x = Temperature, y = Normalized.abundance, shape = Fire_history, color = Gene)) +
  geom_point(size = 3) +
  facet_wrap(~Gene, scales = "free_y")

#EXERCISE #4
ggplot(data.annotated, aes(x = Fire_history, fill = Fire_history)) +
  geom_histogram(stat = "count") +
  coord_polar(start = 0)


