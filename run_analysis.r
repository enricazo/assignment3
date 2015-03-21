#Getting and Cleaning Data
#Peer Assessments /Getting and Cleaning Data Course Project

#This R script called run_analysis.R that does the following.

#The data for the project is: getdata-Fprojectfiles-FUCI HAR Dataset.zip: 
#downloaded from:
#https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 


#1.-Merges the training and the test sets to create one data set.
#2.-Extracts only the measurements on the mean and standard deviation for each measurement.
#3.-Uses descriptive activity names to name the activities in the data set.
#4.-Appropriately labels the data set with descriptive variable names. 
#5.-From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

#Start in a clean environment
rm(list=ls())

#The library plyr is used
library(plyr)

#Establish working directoy
wdir <- getwd()
#Establish data directory
ddir <- paste(wdir, "/UCI HAR Dataset", sep="")
setwd(ddir)

#Function to read large files.
large_read <- function(infile) {
        read5rows <- read.table(infile, header = FALSE, nrows = 5)
        classes <- sapply(read5rows, class)
        tabAll <- read.table(infile, header = FALSE, colClasses = classes)
}

#list files in directory and read the tables into r with the same name
dir()
activity_labels <- large_read("activity_labels.txt")
features <- large_read("features.txt")

#Load train data
xtrain <- large_read("train/X_train.txt")
ytrain <- large_read("train/y_train.txt")
subject_train <- large_read("train/subject_train.txt")

#Load test data
xtest <- large_read("test/X_test.txt")
ytest <- large_read("test/y_test.txt")
subject_test <- large_read("test/subject_test.txt")

#Check dimensions of train and test read files
sapply(list(subject_train, ytrain, xtrain), dim)
sapply(list(subject_test, xtest, ytest), dim)

#STEP 3: Set descriptive activity names
activity_labels[,2] <- as.character(activity_labels[,2])
ytrain[,1] <- activity_labels[ytrain[,1],2]
ytest[,1] <- activity_labels[ytest[,1],2]

#STEP 4: Set colum names as descriptive variable names
names(subject_train)<-"subject"
names(subject_test)<-"subject"

names(ytrain)<-"activity_label"
names(ytest)<-"activity_label"

names(xtrain)<-features[,2]
names(xtest)<-features[,2]

#STEP 2:Extracts only the measurements on the mean and standard deviation for each measurement.
mean_std <- c(1:6,41:46,81:86,121:126,161:166,201:202,214:215,
              227:228,240:241,253:254,266:271,345:350,424:429,503:504,516:517,529:530,542:543)
train_data <- cbind(group="TRAIN",subject_train, ytrain, xtrain[,mean_std])
test_data <- cbind(group="TEST",subject_test, ytest, xtest[,mean_std])

#STEP 1: Merges the training and the test sets to create one data set
all_data <- rbind(train_data,test_data)

#STEP 5: Create a second, independent tidy data set with the average of each variable for each activity and each subject.
#Use ddply function to:
#Split data frame, apply function, and return results in a data frame
all_mean<-ddply(all_data, .(group,subject,activity_label), colwise(mean))
all_sd<-ddply(all_data, .(group,subject,activity_label), colwise(sd))

#Combine all evaluated data in a single dataframe
analysis_data <- cbind(all_mean,all_sd[,4:ncol(all_sd)])

#Restore initial working directory
setwd(wdir)

#Save output to file
write.table(analysis_data,"./analysis_data.txt",row.names = FALSE)
