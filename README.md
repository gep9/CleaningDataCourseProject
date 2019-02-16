# README

This repo contains the files for the course project in the 'Getting and Cleaning Data' course by Coursera. It contains the following four files:
- README.md
- CodeBook.md
- run_analysis.R
- summary.txt

## The Code Book
The file 'CodeBook.md' is divided into three sections. 
1. The first section *Study Design *describes the experimental study where the data are taken from. It is the research project 'Human Activity Recognition Using Smartphones' carried out by Jorge L. Reyes-Ortuz, Alessandro Ghio, Luca Oneto, and Davide Anguita at the Università degli Studi di Genova in 2012.
2. The second section *Variables in the Data Set* lists all variables in the original data set.
3. The third section *Summary Choices* gives an overview on what is going on in the R file 'run-analysis.R'. It explains all transformations, renaming and further work that I performed to clean up the data.


## R Script
The R script called 'run_analysis.R' that does the following. It

   1. merges the training and the test sets to create one data set.
   2. extracts only the measurements on the mean and standard deviation for each measurement.
   3. uses descriptive activity names to name the activities in the data set
   4. appropriately labels the data set with descriptive variable names.
    From the data set in step 4, it creates a second, independent tidy data set called 'summary.txt' with the average of each variable for each activity and each subject.

## Resulting Data
The resulting data set from the analysis is called 'summary.txt'. It's a 180 x 68 data frame and it gives the average of each variable for each activity and each subject.