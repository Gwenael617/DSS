CodeBook for the Getting and Cleaning Data Course Project
---------------------------------------------------------

This CodeBook describes the data, the variables, and any transformations or work performed to clean them up.

_The data studied measure the movement of two sets of subjects, randomly separated in a training set and a test set, performing six kind of activities. The run_analysis.R script reorganize the data in a tidy unique dataset._

### Summary
1. The data from the original data to the tidy data (general overview)
2. The variables
3. The transformations

----------------------

#### 1. The data : from the original data to the tidy data (general overview)

The original data unzip in a UCI HAR Dataset folder, which in turn contains :
  * a test folder
  * a train folder
  * an activity_labels text file
  * a features text file
  * a features_info text file
  * a ReadMe text file 

The ReadMe of the original data details the list of the files and what they contains.
It won't be reproduced here, however some  characteristics of the original data will be explained.

The test and train folder both contains an Inertial folder and three data text files (subject, X and Y).
The Inertial folder will not be used during this analysis as the relevant data are already in those three other text files :
  * the subject files list the id number of the subject performing the activities in the two other text files, this file will be used as the first column in our tidy data.
  * the X files contain the measurement, they will be put at the right hand side of our tidy data
  * the Y files contain the activities measured, they are coded with a number from 1 to 6, it will be put as the second column of our tidy data.

The activity_labels.txt will serve to replace the activity numbers by their real names.
The features.txt contains the name of the measurements and will serve to rename the columns three ff. (see [here](http://en.wiktionary.org/wiki/ff.) for the meaning of ff., I actually learnt this one today, so I thought I should share it with non-native english speakers)
_The `features_info.txt` gives information on the features and how they were originally named._

So in the end our tidy data will be shaped with :
  * first column : the subject id
  * second column : the activities measured for this subject
  * third column ff. : the measurements

#### 2. The variables

In the original data we have 563 variables :
  * the subject id, range from 1 to 30
  * the activity id, range from 1 to 6
  * 561 type of measurements

According to the tidy data principles, those variables will each be stored in one column.

At the beginning we have 10299 observations : 7352 in the training set and 2947 in the test set.
In the end (tidy data) we have 180 observations, one for each activity for each subject. Those 180 are the averages of the original ones.

Furthermore, only the mean and standard deviation (Sd) will be retained of the 561 initial measurements. So the tidy data will only contains 68 columns (the first two being the subject id and activity name, the following 66 being the mean of the measurements retains for the analysis for each subject and each activity).


#### 3. The transformations

  1. Firstly the test set and train sets are put back together :
    * we create two sets test and train, using the  cbind() function according to the order of column we want at the end (first column : the subject id, second column : the activities measured for this subject, third column ff.: the measurements)
    * the two sets are merged using the rbind() function. The order (test at the top and train at the bottom, or reverse) doesn't matter for the rest of the study.
  2. Secondly we extract the measurement of the mean and standard deviation only with the grep() function, using the features.txt as a comparison basis
  3. Then the activity ids are replaced by their real names :
    * the activity_labels.txt will serve as a reference
    * the name are first renamed in a more readable fashion using the gsub() function : a first capital letter followed by lower cases ones, and when the activity contains two words those will be separated by a space, as we're dealing with character class value the space won't be a problem in any future analysis. That's different from variable names that shouldn't contain spaces. It is however possible to collapse the space with an extra `gsub(" ","")` if one prefers it.
    * then the new names are subsituted  to their number id in the merged set created in the previous step.
  4. In order to label the data with appropriate variable names we're going to fetch the names of the measurements from the features.txt according to the condition described in step 2 (we only want the mean and standard deviation).
    * Once fetch those names will be transform to take care of the bad characters for variable names (get rid of parenthesis, hyphen ("-"), duplicate names), then they are rewritten in upper camel case in order to save some space while keeping them readable. (mean replaced by __M__ean, std replaced by its mathematical notation __S__d, t changed to Time and f to Freq).
    * I decided to not include the word axis after x, Y and Z to save some space. Similar thoughts lead to the non-replacement of Acc, Gyro and Mag are those are pretty understandable abbreviation of acceleration, gyroscopic mouvement and magnitude.
    * Once  those modifications finished, the script will clear the global environment of unused element
  5. The final tranformation requires the plyr package, compute the average of of each variable for each activity and each subject and write the final data set in a separate tidyAverages.txt file.



#### References :
* [The meaning of ff. abbreviation][Ref01]
* [The zip file containing the original data][Ref02]

[Ref01]: http://en.wiktionary.org/wiki/ff.
[Ref02]: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
