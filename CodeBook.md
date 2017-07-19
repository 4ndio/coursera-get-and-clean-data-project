# Codebook for the data stored in feature_averages_per_subject_activity.txt
Course project for Courera's Get and Clean Data class

This repository contains a single script called
* run_analysis.R

In summary, the script downloads data collected from accelerometers from the Samsung Galaxy S smartphone, and then contructs a tidy dataset as prescribed by the project instructions.  The resulting tidy dataset is named
* feature_averages_per_subject_activity.txt

The script downloads the dataset from 
* https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
into the working directory.  

Short description of the project

## Study design and data processing

The purpose of this project is to transform a subset of a messy data set into a tidy dataset.
There is no study design for this project, because no study is conducted.

All of the data manipulations described in this CodeBook can be found in the script
* run_analysis.R
Included in the script are the 
downloading of the original data and the combining of the test and train data sets).

### Collection of the raw data.

The data set is downloaded from
* https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

Unzipping the data set creates a folder called "UCI HAR Dataset." 
Within that folder is a README.txt that explains how the raw data was collected and transformed
to construct the variables. There is no need to duplicate that information here.

### Combining test and train data

The original data set has two sets of files: training data files (subject_train.txt, X_train.txt, y_train.txt) and test data files (subject_test.txt, X_test.txt, y_test.txt).  
We combine the training and test data sets using OS level file manipulations (using the "cat" operation on a UNIX-based system). 

The resulting data sets are stored in three files:
* subject_all.txt
* X_all.txt
* y_all.txt

## Creating the tidy datafile

Here are the steps taken in run_analysis.R to create the tidy data file:
1. As described above, the original data is downloaded and combined.
2. Using the list of features in features.txt, a list of feature names containing either "mean()" or "std()" is created (to be used later in step 6).
3. The feature names are altered to make the names more descriptive according to the following string transformations:
  * mean -> Mean
  * std -> Std
  *  Acc -> Acceleration
  *  Gyro -> AngularVelocity
  *  Mag -> Magnitude
  *  ^t -> Time (the ^ indicates beginning of feature name)
  *  ^f -> Frequency (the ^ indicates beginning of feature name)
  * BodyBody -> Body (the appearance of "BodyBody" instead of "Body" appears to be a mistake in the original data)
4. the feature names are further cleaned by removing all parentheses and dashes.
5. The activity names are transformed from strings to factors.
6. The measurement data in X_all.txt is loaded, with only the columns (feature names) containing "mean()" or "std()" loaded.
7. The measurement data is combined with the data in subject_all.txt and y_all.txt using the cbind function.
8. The resulting table's columns are moved into the following ordering:
  * SubjectId, Activity, TimeBodyAccelerationMeanX, TimeBodyAccelerationMeanY, ... [64 more measurement variables]

### Cleaning of the data Short, high-level description of what the cleaning script does. link to the readme document that describes the code in greater detail

## Description of the table stored in feature_averages_per_subject_activity.txt

The table has 180 rows and 68 columns. 

The first two columns are SubjectId and Activity, and each row has a unique (SubjectId,Activity) pair.  There are 30 unique SubjectIds and 6 unique Activities for a total of 30*6=180 rows.  

The remaining columns correspond to the 66 observed variables that involve either a mean or standarda deviation.  The values given in each column is the average of that variable over all observations for that (SubjectId, Activity) pair.

Each observed variable has the form
* DomainFilterVariable[Jerk]MagnitudeStatistic
where
* Domain is either "Time" or "Frequency"
* Filter is either "Body" or "Gravity"
* Variable is either "Acceleration" or "AngularVelocity"
* Jerk is optional (is either "Jerk" or "")
* Component is either "X", "Y", "Z", or "Magnitude"
* Statistic is either "Mean" or "Std"

Not every possible combination allowed by the above rules is used.  The are 128 possible combinations, but only 66 correspond to actual observed variables (columns).

The observed variables (columns) are
* TimeBodyAccelerationXMean, TimeBodyAccelerationYMean, TimeBodyAccelerationZMean, TimeBodyAccelerationXStd, TimeBodyAccelerationYStd, TimeBodyAccelerationZStd, TimeGravityAccelerationXMean, TimeGravityAccelerationYMean, TimeGravityAccelerationZMean, TimeGravityAccelerationXStd, TimeGravityAccelerationYStd, TimeGravityAccelerationZStd, TimeBodyAccelerationJerkXMean, TimeBodyAccelerationJerkYMean, TimeBodyAccelerationJerkZMean, TimeBodyAccelerationJerkXStd, TimeBodyAccelerationJerkYStd, TimeBodyAccelerationJerkZStd, TimeBodyAngularVelocityXMean, TimeBodyAngularVelocityYMean, TimeBodyAngularVelocityZMean, TimeBodyAngularVelocityXStd, TimeBodyAngularVelocityYStd, TimeBodyAngularVelocityZStd, TimeBodyAngularVelocityJerkXMean, TimeBodyAngularVelocityJerkYMean, TimeBodyAngularVelocityJerkZMean, TimeBodyAngularVelocityJerkXStd,TimeBodyAngularVelocityJerkYStd, TimeBodyAngularVelocityJerkZStd, TimeBodyAccelerationMagnitudeMean, TimeBodyAccelerationMagnitudeStd, TimeGravityAccelerationMagnitudeMean, TimeGravityAccelerationMagnitudeStd, TimeBodyAccelerationJerkMagnitudeMean, TimeBodyAccelerationJerkMagnitudeStd, TimeBodyAngularVelocityMagnitudeMean, TimeBodyAngularVelocityMagnitudeStd, TimeBodyAngularVelocityJerkMagnitudeMean, TimeBodyAngularVelocityJerkMagnitudeStd, FrequencyBodyAccelerationXMean, FrequencyBodyAccelerationYMean, FrequencyBodyAccelerationZMean, FrequencyBodyAccelerationXStd, FrequencyBodyAccelerationYStd, FrequencyBodyAccelerationZStd, FrequencyBodyAccelerationJerkXMean, FrequencyBodyAccelerationJerkYMean, FrequencyBodyAccelerationJerkZMean, FrequencyBodyAccelerationJerkXStd, FrequencyBodyAccelerationJerkYStd, FrequencyBodyAccelerationJerkZStd, FrequencyBodyAngularVelocityXMean, FrequencyBodyAngularVelocityYMean, FrequencyBodyAngularVelocityZMean, FrequencyBodyAngularVelocityXStd, FrequencyBodyAngularVelocityYStd, FrequencyBodyAngularVelocityZStd, FrequencyBodyAccelerationMagnitudeMean, FrequencyBodyAccelerationMagnitudeStd, FrequencyBodyAccelerationJerkMagnitudeMean, FrequencyBodyAccelerationJerkMagnitudeStd, FrequencyBodyAngularVelocityMagnitudeMean, FrequencyBodyAngularVelocityMagnitudeStd, FrequencyBodyAngularVelocityJerkMagnitudeMean, FrequencyBodyAngularVelocityJerkMagnitudeStd


Dimensions of the dataset
Summary of the data
Variables present in the dataset
(you can easily use Rcode for this, just load the dataset and provide the information directly form the tidy data file)

### Variable 1 (repeat this section for all variables in the dataset) Short description of what the variable describes.

Some information on the variable including:

Class of the variable
Unique values/levels of the variable
Unit of measurement (if no unit of measurement list this as well)
In case names follow some schema, describe how entries were constructed (for example time-body-gyroscope-z has 4 levels of descriptors. Describe these 4 levels).
(you can easily use Rcode for this, just load the dataset and provide the information directly form the tidy data file)

#### Notes on variable 1: If available, some additional notes on the variable not covered elsewehere. If no notes are present leave this section out.

