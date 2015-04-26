
Course Project Code Book
========================

The purpose of this project is to demonstrate your ability to collect, work with, and clean a data set. The goal is to prepare tidy data that 
can be used for later analysis. You will be graded by your peers on a series of yes/no questions related to the project. 

You will be required to submit: 

	1) a tidy data set as described below, 
	2) a link to a Github repository with your script for performing the analysis, and 
	3) a code book that describes the variables, the data, and any transformations or work that you performed to clean up the data called CodeBook.md.
	4) You should also include a README.md in the repo with your scripts. This repo explains how all of the scripts work and how they are connected.  

Data collection method 
=======================
The data collection method is outlined here: 	
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 

Data Source: 
==================
The data source can be downloaded from the following URL: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

Using the following:
<pre>
downloadfile <- function(){
  library(httr)
  url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip";
  zipFile <- "HAR_Dataset.zip";
  if(!file.exists(zipFile)){
      download.file(url, zipFile, method="curl");
  }
  
  dataDir <- "UCI HAR Dataset";
  
  if(!file.exists(dataDir)) 
  { 
      unzip(zipFile, exdir = ".") 
  }
  
  dataDir
}

#downloadfile(); 
</pre>

Feature Selection 
==================

The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ. These time domain signals (prefix 't' to denote time) were captured at a constant rate of 50 Hz. Then they were filtered using a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise. Similarly, the acceleration signal was then separated into body and gravity acceleration signals (tBodyAcc-XYZ and tGravityAcc-XYZ) using another low pass Butterworth filter with a corner frequency of 0.3 Hz. 

Subsequently, the body linear acceleration and angular velocity were derived in time to obtain Jerk signals (tBodyAccJerk-XYZ and tBodyGyroJerk-XYZ). Also the magnitude of these three-dimensional signals were calculated using the Euclidean norm (tBodyAccMag, tGravityAccMag, tBodyAccJerkMag, tBodyGyroMag, tBodyGyroJerkMag). 

Finally a Fast Fourier Transform (FFT) was applied to some of these signals producing fBodyAcc-XYZ, fBodyAccJerk-XYZ, fBodyGyro-XYZ, fBodyAccJerkMag, fBodyGyroMag, fBodyGyroJerkMag. (Note the 'f' to indicate frequency domain signals). 

These signals were used to estimate variables of the feature vector for each pattern:  
'-XYZ' is used to denote 3-axial signals in the X, Y and Z directions.

* tBodyAcc-XYZ
* tGravityAcc-XYZ
* tBodyAccJerk-XYZ
* tBodyGyro-XYZ
* tBodyGyroJerk-XYZ
* tBodyAccMag
* tGravityAccMag
* tBodyAccJerkMag
* tBodyGyroMag
* tBodyGyroJerkMag
* fBodyAcc-XYZ
* fBodyAccJerk-XYZ
* fBodyGyro-XYZ
* fBodyAccMag
* fBodyAccJerkMag
* fBodyGyroMag
* fBodyGyroJerkMag

The set of variables that were estimated from these signals are: 

* mean(): Mean value
* std(): Standard deviation
* mad(): Median absolute deviation 
* max(): Largest value in array
* min(): Smallest value in array
* sma(): Signal magnitude area
* energy(): Energy measure. Sum of the squares divided by the number of values. 
* iqr(): Interquartile range 
* entropy(): Signal entropy
* arCoeff(): Autorregresion coefficients with Burg order equal to 4
* correlation(): correlation coefficient between two signals
* maxInds(): index of the frequency component with largest magnitude
* meanFreq(): Weighted average of the frequency components to obtain a mean frequency
* skewness(): skewness of the frequency domain signal 
* kurtosis(): kurtosis of the frequency domain signal 
* bandsEnergy(): Energy of a frequency interval within the 64 bins of the FFT of each window.
* angle(): Angle between to vectors.

Additional vectors obtained by averaging the signals in a signal window sample. These are used on the angle() variable:

gravityMean
tBodyAccMean
tBodyAccJerkMean
tBodyGyroMean
tBodyGyroJerkMean

The complete list of variables of each feature vector is available in the file 'features.txt' contained in the downloaded zip archive.

Measured Activities
===================
The list of measured activities are as follows:

* WALKING
* WALKING_UPSTAIRS
* WALKING_DOWNSTAIRS
* SITTING
* STANDING
* LAYING


The Script operation
====================
The attached R script (run_analysis.R) performs the following to clean up the data:

* Merges the training and test sets to create one data set, namely train/X_train.txt with test/X_test.txt, the result of which is a 10299x561 data frame.

* Reads features.txt and extracts only the measurements on the mean and standard deviation for each measurement.

* Reads activity_labels.txt and applies descriptive activity names to name the activities in the data set: walking, walkingupstairs, walkingdownstairs, sitting, standing, laying

* Aggregates the merged data set, by the activity classification (walking, etc...) and the subject ID and export to a file called, Tidy.txt.
