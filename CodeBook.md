# CodeBook for the data stored in feature_averages_per_subject_activity.txt

This is the CodeBook for the course project for Coursera's Get and Clean Data class.

## Study design and data processing

The purpose of this project is to transform a subset of a messy data set into a tidy data set.
There is no study design for this project, because no study is conducted.

All of the data manipulations described in this CodeBook can be found in the following script:
* run_analysis.R

The script downloads the original data set, combines the original training and test data sets, and then constructs a tidy data set from a subset of the full original data set.

### Collection of the raw data.

The data set is downloaded from
* https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

Unzipping the data set creates a folder called "UCI HAR Dataset." 
Within that folder is a README.txt that explains how the raw data was collected and transformed
to construct the variables. There is no need to duplicate that information here, but for completness I have included some of the information at the end of this file.

### Combining test and train data

The original data set has two sets of files: training data files (subject_train.txt, X_train.txt, y_train.txt) and test data files (subject_test.txt, X_test.txt, y_test.txt).  
We combine the training and test data sets using OS level file manipulations (using the "cat" operation on a UNIX-based system). 

The resulting data sets are stored in three files:
* subject_all.txt
* X_all.txt
* y_all.txt



## Creating the tidy data file

The details for how the tidy data file is created are given in this repository's [README](README.md).

To summarize, the three tables (subject_all.txt, X_all.txt, and y_all.txt) are combined into a single table, observational variable names are altered to be more descriptive, and activity names are converted from strings into factors.  Some processing of the data (calculating the average of each observation variable grouped by subject and activity) is done, as described in the [README](README.md).

## Description of feature_averages_per_subject_activity.txt

The table has 180 rows and 68 columns (in addition to the header row). 

The first two columns are SubjectId and Activity, and each row has a unique (SubjectId, Activity) pair.  There are 30 unique SubjectIds and 6 unique Activities for a total of 30*6=180 rows.  

SubjectId is an integer in the range 1-30.

Activity is a factor with 6 Levels: Walking, WalkingUpstairs, WalkingDownstairs, Sitting, Standing, Laying.

The remaining columns correspond to the 66 observed variables that involve either a mean or a standard deviation.  For each variable, the value given in the table is the average of that variable over all observations for the given (SubjectId, Activity) pair.

Each of the observed variables is a double, normalized to be in the range [-1,1].

Each observed variable has the form

* DomainFilterVariable[Jerk]ComponentStatistic

where
* Domain is either "Time" or "Frequency"
* Filter is either "Body" or "Gravity"
* Variable is either "Acceleration" or "AngularVelocity"
* Jerk is optional (either "Jerk" or "")
* Component is either "X", "Y", "Z", or "Magnitude"
* Statistic is either "Mean" or "Std"

Not every possible combination allowed by the above rules is used.  There are 128 possible combinations, but only 66 correspond to actual observed variables (columns 3 through 68).

The observed variables (columns 3 through 68) are
* TimeBodyAccelerationXMean, TimeBodyAccelerationYMean, TimeBodyAccelerationZMean, TimeBodyAccelerationXStd, TimeBodyAccelerationYStd, TimeBodyAccelerationZStd, TimeGravityAccelerationXMean, TimeGravityAccelerationYMean, TimeGravityAccelerationZMean, TimeGravityAccelerationXStd, TimeGravityAccelerationYStd, TimeGravityAccelerationZStd, TimeBodyAccelerationJerkXMean, TimeBodyAccelerationJerkYMean, TimeBodyAccelerationJerkZMean, TimeBodyAccelerationJerkXStd, TimeBodyAccelerationJerkYStd, TimeBodyAccelerationJerkZStd, TimeBodyAngularVelocityXMean, TimeBodyAngularVelocityYMean, TimeBodyAngularVelocityZMean, TimeBodyAngularVelocityXStd, TimeBodyAngularVelocityYStd, TimeBodyAngularVelocityZStd, TimeBodyAngularVelocityJerkXMean, TimeBodyAngularVelocityJerkYMean, TimeBodyAngularVelocityJerkZMean, TimeBodyAngularVelocityJerkXStd,TimeBodyAngularVelocityJerkYStd, TimeBodyAngularVelocityJerkZStd, TimeBodyAccelerationMagnitudeMean, TimeBodyAccelerationMagnitudeStd, TimeGravityAccelerationMagnitudeMean, TimeGravityAccelerationMagnitudeStd, TimeBodyAccelerationJerkMagnitudeMean, TimeBodyAccelerationJerkMagnitudeStd, TimeBodyAngularVelocityMagnitudeMean, TimeBodyAngularVelocityMagnitudeStd, TimeBodyAngularVelocityJerkMagnitudeMean, TimeBodyAngularVelocityJerkMagnitudeStd, FrequencyBodyAccelerationXMean, FrequencyBodyAccelerationYMean, FrequencyBodyAccelerationZMean, FrequencyBodyAccelerationXStd, FrequencyBodyAccelerationYStd, FrequencyBodyAccelerationZStd, FrequencyBodyAccelerationJerkXMean, FrequencyBodyAccelerationJerkYMean, FrequencyBodyAccelerationJerkZMean, FrequencyBodyAccelerationJerkXStd, FrequencyBodyAccelerationJerkYStd, FrequencyBodyAccelerationJerkZStd, FrequencyBodyAngularVelocityXMean, FrequencyBodyAngularVelocityYMean, FrequencyBodyAngularVelocityZMean, FrequencyBodyAngularVelocityXStd, FrequencyBodyAngularVelocityYStd, FrequencyBodyAngularVelocityZStd, FrequencyBodyAccelerationMagnitudeMean, FrequencyBodyAccelerationMagnitudeStd, FrequencyBodyAccelerationJerkMagnitudeMean, FrequencyBodyAccelerationJerkMagnitudeStd, FrequencyBodyAngularVelocityMagnitudeMean, FrequencyBodyAngularVelocityMagnitudeStd, FrequencyBodyAngularVelocityJerkMagnitudeMean, FrequencyBodyAngularVelocityJerkMagnitudeStd

Descriptions of the meanings of the observed variables are given in the README.txt belonging to the original data set.

## Additional information from the Codebook for the original data set

Human Activity Recognition Using Smartphones Dataset
Version 1.0

Jorge L. Reyes-Ortiz, Davide Anguita, Alessandro Ghio, Luca Oneto.
Smartlab - Non Linear Complex Systems Laboratory
DITEN - Universit‡ degli Studi di Genova.
Via Opera Pia 11A, I-16145, Genoa, Italy.
activityrecognition@smartlab.ws
www.smartlab.ws

The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (Walking, Walking_Upstairs, Walking_Downstairs, Sitting, Standing, Laying) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain. See 'features_info.txt' for more details. 

### For each record it is provided:

- Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration.
- Triaxial Angular velocity from the gyroscope. 
- A 561-feature vector with time and frequency domain variables. 
- Its activity label. 
- An identifier of the subject who carried out the experiment.

### License (for original data set):
Use of this dataset in publications must be acknowledged by referencing the following publication [1] 

[1] Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012

This dataset is distributed AS-IS and no responsibility implied or explicit can be addressed to the authors or their institutions for its use or misuse. Any commercial use is prohibited.
