## Packages used
library(dplyr); library(tidyr)

## Download data
if(!file.exists("./data")){
        dir.create("./data")
        fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
        download.file(fileUrl, destfile = "./data/zip.zip", method = "curl")
        rm(fileUrl)
        unzip("./data/zip.zip", exdir = "./data")
}

## Read data
options("stringsAsFactors" = FALSE)
features <- read.table("./data/UCI Har Dataset/features.txt")
activity <- read.table("./data/UCI Har Dataset/activity_labels.txt")
test.subject <- read.table("./data/UCI HAR Dataset/test/subject_test.txt")
test.activity <- read.table("./data/UCI HAR Dataset/test/y_test.txt")
test.measures <- read.table("./data/UCI HAR Dataset/test/X_test.txt")
train.subject <- read.table("./data/UCI HAR Dataset/train/subject_train.txt")
train.activity <- read.table("./data/UCI HAR Dataset/train/y_train.txt")
train.measures <- read.table("./data/UCI HAR Dataset/train/X_train.txt")

## Merge test and train data
test <- data.frame(test.subject, test.activity, test.measures)
train <- data.frame(train.subject, train.activity, train.measures)
samsung <- rbind(test, train)

## Add column names
features <- features$V2
names(samsung) <- c("subject", "activity", features)

## Translate activity to all lower-case
activity <- activity$V2
activity <- tolower(activity)

## Convert activity and subject to factors
samsung$activity <- factor(samsung$activity, labels = activity)
samsung$subject <- factor(samsung$subject, ordered = FALSE)

## Subset mean() and std() from samsung
mean <- grep("mean[^F]", names(samsung))
std <- grep("std", names(samsung))
criteria <- c(mean, std)
samsung <- samsung[, c(1:2, criteria)]

## Clear memory of unnecessry objects
rm(features, activity, test.subject, test.activity, test.measures, train.subject,
   train.activity, train.measures, test, train, mean, std, criteria)

## Convert samsung to a tbl_df object
samsung <- tbl_df(samsung)

## Add "all" to end of multidirectional features
index <- grep("[^X-Z]$", names(samsung))
index <- index[-(1:2)]
for(i in index){
        names(samsung)[i] <- paste(names(samsung)[i], "all", sep = "-")
}
rm(index, i)
## Gather variables and separate into feature, summary, direction, and measure
samsung <- samsung %>%
        gather(demo, measure, -subject, -activity) %>%
        separate(demo, c("feature", "summary", "axis"), sep = "-")

## Convert feature, summary, and direction to factors
samsung <- samsung %>%
        mutate(feature = factor(feature),
               summary = factor(summary, labels = c("mean", "std")), 
               axis = factor(tolower(axis)))

## Write samsung to file
if(!file.exists("./samsung.txt")){
        write.table(samsung, "./samsung.txt", row.name = FALSE)
}

## Summarize samsung by average of each summary for each direction, 
## each feature, each activity, and each subject.
summarized <- samsung %>%
        group_by(subject, activity, feature, axis, summary) %>%
        summarize(average = mean(measure))

## Write summ to file
if(!file.exists("./summarized.txt")){
        write.table(summarized, "./summarized.txt", row.name = FALSE)
}