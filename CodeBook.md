# Code Book

## Getting and Cleaning Data Course Project

### 1. Study Design
 This analysis is about wearable computing. It takes a look at data collected in the frame work of the research project 'Human Activity Recognition Using Smartphones' carried out by Jorge L. Reyes-Ortuz, Alessandro Ghio, Luca Oneto, and Davide Anguita at the Università degli Studi di Genova in 2012. The data are collected from the accelerometers of a Samsung Galaxy S II smartphone.
 
 How did the experiment work? The researchers asked 30 volunteers to perform six activities (Walking, Walking upstairs, Walking downstairs, Sitting, Standing, Laying) while wearing a smartphone on the waist. They captured 3-axial linear acceleration and 3-axial angular velocity using the embedded accelerometer and the gyroscope of the smartphone. The resulting data set was randomly divided into two different subsets, i.e. 70% of the test persons generated the training data and 30% the test data.
 
 For further information, see the website [ http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones](http://)
 
 and the publication
 Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012
 
### 2. Variables in the Data Set

The researchers collected all sensor signals per person and activity. The signals from the accelerometer were measured in gravity units 'g'. The angular velocity from the gyroscope is given in radians/second. 

The signals were pre-processed. Those steps are reflected in the variables' names. A complete list of all 561 features is part of the experiment data ('features.txt').

The raw signals tAcc-XYZ and tGyro-XYZ are 3-axial signals coming from the accelerometer and the gyrometer ('t' stands for 'time'). Both were collected at a constant rate of 50 Hz. They were filtered using a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise.

The acceleration signal was divided into body and acceleration signals where another low pass Butterworth filter with a corner frequency of 0.3 Hz was used:
- tBodyAcc-XYZ
- tGravityAcc-XYZ

The body linear acceleration and angular velocity were derived in time to obtain Jerk signals:
- tBodyAccJerk-XYZ
- tBodyGyro-XYZ
- tBodyGyroJerk-XYZ

The magnitude of these signals were calculated using the Euclidean norm:
- tBodyAccMag
- tGravityAccMag
- tBodyAccJerkMag
- tBodyGyroMag
- tBodyGyroJerkMag

The researches applied a Fast Fourier Transformation to some of the signals ('f' means 'frequency domain signals').
- fBodyAcc-XYZ
- fBodyAccJerk-XYZ
- fBodyGyro-XYZ
- fBodyAccMag
- fBodyAccJerkMag
- fBodyGyroMag
- fBodyGyroJerkMag


The set of variables that were estimated from these signals are: 

- mean(): Mean value
- std(): Standard deviation
- mad(): Median absolute deviation 
- max(): Largest value in array
- min(): Smallest value in array
- sma(): Signal magnitude area
- energy(): Energy measure. Sum of the squares divided by the number of values. 
- iqr(): Interquartile range 
- entropy(): Signal entropy
- arCoeff(): Autorregresion coefficients with Burg order equal to 4
- correlation(): correlation coefficient between two signals
- maxInds(): index of the frequency component with largest magnitude
- meanFreq(): Weighted average of the frequency components to obtain a mean frequency
- skewness(): skewness of the frequency domain signal 
- kurtosis(): kurtosis of the frequency domain signal 
- bandsEnergy(): Energy of a frequency interval within the 64 bins of the FFT of each window.
- angle(): Angle between to vectors.

Finally, additional vectors are obtained by averaging the signals and used on the angle() variable:

- gravityMean
- tBodyAccMean
- tBodyAccJerkMean
- tBodyGyroMean
- tBodyGyroJerkMean

All features are normalized and bounded within [-1,1].


### 3. Summary Choices
The resulting data set from my analysis is called 'summary.txt'. It's a 180 x 68 data frame and it gives the average of each chosen variable for each activity and each subject. The transformations applied to the HARUS data sets are codified step by step in the R script 'run_analysis.R'. You need the txt files X_test, y_test, features, X_train, y_train, subject_test, and subject_train. 

To run the script load the packages 'data.table' and 'dplyr' to your library.

This script 
 - puts the train and test sets together (data frame 'harus') 
 - extracts a data subset of the measurements on the mean and the standard deviation (data frame 'harus_ms')
 - gives a summary with the average of each variable on the mean and the standard deviation for each activity and each subject (data frame 'summary')
 - writes this summary into the file 'summary.txt'

It does so by applying the following steps:

1. Merge the train and the test data set into one data set
	a. Read the files into R
	b. Combine the data sets and its labels
	c. Set column names
	d. Merge the train and the test data set into one data set
        
2. Extract only the measurements on the mean and standard deviation for each measurement
	a. The column names contain invalid characters. Force valid column names.
	b. Find all columns where mean or std where calculated, i.e. where it is part of the column name. Note that we search for "." as  character.
	c. Extract those columns as a subset of the entire data set. Add also the first two columns on the subject an the avtivity.
        
3. Use descritive activity names to name the data set: Translate the activity number into a word according to the 'activity_label.txt' file

4. Label the data set appropriately with descriptive variable names: Make the feature names (i.e. the column names of the test and training data set) more human readable.
	a. Replace the dots
	b. Replace the first letters: "t" by "time" and "f" by "freq"
        
5. From the data set in step 4, create a second, independent tidy data set with the average of each variable for each activity and each subject.
	a. Transform the activity and the subject columns into factor variables
	b. Group the data subset 'harus_ms' by activity and subject. Then, summarize all the other columns by calculating the mean, respectivly. Store the result in a data frame called 'summary'
    c. Write the summary into a txt file




