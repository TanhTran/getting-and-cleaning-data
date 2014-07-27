getting-and-cleaning-data
=========================
## Overview 
The purpose of this project is to demonstrate the ability to work with data and make it tidy.
This is a necessary skill as a datascientist, and getting & cleaning data is a good foundation for later courses.
## This package contains these files:
	1. README.md
	2. CodeBook.md
	3. run_analysis.R
The raw data is loaded from the UCI HAR Dataset, which is downloaded from the course website under the course project section.

## Instructions:
1. Set working directory to the folder that contain the relevant data:
	1. setwd("D:/Coursera/Johns Hopkins University/Data Science Specilization Certificate/3. Getting and Cleaning Data")

2. Read the relevant data into R:
	1. Xtrain<- read.table("./data/X_train.txt")
	2. Xtest<- read.table("./data/X_test.txt")
	3. features<- read.table("./data/features.txt")

3. Extract only the mean and standard deviation from the data set:
	1. measurements<- grep("mean\\(|std\\(", features$V2)

4. Merge the train and the test data set: 
	1. MergeData<- rbind(Xtrain[,measurements],Xtest[,measurements])

5. Name the activities in the data set: 

a.figure out which part of the "measurements" variable need to be named: 

	1. features[measurements,1]
	2. features[measurements,2] 

b.based on the results of the above, "features[measurements,2]" will be named as "labelMeasurements":

	3. labelMeasurements<- features[measurements,2]

c.Using "gsub" command to replace any uneccesary characters to make it easy to read:

	4. gsub("\\-|\\(\\)","",labelMeasurements)

6. Label the tidy data set:
	1. write.table(MergeData,"data/tidyData.txt")

7. Create a second tidy set with the average of each variable for each activitie and subject:

a. read data:

	1. activityLabels<- read.table("./data/activity_labels.txt")
	2. Ytrain<- read.table("./data/y_train.txt")
	3. Ytest<- read.table("./data/y_test.txt")
	4. subjectTrain<- read.table("./data/subject_train.txt")
	5. subjectTest<- read.table("./data/subject_test.txt")

b. combine the datasets:

	1. activities<- rbind(Ytrain, Ytest)[[1]]
	2. subjects<- rbind(subjectTrain, subjectTest)[[1]]

c. Reshape data:

	1. library(reshape2)

d. create a data frame of each variable for each subject and activity:

	1. dataFrame<- data.frame(activities, subjects,MergeData)

e. Melt data:

	1. MeltData<- melt(dataFrame, id=c("activities"))
	2. MeanData<- dcast(MeltData, subjects~variable, mean)

f.Label the second tidy data set as "tidyMeanData":

	write.table(MeanData,"data/tidyMeanData.txt")

DONE

For more information about each variable, the data, and any perfomance to clean up the data. Please refer to CodeBook.md.
