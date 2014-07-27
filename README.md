getting-and-cleaning-data
=========================
## Overview 
The purpose of this project is to demonstrate the ability to work with data and make it tidy.
This is a necessary skill as a datascientist, and getting & cleaning data is a good foundation for later courses.
This package contains these files:
	1. README.md
	2. CodeBook.md
	3. run_analysis.R
The raw data is loaded from the UCI HAR Dataset, which is downloaded from the course website under the course project section.

## Instructions:
1. Set working directory to the folder that contain the relevant data
	setwd("D:/Coursera/Johns Hopkins University/Data Science Specilization Certificate/3. Getting and Cleaning Data")

2. Read the relevant data into R
	Xtrain<- read.table("./data/X_train.txt")
	Xtest<- read.table("./data/X_test.txt")
	features<- read.table("./data/features.txt")

3. Extract only the mean and standard deviation from the data set
	measurements<- grep("mean\\(|std\\(", features$V2)

4. Merge the train and the test data set 
	MergeData<- rbind(Xtrain[,measurements],Xtest[,measurements])

5. Name the activities in the data set 
a.figure out which part of the "measurements" variable need to be named 
	features[measurements,1]
	features[measurements,2] 
b. based on the results of the above, "features[measurements,2]" will be named as "labelMeasurements"
	labelMeasurements<- features[measurements,2]
c. Using "gsub" command to replace any uneccesary characters to make it easy to read
	gsub("\\-|\\(\\)","",labelMeasurements)

6. Label the tidy data set
	write.table(MergeData,"data/tidyData.txt")

7. Create a second tidy set with the average of each variable for each activitie and subject.
a. read data
	activityLabels<- read.table("./data/activity_labels.txt")
	Ytrain<- read.table("./data/y_train.txt")
	Ytest<- read.table("./data/y_test.txt")
	subjectTrain<- read.table("./data/subject_train.txt")
	subjectTest<- read.table("./data/subject_test.txt")
b. combine the datasets
	activities<- rbind(Ytrain, Ytest)[[1]]
	subjects<- rbind(subjectTrain, subjectTest)[[1]]
c. Reshape data
	library(reshape2)
d. create a data frame of each variable for each subject and activity 
	dataFrame<- data.frame(activities, subjects,MergeData)
e. Melt data
	MeltData<- melt(dataFrame, id=c("activities"))
	MeanData<- dcast(MeltData, subjects~variable, mean)
	head(MeanData)
f.Label the second tidy data set as "tidyMeanData"
	write.table(MeanData,"data/tidyMeanData.txt")

DONE

For more information about each variable, the data, and any perfomance to clean up the data. Please refer to CodeBook.md.
