Getting and Cleaning Data - Course Project
==========================================

This repository contains my work for the Coursera Getting and Cleaning Data's course project.

#### Introduction

> _The purpose of this project is to demonstrate your ability to collect, work with, and clean a data set. The goal is to prepare tidy data that can be used for later analysis._
> (source : course project instructions)

The data studied represent data collected from the accelerometers from the Samsung Galaxy S smartphone. A full description is available at the site where the data was obtained: [Human Activity Recognition Using Smartphones](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones).

The data from the project can be downloaded [here](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip).

__The data studied measure the movement of two sets of subjects, randomly separated in a training set and a test set, performing six kind of activities. The run_analysis.R script reorganize the data in a tidy unique dataset.__

#### Content

This repository contains four files :
* This README,
* a codebook that describes the variables, the data, and any transformations or work performed to clean them up,
* the code to perform this cleaning : the run_analysis.R script,
* the cleaned and tidy data : tidyAverages.txt

_Note : this tidyAverages.txt should be read in R using the header=TRUE argument `read.table("tidyMeans.txt", header=TRUE)`_

#### Prerequisites
_(or how to run this code)_

* The data should be downloaded, unzipped and placed into your working directory.
* The run_analysis.R script goes __in the same working directory__, it should be outside of the UCI HAR Dataset folder.

* The script will __require the plyr package__. (_You may need to install this package if you hadn't before, then the script will load it automatically_)

* Warning : Due to the size of the original data sets the script can be a little long to run. However, it shouldn't be longer than two minutes.

#### Steps
_(what the code does, the explanations of the data are in the CodeBook)_

1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement. 
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names. 
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

#### References :
* The unvaluable [David's Project FAQ][Ref01]
* [Al Warren's Codebook vs. ReadMe differences][Ref02]
* [R pattern matching and replacement][Ref03]

_Note : The first two references are only accessible to participants of the 10th edition of this course._

[Ref01]: https://class.coursera.org/getdata-010/forum/thread?thread_id=49
[Ref02]: https://class.coursera.org/getdata-010/forum/thread?thread_id=150#post-676
[Ref03]: https://stat.ethz.ch/R-manual/R-patched/library/base/html/grep.html
