# GettingCleaningData
## This repo contains a single R script run_analysis.R that runs analysis on the Human Activity Recognition Using Smartphones Data Set which can be downloaded from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

## The script does the following tasks
* Imports from test dataset
* Imports from train dataset
* Add activities for each row to both datasets
* Add subjects fro each row to both datasets
* Imports variable names
* Create a subset of only mean and standard deviation variables
* Combine two datasets
* Create a list to filter by subject and activity
* Split data into a list based on subject and activity
* Calculate mean for each variable and place into new data table
* Write data to a text file
