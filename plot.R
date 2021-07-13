#load packages
library(ggplot2)
library(data.table)

args <- commandArgs(trailingOnly = TRUE)
if (length(args) >= 3) {
  plot_title <- args[1]
  colour <- args[2]     
} else {
  plot_title <- "Breast Feeding and IQ"
  colour <- "green"
}

#setworking directory
setwd("/data")

#Read data
dat<-fread("dat_no_outliers.txt", header=TRUE, data.table=F)

#scatterplot
p<-ggplot(dat, aes(x=std.BF, y=std.IQ))+
            geom_point(color=colour) + 
            geom_smooth(method=lm, se=FALSE, fullrange=TRUE)+
            ggtitle(plot_title)

#save plot
setwd("/results")
ggsave(p, file="BFIQ.jpg")
