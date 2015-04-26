
Course Project Code Book
========================

The purpose of this project is to demonstrate your ability to collect, work with, and clean a data set. The goal is to prepare tidy data that 
can be used for later analysis. You will be graded by your peers on a series of yes/no questions related to the project. 

You will be required to submit: 

	1) a tidy data set as described below, 
	2) a link to a Github repository with your script for performing the analysis, and 
	3) a code book that describes the variables, the data, and any transformations or work that you performed to clean up the data called CodeBook.md.
	4) You should also include a README.md in the repo with your scripts. This repo explains how all of the scripts work and how they are connected.  

Data collection method outlined here: 	http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 
Data: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

The attached R script (run_analysis.R) performs the following to clean up the data:

* Merges the training and test sets to create one data set, namely train/X_train.txt with test/X_test.txt, the result of which is a 10299x561 data frame.

* Reads features.txt and extracts only the measurements on the mean and standard deviation for each measurement.
* 
* Aggregate the merged data set, by the activity classification (walking, etc...), the subject ID and export to a file called, Tidy.txt.


* Reads activity_labels.txt and applies descriptive activity names to name the activities in the data set: walking, walkingupstairs, walkingdownstairs, sitting, standing, laying
