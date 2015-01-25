## the unzipped UCI HAR Dataset folder should be in your working directory

## read the relevant files
subject_train <- read.table("./UCI HAR Dataset/train/subject_train.txt")
x_train <- read.table("./UCI HAR Dataset/train/x_train.txt")
y_train <- read.table("./UCI HAR Dataset/train/y_train.txt")
subject_test <- read.table("./UCI HAR Dataset/test/subject_test.txt")
x_test <- read.table("./UCI HAR Dataset/test/x_test.txt")
y_test <- read.table("./UCI HAR Dataset/test/y_test.txt")

## Step 1 : merge the training and test sets to create one data set
testSet <- cbind(subject_test, y_test, x_test)
trainSet <- cbind(subject_train, y_train, x_train)
#### merge both sets in one data set
dataMerged <- rbind(testSet, trainSet)

## Step 2 : Extracts only the measurement on the mean and standard deviation
## for each measurement

#### we will use the features.txt file to select the columns we need to extract
features <- read.table("./UCI HAR Dataset/features.txt")

#### extract the indices of the rows containing mean() or std() in the
#### second column of the features file.
#### we'll use the parenthesis after mean and std to be sure we don't
#### grab rows, where the word "mean" or "std" are not at the end,
#### like the meanFreq(), which we don't want to grab.
IndicesForMeanAndSd <- grep("mean\\(\\)|std\\(\\)", features[,2])

#### subset the merged data set (dataMerged) according to those grabbed indices
#### while keeping the first two columns (the originals subject and y files),
#### thus the added +2 in the indices number, we need to throw them
#### all by two indices in the dataMerged to preserve the first two columns
dataMergedLight <- dataMerged[,c(1:2, (IndicesForMeanAndSd+2))]

#### could be verify by checking dim(dataMergedLight)
#### or by printing dataMergedLight[1:3,1:9]
#### the first column is the subject id, the second is the activity id
#### the following columns are the means and standard deviations of 
#### each measurement, 
#### note that column 8 is V6 and column 9 is V41 as there are no "mean"
#### nor "std" in the rows 7 to 40 of the features file.  


## step 3 : uses descriptive activity names to name the activities in the
## data set

#### we'll use the activity_labels file
activityNames <- 
        read.table("./UCI HAR Dataset/activity_labels.txt")
#### rewrite the activity names in a better way
#### replace the "_" by a space
activityNames[,2] <- gsub("_", " ", activityNames[,2])
#### rewrite them with a capital first letter and the rest in lower case
activityNames[,2] <- gsub("(\\w)(\\w*)", "\\U\\1\\L\\2", 
                            activityNames[,2], perl= TRUE)
#### it's possible to collapse back the space separating two words :
#### activityNames[,2] <- gsub(" ", "", activityNames[,2])
#### however we won't do it as it has no incidence for future analysis
#### the case would have been different if those names have been variable
#### names (column header) instead of value names.

#### replace the activities number of the dataMergedLight's column 2
#### by their real names
#### to do so match the row number of activitiesNames with the number display
#### in the dataMergedLight's activity column then extract the name in
#### activitiesNames column 2
dataMergedLight[,2] <- activityNames[dataMergedLight[,2],2]

## Step 4 : Appropriately labels the data set with descriptive variable names

#### rename the first two columns
colnames(dataMergedLight)[1:2] <- c("Subject", "Activity")
#### fetch the selected measurement names from the features.txt file
#### previously read in features, then rename them to avoid bad characters,
#### and finally rename the remaining columns of dataMergedLight
#### with those modified names
featuresNames <- as.character(features[IndicesForMeanAndSd,2])
featuresNames <- gsub("\\(\\)", "", featuresNames)
featuresNames <- gsub("-", "", featuresNames)
featuresNames <- gsub("BodyBody", "Body", featuresNames)
featuresNames <- gsub("mean", "Mean", featuresNames)
featuresNames <- gsub("std", "Sd", featuresNames)
featuresNames <- gsub("^t", "Time", featuresNames)
featuresNames <- gsub("^f", "Freq", featuresNames)
colnames(dataMergedLight)[3:length(dataMergedLight)] <- featuresNames

#### remove unused elements from the global environment except dataMergedLight
rm(list=setdiff(ls(), "dataMergedLight"))

## Step 5 : From the data set in step 4, creates a second,
## independent tidy data set with the average of each variable
## for each activity and each subject

#### need to load the plyr package
library(plyr)
#### create a temporary function to calculate the column means
#### this function will be use in the ddply() function as the FUN argument
tempFunction <- function(input) { colMeans(input[,3:length(input)]) }

#### use the ddply() function from the plyr package in order to compute the
#### average of each variable for each activity and each subject
tidyAverages <- ddply(dataMergedLight, .(Subject, Activity), tempFunction)

#### remove the temporary function from the global environement
rm("tempFunction")

#### slight change of name for the modified columns
colnames(tidyAverages)[-c(1,2)] <- 
        paste0("Mean_of_", colnames(tidyAverages)[-c(1,2)])

## Write the new data set in a text file
write.table(tidyAverages, "tidyAverages.txt", row.names = FALSE)

## to check the file : use the argument header = TRUE
## newRead <- read.table("tidyAverages.txt", header = TRUE)