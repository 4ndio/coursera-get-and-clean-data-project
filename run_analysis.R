
library(dplyr)
library(data.table)

## Download the data
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl,destfile="acceldata.zip",method='curl')

## Unzip the data
unzip("acceldata.zip")

## The unzipped data is in folder "UCI HAR Dataset"
datafolder <- "UCI\\ HAR\\ Dataset"
trainfolder <- paste0(datafolder,"/train")
testfolder <- paste0(datafolder,"/test")

## Just use operating system calls to "cat" to combine the train and test data.
## This is bascially the same as using rbind() within R.
## Combined datasets are subject_all.txt, X_all.txt, and y_all.txt
system(paste0("cat ",
              paste0(trainfolder,"/subject_train.txt "),
              paste0(testfolder,"/subject_test.txt "),
              paste0("> subject_all.txt")))
system(paste0("cat ",
              paste0(trainfolder,"/X_train.txt "),
              paste0(testfolder,"/X_test.txt "),
              paste0(" > X_all.txt")))
system(paste0("cat ",
              paste0(trainfolder,"/y_train.txt "),
              paste0(testfolder,"/y_test.txt "),
              paste0(" > y_all.txt")))

## Load the subject number data
filename <- "subject_all.txt"
subjects <- fread(filename,col.names = c("SubjectId"))

## Load the activity data
filename <- "y_all.txt"
activities <- fread(filename,col.names = c("ActivityId"))

## Now load features.txt to figure out which features use mean()
filename <- paste0("UCI HAR Dataset","/features.txt")
features <- fread(filename,col.names = c("FeatureId","FeatureName"))

## Extract on the variables with names with substrings
## "mean()" or "std()".
features <- features[grepl("mean\\(\\)",features$FeatureName)
                     | grepl("std\\(\\)",features$FeatureName)]

## Tidy the feature names (make lowercase, remove parentheses, remove dashes)
features$FeatureName <- gsub("mean","Mean",features$FeatureName)
features$FeatureName <- gsub("std","Std",features$FeatureName)
features$FeatureName <- gsub("Acc","Acceleration",features$FeatureName)
features$FeatureName <- gsub("Gyro","AngularVelocity",features$FeatureName)
features$FeatureName <- gsub("Mag","Magnitude",features$FeatureName)
features$FeatureName <- gsub("^t","Time",features$FeatureName)
features$FeatureName <- gsub("^f","Frequency",features$FeatureName)
features$FeatureName <- gsub("\\(\\)","",features$FeatureName)
features$FeatureName <- gsub("-","",features$FeatureName)
## Swap the order of Mean (or Std) with the component label (X, Y or Z)
features$FeatureName <- gsub("(Mean|Std)([XYZ])$","\\2\\1",features$FeatureName)
# Wierdly, some of the feature names are wrong in the raw data:
# "BodyBody" appears when it should just by "Body".
# So, we remove the extra "Body"...
features$FeatureName <- gsub("BodyBody","Body",features$FeatureName)

## Load the activity names
filename <- paste0("UCI HAR Dataset","/activity_labels.txt")
activitynames <- fread(filename,col.names = c("ActivityId","Activity"))
## Change the formatting of the the activitynames from ALL CAPS to
## something more readable.
orderedlistofactivities <- c("Walking",
                             "WalkingUpstairs",
                             "WalkingDownstairs",
                             "Sitting",
                             "Standing",
                             "Laying") 
## Using the "levels" argument below ensures that the levels within
## the factor keep the original order (so activiyid is the
## same as the level number).
activitynames$Activity <- factor(orderedlistofactivities,
                                 levels=orderedlistofactivities)


## Load the variable data from X_all.txt, but only
## keep the columns determined by our features table
## (which only inludes mean and std variables).
filename <- "X_all.txt"
data <- fread(file=filename,select=features$FeatureId,col.names=features$FeatureName)

## Combine the three tables: subjects, activities, data
## Doing so assumes that the order of the rows has been
## previsously preserved.
data <- cbind(subjects,activities,data)

## Marge data table with activitynames table to match 
## ActivityId with Activity
data <- merge(data,activitynames,by="ActivityId",sort=FALSE)

## Reorder the columns. Warning: I hardcode the column indices.
data <- data[,c(2,69,3:68)]

## Group by suubject and activity, take mean of measuruemts
## Save in a data.table called data_averages
data_averages <- 
      data %>%
      group_by(SubjectId,Activity) %>%
      summarize_all(funs(mean))

## Write data_averages as a .txt file
filename = "feature_averages_per_subject_activity.txt"
write.table(data_averages,file=filename,row.names=FALSE)

