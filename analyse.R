#load packages
library(data.table)

args <- commandArgs(trailingOnly = TRUE)
if (length(args) >= 3) {
  input_data <- args[3]       
} else {
  input_data <- "SimulatedUKData.txt"
}

#setworking directory
setwd("/data")

#Read data
dat<-fread(input_data, header=TRUE, data.table=F)

#remove outliers
Q <- quantile(dat$std.IQ, probs=c(.05, .95), na.rm = FALSE)
dat_no_outliers<- subset(dat, dat$std.IQ > Q[1] & dat$std.IQ < Q[2])
print(paste("pps before exclusion=", nrow(dat), sep=""))
print(paste("pps after exclusion=", nrow(dat_no_outliers), sep=""))

#regression
print(summary(glm(std.IQ ~ std.BF, data=dat_no_outliers, family="gaussian")))

#save data
write.table(dat_no_outliers, "dat_no_outliers.txt", row.names=FALSE, quote=FALSE)


                               