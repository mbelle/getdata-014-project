# getdata-014-project
##files
run_analysis.R - downloads data, combines and processes to produce output.txt
codebook.Rmd - details the data and variables in the output and original data set

##The steps to produce the output file are as follows:
* check if data exisits, if not, load data file from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip then unzip file. If data exisits then this is skipped.
* load dplyr - this will create a warning but will not stop execution of code
* load subject data,load test data (y is activity x is variable measurement data)
* load train data y is activity x is variable data
* create tables with subject, activity, readings by cbind in order
* rbind the training and the test sets to create one data set. Merge is not used because it can change the order of data
* Instructions are "Extracts only the measurements on the mean and standard deviation for each measurement." To do this, Look for columns names containing either "-mean" or "-std." Then create vector index of the mean/std columns 
* adjust the indexes for the position of the actual dataset adding the columns for subject and activity
* include selected columns for mean/std and the first two columns (subject and activity)
* Instructions are "Appropriately labels the data set with descriptive variable names."  To do this,set the column names based on the description of the dataset in the features.txt file. Note: These are not entirely friendly but because they are well documented I believe this are appropriately descriptive.
* subset by the vector of selected columns (a) and create a new df
* Instructions are "From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject." I understand this to mean group by subject and activity then calculate mean values. I do so using "group_by" and "summarise each"
* "Uses descriptive activity names to name the activities in the data set" I do so by setting factor levels and labels for activity. Activity labels are cleaned to remove uppercase and underscores.
*additional modification is also performed on the variable names to indicate summarized values (prepend "meanof"), change abreviations (t,f to time and frequency), change all characters to lower case. Parenthesis,commas special characters are also removed. 
* write final results to table "output.txt"  


##Course project for "Getting and Cleaning Data" requirements:

The purpose of this project is to demonstrate your ability to collect, work with, and clean a data set. The goal is to prepare tidy data that can be used for later analysis. You will be graded by your peers on a series of yes/no questions related to the project. You will be required to submit: 

1) a tidy data set as described below, 
2) a link to a Github repository with your script for performing the analysis, and 
3) a code book that describes the variables, the data, and any transformations or work that you performed to clean up the data called CodeBook.md. You should also include a README.md in the repo with your scripts. 
This repo explains how all of the scripts work and how they are connected.  

One of the most exciting areas in all of data science right now is wearable computing - see for example this article . Companies like Fitbit, Nike, and Jawbone Up are racing to develop the most advanced algorithms to attract new users. The data linked to from the course website represent data collected from the accelerometers from the Samsung Galaxy S smartphone. A full description is available at the site where the data was obtained: 

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 

Here are the data for the project: 

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

 You should create one R script called run_analysis.R that does the following:
 
Merges the training and the test sets to create one data set.

Extracts only the measurements on the mean and standard deviation for each measurement. 

Uses descriptive activity names to name the activities in the data set

Appropriately labels the data set with descriptive variable names. 

From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.


#Please see codebook.md for variable names and definitions
