### Course Project ###

## Set working directory
setwd("D:/Coursera/Johns Hopkins University/Data Science Specilization Certificate/3. Getting and Cleaning Data")

## Read local data (train and test data)
Xtrain<- read.table("./data/X_train.txt")
Xtest<- read.table("./data/X_test.txt")
features<- read.table("./data/features.txt")
names(features)
features$V1
features$V2

## Extracts mean and standard deviation
measurements<- grep("mean\\(|std\\(", features$V2)

## Merge the train and test data set
MergeData<- rbind(Xtrain[,measurements],Xtest[,measurements])
head(MergeData)  

## Name the activities & the data set by using "descriptive activity names"
# figure out which part of the "measurements" variable need to be named 
features[measurements,1]
features[measurements,2] 
# based on the results of the above, "features[measurements,2]" will be named as "labelMeasurements"
labelMeasurements<- features[measurements,2]
# Using "gsub" command to replace any uneccesary characters to make it easy to read
gsub("\\-|\\(\\)","",labelMeasurements)

## Labeling the "MergeData" dataset  as "tidyData.txt"
write.table(MergeData,"data/tidyData.txt")

## Create a second, independent tidy data set
# name the activities in the data set
activityLabels<- read.table("./data/activity_labels.txt")
Ytrain<- read.table("./data/y_train.txt")
Ytest<- read.table("./data/y_test.txt")
subjectTrain<- read.table("./data/subject_train.txt")
subjectTest<- read.table("./data/subject_test.txt")

# combine the datasets
activities<- rbind(Ytrain, Ytest)[[1]]
subjects<- rbind(subjectTrain, subjectTest)[[1]]

# Reshape data
library(reshape2)
# create a data frame of each variable for each subject and activity 
dataFrame<- data.frame(activities, subjects,MergeData)

# Melt data
MeltData<- melt(dataFrame, id=c("activities"))
MeanData<- dcast(MeltData, subjects~variable, mean)
head(MeanData)

# Label the second tidy data set as "tidyMeanData"
write.table(MeanData,"data/tidyMeanData.txt")
