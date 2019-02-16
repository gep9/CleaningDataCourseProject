# run_analysis.R
#
# This file is part of the course project in the 'Getting and Cleaning Data'
# course by Coursera. It uses data from the research project 'Human Activity
# Recognition Using Smartphones' (short: 'harus'). You can download the data as
# part of the assignment instructions.
#
# The given txt files are: X_test, y_test, features, X_train, y_train,
# subject_test, and subject_train. 
#
# This script 
# - puts the train and test sets together (data frame 'harus') 
# - extracts a data subset of the measurements on the mean and the standard
# deviation (data frame 'harus_ms')
# - gives a summary with the average of each variable for each activity and each
# subject (data frame 'summary')

# To run this script you need the packages 'data.table' and 'dplyr'.


# 1. Merge the train and the test data set into one data set
        # Read the files into R
        testData <- fread("./getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/test/X_test.txt")
        testLabels <- fread("./getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/test/y_test.txt")
        features <- fread("./getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/features.txt")
        trainData <- fread("./getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/train/X_train.txt")
        trainLabels <- fread("./getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/train/y_train.txt")
        subject_test <- fread("./getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/test/subject_test.txt")
        subject_train <- fread("./getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/train/subject_train.txt")

        # Combine the data sets and its labels
        test <- cbind(subject_test, testLabels, testData)
        train <- cbind(subject_train, trainLabels, trainData)
        
        # Set column names
        featureLabels <- as.character(features$V2)
        colnames(test) <- c("subject", "activity", featureLabels)
        colnames(train) <- c("subject", "activity", featureLabels)

        # Merge the train and the test data set into one data set
        harus <- rbind(test, train)
        
# 2. Extract only the measurements on the mean and standard deviation for each
# measurement
        # The column names contain invalid characters. Force valid column names.
        valid_column_names <- make.names(names=names(harus), unique=TRUE, allow_ = TRUE)
        names(harus) <- valid_column_names
        
        # Find all columns where mean() or std() where calculated, i.e. where it
        # is part of the column name. Note that we search for "." as  character.
        ms_columns <- harus[,grep("mean\\.|std\\.", names(harus))]
        
        # Extract those columns as a subset of the entire data set. Add also the
        # first two columns on the subject an the avtivity.
        harus_ms <- select(harus, subject:activity, ms_columns)
        
        
# 3. Use descritive activity names to name the data set
        # Translate the activity number into a word according to the
        # activity_label.txt file
        harus_ms$activity <- gsub("1", "Walking", harus_ms$activity)
        harus_ms$activity <- gsub("2", "Walking upstairs", harus_ms$activity)
        harus_ms$activity <- gsub("3", "Walking downstairs", harus_ms$activity)
        harus_ms$activity <- gsub("4", "Sitting", harus_ms$activity)
        harus_ms$activity <- gsub("5", "Standing", harus_ms$activity)
        harus_ms$activity <- gsub("6", "Laying", harus_ms$activity)
        
        
# 4. Label the data set appropriately with descriptive variable names: Make the
# feature names (i.e. the column names of the test and training data set) more
# human readable.
        # Replace the dots
        names(harus_ms) <- gsub("\\.", "", names(harus_ms))

        # Replace the first letters: "t" by "time" and "f" by "freq"
        names(harus_ms) <- gsub("^t", "time", names(harus_ms))
        names(harus_ms) <- gsub("^f", "freq", names(harus_ms))
        
        
# 5. From the data set in step 4, create a second, independent tidy data set
# with the average of each variable for each activity and each
# subject.
        # Transform the activity and the subject columns into factor variables
        harus_ms$activity <- as.factor(harus_ms$activity)
        harus_ms$subject <- as.factor(harus_ms$subject)
        
        # Group the data subset 'harus_ms' by activity and subject. Then,
        # summarize all the other columns by calculating the mean, respectivly.
        # Store the result in a data frame called 'summary'
        summary <- harus_ms %>% group_by(subject, activity) %>% summarize_all(mean)
        
        # Write the summary into a txt file
        write.table(summary, file="./summary.txt", row.name=FALSE)
