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
raw <- rbind(test, train)

## Add column names
features <- features$V2
names(raw) <- c("subject", "activity", features)

## Convert activity to all lower-case
activity <- activity$V2
activity <- tolower(activity)

## Convert activity and subject to factors
raw$activity <- factor(raw$activity, labels = activity)
raw$subject <- factor(raw$subject, ordered = FALSE)

## Subset mean() and sd() from samsung
mean <- grep("mean[^F]", names(raw))
std <- grep("std", names(raw))
criteria <- c(mean, std)
samsung <- raw[, c(1:2, criteria)]

## Clear memory of unnecessry objects
rm(features, activity, test.subject, test.activity, test.measures, train.subject,
   train.activity, train.measures, test, train, raw, mean, std, criteria)

## Convert samsung to a tbl_df object
samsung <- tbl_df(samsung)

## Add "all" to end of multidirectional features
index <- grep("[^X-Z]$", names(samsung))
index <- index[-(1:2)]
for(i in index){
        names(samsung)[i] <- paste(names(samsung)[i], "all", sep = "-")
}
rm(index, i)
## Gather variables into feature, summary, direction, and measure variables
samsung <- samsung %>%
        gather(demo, measure, -subject, -activity)
samsung <- samsung %>%
        separate(demo, c("feature", "summary", "direction"), sep = "-")

## Convert feature, summary, and direction to factors
samsung <- samsung %>%
        mutate(feature = factor(feature),
                summary = factor(summary, labels = c("mean", "std")), 
               direction = factor(tolower(direction)))

## Summarize samsung by average of each summary for each direction, 
## each feature, each activity, and each subject.
summarized <- samsung %>%
        group_by(subject, activity, feature, direction, summary) %>%
        summarize(average = mean(measure))

## Write summ to file
write.table(summarized, "./summarized.txt", row.name = FALSE)