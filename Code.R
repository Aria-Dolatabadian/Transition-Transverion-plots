library(GenVisR)
library(ggplot2)
library(gridExtra)
library(grid)

# load the data into R
mutationData <- read.delim("ggplot2ExampleData.tsv")

# change the "Simple_name" column to "sample"
colnames(mutationData)[colnames(mutationData) %in% "sample"] <- "sample_1"
colnames(mutationData)[colnames(mutationData) %in% "Simple_name"] <- "sample"

# subset the data to just the discovery cohort
mutationData <- mutationData[mutationData$dataset == "discovery",]
mutationData$sample <- factor(mutationData$sample, levels=unique(mutationData$sample))

# run TvTi
TvTi(mutationData, fileType="MGI")


#Plotting Frequencies with Proportions


library(gridExtra)
library(grid)

# make a frequency and proportion plot
tvtiFreqGrob <- TvTi(mutationData, fileType="MGI", out="grob", type="frequency")
tvtiPropGrob <- TvTi(mutationData, fileType="MGI", out="grob", type="proportion")

# combine the two plots
finalGrob <- arrangeGrob(tvtiFreqGrob, tvtiPropGrob, ncol=1)

# draw the plot
grid.draw(finalGrob)
