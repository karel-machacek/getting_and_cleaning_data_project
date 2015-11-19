install.packages("plyr")
install.packages("dplyr")

setwd("/Users/machakar/Documents/private/private_karel/karel/Coursera/getting_and_cleaning_data/PROJ")
fileURL="https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileURL,"dataset.zip")
unzip("dataset.zip")
setwd("UCI\ HAR\ Dataset")

y_train<-read.table("train/y_train.txt")
y_test<-read.table("test/y_test.txt")
y_all<-rbind(y_test, y_train)
y_all<-plyr:::rename(y_all, replace = c("V1" = "activity"))
y_all$activity<-mapvalues(y_all$activity, from = c(1, 2, 3, 4, 5, 6), 
                          to = c("WALKING", "WALKING_UPSTAIRS", "WALKING_DOWNSTAIRS", 
                                                    "SITTING", "STANDING", "LAYING"))
# names(y_all)

X_train<-read.table("train/X_train.txt")
X_test<-read.table("test/X_test.txt")
X_all<-rbind(X_test, X_train)
features<-read.table("features.txt")
library(data.table)
setnames(X_all, names(X_all), paste(names(X_all), "-", as.character(features$V2)))
# names(X_all)

subject_train<-read.table("train/subject_train.txt")
subject_test<-read.table("test/subject_test.txt")
subject_all<-rbind(subject_test, subject_train)
subject_all<-plyr:::rename(subject_all, c("V1" = "subject"))
data<-cbind(subject_all, y_all, X_all)

data<-names(select(data,contains("mean"), contains("std")))

tidy<-aggregate(. ~ data$activity + data$subject, data[c(-1, -2)], mean)
write.csv(tidy, "tidy.csv")
