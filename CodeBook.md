The purpose of this "run_analysis.R" script is to collect, work with, and clean a data set that can be used for later analysis.

     - Load the required package called "dplyr". This is performed by:
            library(dplyr)

     - Download the zip data file called "UCI HAR Dataset" from the link:
            https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

     - Import the datasets by using read.table()
            - "UCI HAR Dataset/activity_labels.txt"
                 - 6 observations, 2 column variables
                 - Description: Links the class labels with their activity name
            - "UCI HAR Dataset/features.txt"
                 - 561 observations, 2 column variables
                 - Description: List of all activity features
            - "UCI HAR Dataset/train/X_train.txt"
                 - 7352 observations, 561 column variables
                 - Description: Training set
            - "UCI HAR Dataset/train/Y_train.txt"
                 - 7352 observations, 1 column variable
                 - Description: Training labels
            - "UCI HAR Dataset/test/X_test.txt"
                 - 2947 observations, 561 column variables
                 - Description: Test set
            - "UCI HAR Dataset/test/Y_test.txt"
                 - 2947 observations, 1 column variable
                 - Description: Test labels
            - "UCI HAR Dataset/train/subject_train.txt"
                 - 7352 observations, 1 column variable
                 - Description: Each row identifies the subject who performed the activity for each window sample.
                 - Note: This data set is limited to subjects 1, 3, 5, 6-8, 11, 14-17, 19, 21-23, 25-30.
            - "UCI HAR Dataset/test/subject_test.txt"
                 - 2947 observation, 1 column variable
                 - Description: Each row identifies the subject who performed the activity for each window sample.
                 - Note: This data set is limited to subjects 2, 4, 9, 10, 12, 13, 18, 20, and 24.

     - Assign the variable name for each dataset.
            - activity_labels <- activity_labels.txt
            - features <- features.txt
            - X_train <- X_train.txt
            - Y_train <- Y_train.txt
            - X_test <- X_test.txt
            - Y_test <- Y_test.txt
            - subject_train <- subject_train.txt            
            - subject_test <- subject_test.txt

     - Merges the training and the test sets to create one data set.
            - Use rbind() to merge:
                  - X_train and X_test and assign it to X (10299 observations, 561 column variables)
                  - Y_train and Y_test and assign it to Y (10299 observations, 1 column variable)
                  - subject_train and subject_test and assign it to subject (10299 observations, 1 column variable)
            - Use cbind() to merge:
                  - X, Y, and subject and assign it to merged (10299 observations, 563 column variables)

     - Extracts only the measurements on the mean and standard deviation for each measurement.
            - Use select() to subset merged using subject and code columns and the "mean" and "std" measurements.
            - Assign this to extracted.

     - Uses descriptive activity names to name the activities in the data set.
            - Use the second column of activity_labels to replace all existing column variable names.

     - Appropriately labels the data set with descriptive variable names.
            - Use gsub to rename the column variable names
                 - Acc -> Accelerometer (Column variable names containing 'Acc')
                 - Gyro -> Gyroscope    (Column variable names containing 'Gyro')
                 - BodyBody -> Body     (Column variable names containing 'BodyBody')
                 - ^t -> Time           (Column variable names starting with 't')
                 - ^f -> Frequency      (Column variable names starting with 'f')
                 - -mean() -> Mean      (Column variable names containing 'mean()')
                 - -std() -> STD        (Column variable names containing 'std()')
                 - -freq() -> Frequency (Column variable names containing 'freq()')

     - From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
            - Use group_by for subject and activity.
            - Use summarize_all to summarize mean by subject and activity.
            - Assign this to tidy (180 observations, 88 column variables