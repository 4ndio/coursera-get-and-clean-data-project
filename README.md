# README.md
Course project for Courera's Get and Clean Data class

## Overview

This repository contains a single script called
* run_analysis.R

In summary, the script downloads data collected from accelerometers from the Samsung Galaxy S smartphone, and then constructs a tidy dataset as prescribed by the project instructions.  The resulting tidy data set is named
* feature_averages_per_subject_activity.txt

A detailed description of the tidy data file (feature_averages_per_subject_activity.txt) is givin in [CodeBook.md](CodeBook.md).

## Details of the script run_analysis.R

The script downloads the dataset from 
* https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip.  

The training and test data sets are combined using system file manipulations (using the "cat" operation on a Mac). 

Here are the steps taken in run_analysis.R to create the tidy data file:

1. Using the list of features in features.txt, a list of feature names containing either "mean()" or "std()" is created (to be used later in step 5).
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
8. The table is "grouped by" (SubjectId, Activity), and then a new table (data_averages) is constructed by calculating the mean of each feature over each group.
9. Finally, the columns of data_averages are re-ordered into the following ordering:
    * SubjectId, Activity, TimeBodyAccelerationMeanX, TimeBodyAccelerationMeanY, ... [64 more measurement variables]

## Choices made regarding what is "tidy data"

We had (at least) two options for the basic format of the tidy data:
1. Wide table (our choice), in which each "feature" in the original table remains a column variable.
2. Long table (not our choice), in which all of the original "features" become "factors" of a single column.
    * The single column could then be split into multiple columns, since the "features" really have sub-features like "t or f", "Acc or Gyro", "Body or Gravity", ect.

We chose the wide table format for two reasons:
1. In the wide format, each row corresponds to a complete set of measurements that are all measured together in a single trial. Each row is supposed to be a single "observation," and it is natural to have a single "trial" correspond to a single "observation," especially when there are multiple trials per (SubjectID, Activity) pair in the original data set.
2. The choice between wide and long format should be informed by the intended application.  A likely application of the data set is the use of a machine learning algorithm to predict the activity (stored in each row of y_test.txt) based on the corresponding set of measurements (stored in each row of X_test.txt).
    * Machine learning algorithms typically want the response (row of y_test.txt) to be in the same row as all of the predictors (row of X_test.txt). Thus, we should not split up the predictors into multiple rows.
    * The fact that the original data sets are labelled as "y" and "X" is hightly indicative that such a machine learning algorithm will be used ("y" and "X" are standard variable names for machine learning algorithms).
