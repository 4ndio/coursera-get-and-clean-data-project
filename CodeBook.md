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

### Collection of the raw data.

The data set was downloaded from
* https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

Unzipping the dataset by defualt creates a folder called "UCI HAR Dataset." 
Within that folder is a README.txt that explains how the raw data was collected and transformed
to construct the variables. There is no need to duplicated that information here.

## Creating the tidy datafile

### Guide to create the tidy data file Description on how to create the tidy data file (1. download the data, ...)/

### Cleaning of the data Short, high-level description of what the cleaning script does. link to the readme document that describes the code in greater detail

## Description of the variables in the tiny_data.txt file General description of the file including:

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

## Sources Sources you used if any, otherise leave out.

## Annex If you used any code in the codebook that had the echo=FALSE attribute post this here (make sure you set the results parameter to 'hide' as you do not want the results to show again)
