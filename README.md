# README

This repository is for Getting & Cleaning data assignment of coursera.
The dataset used are from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

The processing done were:
1. Unzip the data file
2. There will be files under train and test folders
3. The relevant files to be merged and made tidy are:
- activity_labels.txt
- features.txt
- subject_test.txt under both folders
- X_test.txt under both folders
- y_test.txt under both folders
4. run_analysis.R contains the script required to perform the data processing and tidying