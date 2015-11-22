# install required packages
install.packages("plyr")
install.packages("dplyr")

# set working directory, uncomment and set according to your environment
setwd("/Users/machakar/Documents/private/private_karel/karel/Coursera/getting_and_cleaning_data/PROJ")

# download zip file
fileURL="https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileURL,"dataset.zip")
# unzip downloaded file
unzip("dataset.zip")
setwd("UCI\ HAR\ Dataset")

# read y_train and y_test data, bind them and rename columns
y_train<-read.table("train/y_train.txt")
y_test<-read.table("test/y_test.txt")
y_all<-rbind(y_test, y_train)
y_all<-plyr:::rename(y_all, replace = c("V1" = "activity"))

# rename columns
library(plyr)
y_all$activity<-mapvalues(y_all$activity, from = c(1, 2, 3, 4, 5, 6), 
                          to = c("WALKING", "WALKING_UPSTAIRS", "WALKING_DOWNSTAIRS", 
                                                    "SITTING", "STANDING", "LAYING"))
# names(y_all)
# read X_train and X_test data, bind them and rename columns
X_train<-read.table("train/X_train.txt")
X_test<-read.table("test/X_test.txt")
X_all<-rbind(X_test, X_train)
features<-read.table("features.txt")
library(data.table)
# rename columns
setnames(X_all, names(X_all), paste(names(X_all), "-", as.character(features$V2)))
# names(X_all)

# read subject_train and subject_test data, bind them and rename columns 
subject_train<-read.table("train/subject_train.txt")
subject_test<-read.table("test/subject_test.txt")
subject_all<-rbind(subject_test, subject_train)
subject_all<-plyr:::rename(subject_all, c("V1" = "subject"))

# bind together subject, X and y data into variable data
data<-cbind(subject_all, y_all, X_all)

# assign to data only columns containing strings mean or std
library(dplyr)
data<-names(select(data,contains("mean"), contains("std")))

# group data by activity nd subject and compute mean

tidy<-aggregate(. ~ data$activity + data$subject, data[c(-1, -2)], mean)

# write tidy dataset into tidy.txt file
write.csv(tidy, "../tidy.csv")
write.table(tidy, "../tidy.txt", row.name=FALSE)
