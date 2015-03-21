# assignment3
Getting and Cleaning Data. Assignment 3 repository with script, codebook and instructions.

The following files are uploaded to GITHUB

analysis_data.txt	The resulting data analysis
CodeBook.md			a DATA DICTIONARY - analysis_data
run_analysis.R		the script used to generate the analysis_data.txt file.

The script was run using Rstudio with R3.1.3 under windows-8
The folder containing the script should contain the original data folder as well (UCI HAR Dataset)

The script works as follows (use Rstudio and source it in a folder where it is also present "UCI HAR Dataset"
-Loads files and checks dimensions of them (in order to merge them correctly)
-Then it follows the requested steps in the following order: (note that order has been altered to load first the names)
#STEP 3: Set descriptive activity names
#STEP 4: Set colum names as descriptive variable names
#STEP 2:Extracts only the measurements on the mean and standard deviation for each measurement.
#STEP 1: Merges the training and the test sets to create one data set
#STEP 5: Create a second, independent tidy data set with the average of each variable for each activity and each subject.
