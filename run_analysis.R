
###############################################################
## Getting and Cleaning Data - Course Project
## M Bellettiere
## May 2015
###############################################################

##dir.create("/getdata-014-project/UCI HAR Dataset")

run_analysis <-function() {
##check if data exisits, if not, load data file from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

  if(!file.exists("~/getdata-014-project/UCI HAR Dataset")){
  fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
  download.file(fileUrl,destfile="~/getdata-014-project/Dataset.zip",method="curl")

  ##unzip file
  setwd("./getdata-014-project")
  unzip("Dataset.zip",overwrite=TRUE)}

  ## load dplyr - this will create a warning
  library(dplyr)

##load subject data
subTrain<-read.table("~/getdata-014-project/UCI HAR Dataset/train/subject_train.txt")
subTest<-read.table("~/getdata-014-project/UCI HAR Dataset/test/subject_test.txt")  
##load test data y is activity x is variable data
varTest<-read.table("~/getdata-014-project/UCI HAR Dataset/test/X_test.txt")
actTest<-read.table("~/getdata-014-project/UCI HAR Dataset/test/y_test.txt")

#load train data y is activity x is variable data
actTrain<-read.table("~/getdata-014-project/UCI HAR Dataset/train/y_train.txt")
varTrain<-read.table("~/getdata-014-project/UCI HAR Dataset/train/X_train.txt")

#create tables with subject, activity, readings by cbind in order
allTest<-cbind(subTest,actTest,varTest)
allTrain<-cbind(subTrain,actTrain,varTrain)

##rbind the training and the test sets to create one data set.
allObs<-rbind(allTest,allTrain)
##Extracts only the measurements on the mean and standard deviation for each measurement. 
#Look for columns names containing either "mean" or "std" create vector index of the mean/std columns 
cols<-read.table("~/getdata-014-project/UCI HAR Dataset/features.txt")
a<-grep("mean|std",cols[,2],ignore.case = TRUE)
#adjust the indexes for the position of the actual dataset adding the columns for subject and activity
a<-a+2
#include selected and the first two columns (subject and activity)
a<-c(1,2,a)




##  Appropriately labels the data set with descriptive variable names. 
## set the column names based on the description of the dataset in the features.txt file.  
##These are not entirely friendly but because they are well documented I believe this are appropriately descriptive
cols<-read.table("~/getdata-014-project/UCI HAR Dataset/features.txt")
vars<-as.character(cols[,2])
col1<-c("subject","activity",vars)
colnames(allObs)<-col1

#subset by the vector of selected columns (a) and create a new df
msObs<-allObs[,a]

##  From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
##I understand this to mean group by subject and activity then calculate mean values
tidyd<-group_by(msObs,subject,activity)%>%summarise_each(funs(mean))
##clean up columns names
colnames(tidyd)<-tolower(colnames(tidyd))

##Uses descriptive activity names to name the activities in the data set
act<-read.table("~/getdata-014-project/UCI HAR Dataset/activity_labels.txt")
tidyd$activity <- factor(tidyd$activity, levels=act[,1],labels=act[,2])
a<-colnames(tidyd)
b<-a[3:88]
b<-paste("meanof_",b,sep="")
b<-c(a[1:2],b)
colnames(tidyd)<-b
## write final results to table "output.txt"  
write.table(tidyd,file="output.txt", row.name=FALSE) 

}