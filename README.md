# README.md
Course project for Courera's Get and Clean Data class

## Overview

This repository contains a single script called
* run_analysis.R

In summary, the script downloads data collected from accelerometers from the Samsung Galaxy S smartphone, and then contructs a tidy dataset as prescribed by the project instructions.  The resulting tidy dataset is named
* feature_averages_per_subject_activity.txt

A detailed description of the tidy data file (feature_averages_per_subject_activity.txt) is givin in [CodeBook.md](CodeBook.md).

## Choices made regarding what is "tidy"



## Details of the script run_analysis.R

The script downloads the dataset from 
* https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
into the working directory.  

The training and test data sets are combined using system file manipulations (using the "cat" operation on a Mac). 

Here are the steps taken in run_analysis.R to create the tidy data file:

1. Using the list of features in features.txt, a list of feature names containing either "mean()" or "std()" is created (to be used later in step 6).
2. The feature names are altered to make the names more descriptive according to the following string transformations:
    * mean -> Mean
    * std -> Std
    *  Acc -> Acceleration
    *  Gyro -> AngularVelocity
    *  Mag -> Magnitude
    *  ^t -> Time (the ^ indicates beginning of feature name)
    *  ^f -> Frequency (the ^ indicates beginning of feature name)
    * BodyBody -> Body (the appearance of "BodyBody" instead of "Body" appears to be a mistake in the original data)
    * MeanX -> XMean (and similarly for MeanY and MeanZ)
    * StdX -> XStd (and similarly for StdY and StdZ)
3. The feature names are further cleaned by removing all parentheses and dashes.
4. The activity names are transformed from strings into factors.
5. The measurement data in X_all.txt is partially loaded, with only the columns (feature names) containing "mean()" or "std()" being loaded.
6. The measurement data is combined with the data in subject_all.txt and y_all.txt using the cbind function.
7. The resulting table has columns SubjectId, Activity, and 66 observational variable columns (features)
8. The table is "grouped by" (SubjectId, Activity), and then mean of each feature as calculated to construct a new table: data_averages.
9. Finally, the columns of data_averages are re-ordered into the following ordering:
  * SubjectId, Activity, TimeBodyAccelerationMeanX, TimeBodyAccelerationMeanY, ... [64 more measurement variables]


