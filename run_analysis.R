# Week 4
# Peer-graded Assignment:
# Getting and Cleaning Data Course Project
# William Tai


####################################################
# Load a package that is required for the project. #
####################################################

library(dplyr)

#######################################################
# Download the zip data file called "UCI HAR Dataset" #
#######################################################

temp <- tempfile()
fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileURL, temp)
unzip(temp)

####################################################################
# Import the datasets and assign variable name for each data set. #
####################################################################

activity_labels <- read.table("UCI HAR Dataset/activity_labels.txt", col.names = c("activity_id", "activity"))

features <- read.table("UCI HAR Dataset/features.txt", col.names = c("i","features"))

X_train <- read.table("UCI HAR Dataset/train/X_train.txt", col.names = features$features)
Y_train <- read.table("UCI HAR Dataset/train/Y_train.txt", col.names = "activity_id")

X_test <- read.table("UCI HAR Dataset/test/X_test.txt", col.names = features$features)
Y_test <- read.table("UCI HAR Dataset/test/Y_test.txt", col.names = "activity_id")

subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt", col.names = "subject")
subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt", col.names = "subject")

###################################################################
# 1. Merges the training and the test sets to create one data set.#
###################################################################

X <- rbind(X_train, X_test)
Y <- rbind(Y_train, Y_test)
subject <- rbind(subject_train, subject_test)
merged <- cbind(subject, Y, X)

##############################################################################################
# 2. Extracts only the measurements on the mean and standard deviation for each measurement. #
##############################################################################################

extracted <- merged %>% select(subject, activity_id, contains("mean"), contains("std"))

##############################################################################
# 3. Uses descriptive activity names to name the activities in the data set. #
##############################################################################

extracted$activity_id <- activity_labels[extracted$activity_id, 2]

#########################################################################
# 4. Appropriately labels the data set with descriptive variable names. #
#########################################################################

names(extracted) <- gsub("Acc", "Accelerometer", names(extracted))
names(extracted) <- gsub("Gyro", "Gyroscope", names(extracted))
names(extracted) <- gsub("BodyBody", "Body", names(extracted))
names(extracted) <- gsub("^t", "Time", names(extracted))
names(extracted) <- gsub("^f", "Frequency", names(extracted))
names(extracted) <- gsub("tBody", "TimeBody", names(extracted))
names(extracted) <- gsub("-mean()", "Mean", names(extracted))
names(extracted) <- gsub("-std()", "STD", names(extracted))
names(extracted) <- gsub("-freq()", "Frequency", names(extracted))

###############################################################################
# 5. From the data set in step 4, creates a second, independent tidy data set #
#    with the average of each variable for each activity and each subject.    #
###############################################################################

tidy <- extracted %>%
        group_by(subject, activity_id) %>%
        summarize_all(funs(mean))
write.table(tidy, "tidy.txt", row.name = FALSE)
