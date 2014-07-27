## CodeBook

This codebook describes each variables, the data and any work to make the data tidy.

This project inlcudes two tidy datasets.
First, the merged dataset between the training data (x_train) and the testing data (x_test). This dataset is merged based on two measurements: mean and standard deviation.
Second, the another tidy dataset, that is created, with the average of each variables for each activity and subject.

# The first tidy dataset includes the following variables:
	1. Xtrain
	2. Xtest
	3. features
These variables are loaded from the UCI HAR Dataset, which is downloaded from the course project site.
Read these variables into R using read.table() function. Then, using grep() function to extract only the mean and standard deviation of the features.txt data and assign it to a variable "measurements".
Next step, merge the x_train and the x_test datasets using rbind() function based on the "measurements" variable that is mentioned above. This merged data is assinged to "MergeData" variable.

The acitivities variables are named based on the second column of the "features.txt" dataset, called "measurements" as mentioned above. 
Now, we want to focus on the column that contains the text (i.e. mean, std), which is located in column 2, and we named it as "labelMeasurements".
To make it easier to read, we replace all uneccessary characters, such as "(),-," etc. using the gsub() function.

Lastly, labeling the first tidy dataset as "tidyData.txt" using write.table() function.

# The second tidy dataset includes the following variables:
	1. activityLabels
	2. Ytrain
	3. Ytest
	4. subjectTrain
	5. subjectTest
	6. activities
	7. subjects
These variables are also loaded from the UCI HAR Dataset, except "activities" and "subjects" are created by combining the Ytrain and Ytest, and subjectTrain and subjectTest, respectively.
To create a new tidy dataset, a library(reshape2) may be required. 
First, dataframe called "dataFrame" is created for "activities", "subjects", and MergeData". Second, using melt() function to melt that data frame, with id=c("subjects"), and assinging that to "MeltData" variable. 
Next, using dcast() function to cast the data that is just melted, with "subjects" is a "variable". Also, adding "mean" at the end to that command gives the average value for that data. This new variable is called "MeanData".
Lastly, naming the new tidy dataset as "tidyMeanData.txt" using write.table() function. 

