##   Author: Sangrail
##   Date: 23-April-2015

##The purpose of this project is to demonstrate your ability to collect, work with, and clean a data set. The goal is to prepare tidy data that 
##can be used for later analysis. You will be graded by your peers on a series of yes/no questions related to the project. 

##You will be required to submit: 
    
##  1) a tidy data set as described below, 
##  2) a link to a Github repository with your script for performing the analysis, and 
##  3) a code book that describes the variables, the data, and any transformations or work that you performed to clean up the data called CodeBook.md.
##  4) You should also include a README.md in the repo with your scripts. This repo explains how all of the scripts work and how they are connected.  

##  One of the most exciting areas in all of data science right now is wearable computing - see for example this article. 
##  Companies like Fitbit, Nike, and Jawbone Up are racing to develop the most advanced algorithms to attract new users. The data linked to from 
##  the course website represent data collected from the accelerometers from the Samsung Galaxy S smartphone. A full description is available at 
##  the site where the data was obtained: 
    
##      http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 

##  Here are the data for the project: 
    
##      https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

##  You should create one R script called run_analysis.R that does the following. 
##  1. Merges the training and the test sets to create one data set.
##  2. Extracts only the measurements on the mean and standard deviation for each measurement. 
##  3. Uses descriptive activity names to name the activities in the data set
##  4. Appropriately labels the data set with descriptive variable names. 
##  5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.


setwd("C:/Users/BinaryAgent/SkyDrive/Private/Coursera/Getting and Cleaning Data");

##0. Download and extract the test/training data to the folder 'UCI HAR Dataset'

library(plyr)

###Download the compressed file, if neccesary
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

#downloadfile(); ## call this once

##  1. Merges the training and the test sets to create one data set - load the test data and training data
Xtestdata <- read.csv("UCI HAR Dataset/test/X_test.txt", sep="", header=FALSE);
Xtrainingdata <- read.csv("UCI HAR Dataset/train/X_train.txt", sep="", header=FALSE);
Xdata <- rbind(Xtestdata, Xtrainingdata);

#Add the activity classification as a column
Ytestdata <- read.csv("UCI HAR Dataset/test/Y_test.txt", sep="", header=FALSE);
Ytrainingdata <- read.csv("UCI HAR Dataset/train/Y_train.txt", sep="", header=FALSE);
Ydata <- rbind(Ytestdata, Ytrainingdata);

testSubject <- read.csv("UCI HAR Dataset/test/subject_test.txt", sep="", header=FALSE);
trainSubject <- read.csv("UCI HAR Dataset/train/subject_train.txt", sep="", header=FALSE);
Subjects <- rbind(testSubject, trainSubject)

##  2. Extracts only the measurements on the mean and standard deviation for each measurement. 
features <- read.csv("UCI HAR Dataset/features.txt", sep="", header=FALSE)
featuresToKeep <- grep("-mean\\(\\)|-std\\(\\)", features[, 2])
Xdata <- Xdata[, featuresToKeep]
names(Xdata) <- features[featuresToKeep, 2]
names(Xdata) <- gsub("\\(|\\)", "", names(Xdata))##Remove extra characters from the name using the set
names(Xdata) <- tolower(names(Xdata))

##  3. Uses descriptive activity names to name the activities in the data set
activities <- read.csv("UCI HAR Dataset/activity_labels.txt", sep="", header=FALSE)
activities[, 2] = gsub("_", "", tolower(as.character(activities[, 2])))
Ydata[,1] = activities[Ydata[,1], 2]
names(Ydata) <- "activityClassification"

##  4. Appropriately labels the data set with descriptive variable names. 
names(Subjects) <- "subject"
mergedDataSet <- cbind(Subjects, Ydata, Xdata)
write.csv(mergedDataSet, "mergedDataSet.txt")

##  5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
tidy <- aggregate(mergedDataSet, by=list(activity=mergedDataSet$activityClassification, subject=mergedDataSet$subject), mean)
write.table(tidy, "tidy.txt", row.names=FALSE)