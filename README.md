GettingNCleaningData
====================
# Third module in Data Science specialization track
## This README file is required as part of the module project. It contains information about how the 'run_analysis.R' script works

###The 'run_analysis.R' scripts does the following:
1. It firsts downloads the UCI HAR data set as a zipped file and the unzips its contents into a folder called **UCI HAR Dataset** in the working directory
2. It loads the X, Y, and subject train and test data sets and then merges them using *rbind*
3. It extracts only the mean and standard deviation from the *features* data set (using *grep*) and applies on the merged X data set
4. Descriptive activity names are created for the merged Y data set by extracting activity names using *gsub*
5. The merged subject data set is assigned column name subjects
6. The three data sets X, Y, and subject are then merged using *cbind* and this combined data set is written to a file names **combined.txt** in the working directory 
7. From the above-metioned tidy data set, a second data set called **avgData.txt** is created with the average of each variable for each activity and each subject. This file is written to the same working directory and also uploaded to the GitHub repo.
