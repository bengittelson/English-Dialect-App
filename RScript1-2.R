library(ggplot2)
library(plyr)
library(dplyr)
#Read in data
while_data <- read.csv('new_output.csv')
head(while_data)

#Subset data
#while_data <- subset(metadata, metadata$phrase == "As soon as they heard him, the villagers all rushed from their homes, full of concern for his safety, and two of his cousins even stayed with him for a short while.")
while_data <- subset(while_data, while_data$country=="United Kingdom")

#Remove outliers
while_data$H1H2[!while_data$H1H2 %in% boxplot.stats(while_data$H1H2)$out]
while_data$F0[!while_data$F0 %in% boxplot.stats(while_data$F0)$out]
summary(while_data)
head(while_data, 2)
hist(while_data$Age)

#Run linear regressions
fit1 <- lm(F0~Age + Ethnicity + Gender + My.highest.qualification... + I.completed..will.complete..full.time.education.at... + I.travel.to.work.or.school... + In.the.past.10.years.I.have.moved..., data=while_data)
summary(fit1)
fit2 <- lm(H1H2~F0 + Age + Ethnicity + Gender + My.highest.qualification... + I.completed..will.complete..full.time.education.at... + I.travel.to.work.or.school... + In.the.past.10.years.I.have.moved..., data=while_data)
summary(fit2)
# model without F0
fit3 <- lm(H1H2~Age + Ethnicity + Gender + My.highest.qualification... + I.completed..will.complete..full.time.education.at... + I.travel.to.work.or.school... + In.the.past.10.years.I.have.moved..., data=while_data)
summary(fit3)

#distribution of overall statistics
hist1 = ggplot(while_data,aes(x=H1H2)) + geom_histogram(binwidth=1)
hist1
hist2 = hist1 +¡¡geom_histogram(binwidth=2)
hist2
#Run t-tests
#t-test for F0 indicates that women have higher pitch, but this seems kind of meaningless
#since we would expect that anyways...
t.test(while_data$F0~while_data$Gender)
t.test(while_data$H1H2~while_data$Gender)

#Plot F0 for women and F0 for men across ages
while_data$AgeGroup <- as.numeric(while_data$Age)
while_data$AgeGroup <- cut(while_data$AgeGroup, breaks = c(0, 15, 20, 25, 30, 35, 40, 45, 50, 55, 60, 65, Inf), labels = c("Under 15", "15-20", "20-25", "25-30", "30-35", "35-40", "40-45", "45-50", "50-55", "55-60", "60-65", "65 and up"))
head(while_data$AgeGroup, 20)

pd <- position_dodge(.5)
F0_data <- ddply(while_data, c("Gender", "AgeGroup"), summarise, N=length(F0), mean = mean(F0), sd=sd(F0), se = sd / sqrt(N))
F0_data
ggplot(F0_data, aes(x = AgeGroup, y = mean, colour = Gender)) + geom_line(aes(group=Gender)) + geom_point() + geom_errorbar(aes(ymin=mean-se, ymax=mean+se)) + xlab("Age Group") + ylab("Mean F0") + ggtitle("Mean F0 across Age Groups for Men and Women") + theme(axis.text=element_text(size=14), axis.title.x=element_text(size=16), axis.title.y=element_text(size=16), title=element_text(size=24), legend.text=element_text(size=14), legend.title=element_text(size=16))

#Get mean H1H2 using ddply and plot by age and gender
H1H2_data <- ddply(while_data, c("Gender", "AgeGroup"), summarise, N=length(H1H2), mean = mean(H1H2), sd=sd(H1H2), se = sd / sqrt(N))
H1H2_data
ggplot(H1H2_data, aes(x = AgeGroup, y = mean, colour = Gender)) + geom_line(aes(group=Gender)) + geom_point() + geom_errorbar(aes(ymin=mean-se, ymax=mean+se)) + xlab("Age Group") + ylab("Mean H1*-H2*") + ggtitle("Mean H1*-H2* across Age Groups for Men and Women") + theme(axis.text=element_text(size=14), axis.title.x=element_text(size=16), axis.title.y=element_text(size=16), title=element_text(size=24), legend.text=element_text(size=14), legend.title=element_text(size=16))

# #get mean F0 and H1H2
# aggregate_stats <- aggregate(cbind(while_data$F0, while_data$H1H2) ~ while_data$AgeGroup + while_data$Gender, FUN=mean)
# aggregate_stats
# aggregate_H1H2 <- aggregate(while_data$H1H2 ~ while_data$AgeGroup, FUN=mean)
# aggregate_data <- data.frame(levels(while_data$AgeGroup), aggregate_F0, aggregate_H1H2)
# aggregate_data
# qplot(x=aggregate_data$while_data.AgeGroup, y=aggregate_data$while_data.F0)
# qplot(x=aggregate_data$while_data.AgeGroup, y=aggregate_data$while_data.H1H2)
# 
# 
# ggplot(aggregate_data, aes(x=while_data.AgeGroup, y=while_data.F0))
# 
# df_women <- subset(while_data, while_data$Gender=="Female")
# write.csv(df_women, file="female_data.csv")
# df_men <- subset(while_data, while_data$Gender=="Male")
# write.csv(df_men, file="male_data.csv")
# 
# 
# 
# 
# 
# 
# 
# 
# #recode gender as 0/1
# for (row in while_data$recording) {
#   if (while_data$recording == 'recordings/a560ee63-1015-481e-b7dd-2a441e2872f7.wav')
#     row$F0 <- 2
#   else
#     row$FO <- NA
# }

#recode age as age group


#recode age group as series of binary variables


#recode education as series of binary variables
#while_data$gcse <- 

#recode ethnicity as series of binary variables




#t-test for gender? 
#multiple regression on gender, age group, highest degree, ethnicity? 
#must recode all variables as binary variables with


### aggregation by gender and age group

agg_data = while_data %>% group_by(Gender, AgeGroup) %>% summarise(meanH1H2 = mean(H1H2, na.rm = TRUE))

