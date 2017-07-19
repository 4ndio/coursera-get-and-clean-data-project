# coursera-get-and-clean-data-project
Course project for Courera's Get and Clean Data class

This repository contains a single script called
* run_analysis.R

In summary, the script downloads data collected from accelerometers from the Samsung Galaxy S smartphone, and then contructs a tidy dataset as prescribed by the project instructions.  The resulting tidy dataset is named
* feature_averages_per_subject_activity.txt

The script downloads the dataset from 
* https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
into the working directory.  

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
    * MeanX -> XMean (and similarly for MeanY and MeanZ)
    * StdX -> XStd (and similarly for StdY and StdZ)
4. The feature names are further cleaned by removing all parentheses and dashes.
5. The activity names are transformed from strings into factors.
6. The measurement data in X_all.txt is partially loaded, with only the columns (feature names) containing "mean()" or "std()" being loaded.
7. The measurement data is combined with the data in subject_all.txt and y_all.txt using the cbind function.
8. The resulting table's columns are moved into the following ordering:
  * SubjectId, Activity, TimeBodyAccelerationMeanX, TimeBodyAccelerationMeanY, ... [64 more measurement variables]
