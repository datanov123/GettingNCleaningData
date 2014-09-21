##Download data set and unzip
file <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
dir.create('UCI HAR Dataset')
download.file(file, 'UCI-HAR-dataset.zip')
unzip('./UCI-HAR-dataset.zip')

##1. Merges the training and the test sets to create one data set.
##Read XTrain data from downloaded dataset
XTrainPath <- "./UCI HAR Dataset/train/X_train.txt"
XTrainData <- read.table(XTrainPath)

##Read XTest data from downloaded dataset
XTestPath <- "./UCI HAR Dataset/test/X_test.txt"
XTestData <- read.table(XTestPath)

##Merge, using row bind, the XTrain and XTest data sets
XMergedData <- rbind(XTrainData,XTestData)

##Read subject train and test data from downloaded dataset
subjectTrainPath <- "./UCI HAR Dataset/train/subject_train.txt"
subjectTestPath <- "./UCI HAR Dataset/test/subject_test.txt"
subjectTrainData <- read.table(subjectTrainPath)
subjectTestData <- read.table(subjectTestPath)

##Merge, using row bind, the subject train and test data sets
subjectData <- rbind(subjectTrainData,subjectTestData)

##Read y train and test data from downloaded dataset
yTrainPath <- "./UCI HAR Dataset/train/y_train.txt"
yTestPath <- "./UCI HAR Dataset/test/y_test.txt"
yTrainData <- read.table(yTrainPath)
yTestData <- read.table(yTestPath)
##Merge, using row bind, the y train and test data sets
yData <- rbind(yTrainData,yTestData)

##2. Extract only the measurements on the mean and standard deviation for each measurement
##First, extract the features that have mean/stdev values
featuresPath <- "./UCI HAR Dataset/features.txt"
features <- read.table(featuresPath)
measureMeanStd <- grep("-mean\\(\\)|-std\\(\\)", features[, 2])
##Second, extract the meausements on the mean and stdev
XMeanStd <- XMergedData[,measureMeanStd]

##3. Uses descriptive activity names to name the activities in the data set
names(XMeanStd) <- gsub("\\(|\\)","",features[measureMeanStd,2])    ##Feature names without the '(' and ')' symbols

activityPath <- "./UCI HAR Dataset/activity_labels.txt"
activityList <- read.table(activityPath)
activityList[,2] <- gsub("_","",activityList[,2]) ##Activity names without the '_' symbols

yData[,1] <- activityList[yData[,1],2]
colnames(yData) <- "activities"
colnames(subjectData) <- "subjects"

##4. Appropriately labels the data set with descriptive variable names. 
##Create a combined data set, with appropriate labels, by combining the data sets created from the previous extraction steps 
AllData <- cbind(subjectData,XMeanStd,yData)

tidyDataFile <- "./tidyData.txt"
write.table(AllData,tidyDataFile)

##5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 
## The output file name is "avgData.txt"
average <- aggregate(x=AllData, by=list(activities=AllData$activities, subj=AllData$subjects), FUN=mean)
avgDataFile <- "./avgData.txt"
write.table(average,avgDataFile,row.names=FALSE)
