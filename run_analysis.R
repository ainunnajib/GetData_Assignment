library(dplyr)
library(tidyr)

#read and merge rows of subject records
subjects <- rbind(
  read.csv("test/subject_test.txt", header = FALSE),
  read.csv("train/subject_train.txt", header = FALSE))
names(subjects) <- "subject"

#read and merge rows of activities records
activities <- rbind(
  read.csv("test/y_test.txt", header = FALSE),
  read.csv("train/y_train.txt", header = FALSE))
names(activities) <- "activityCode"

subjects.activities <- cbind(subjects, activities)

#measurements & features labels
measurements <- rbind(
  read.table("test/X_test.txt"),
  read.table("train/X_train.txt"))

features <- read.csv("features.txt", header = FALSE, sep = " ")
features <- features %>% mutate(V2 = gsub('\\(\\)', '', V2))
features <- features %>% mutate(V2 = gsub('\\(|\\)', '.', V2))
names(measurements) <- c(features$V2)
#take only mean and std columns
mean.std.cols <- grep('mean|std', names(measurements))
mean.std <- measurements[, mean.std.cols]

#finally combine subject.activities with mean.std measurements
subjects.activities <- cbind(subjects.activities, mean.std)

#map the activity label
activity.labels <- read.csv("activity_labels.txt", header = FALSE, sep = " ")
names(activity.labels) <- c("activityCode", "activity")
subjects.activities <- merge(subjects.activities, activity.labels, by = "activityCode", sort = FALSE)
dataset <- subjects.activities %>% select(subject, activity, matches('mean|std'))

#create tidy data
tidydata <- dataset %>% group_by(subject, activity)
tidydata <- summarise_each(tidydata, funs(mean))
#write to text file
write.table(tidydata, "tidydata.txt", quote = FALSE, sep = ",")

