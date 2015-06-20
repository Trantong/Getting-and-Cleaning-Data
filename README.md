#Project's Purpose
The purpose of this project is to demonstrate your ability to collect, work with, and clean a data set. The goal is to prepare tidy data that can be used for later analysis. You will be graded by your peers on a series of yes/no questions related to the project. You will be required to submit: 1) a tidy data set as described below, 2) a link to a Github repository with your script for performing the analysis, and 3) a code book that describes the variables, the data, and any transformations or work that you performed to clean up the data called CodeBook.md. You should also include a README.md in the repo with your scripts. This repo explains how all of the scripts work and how they are connected.  

One of the most exciting areas in all of data science right now is wearable computing - see for example this article . Companies like Fitbit, Nike, and Jawbone Up are racing to develop the most advanced algorithms to attract new users. The data linked to from the course website represent data collected from the accelerometers from the Samsung Galaxy S smartphone. A full description is available at the site where the data was obtained: 

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 

Here are the data for the project: 

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

You should create one R script called run_analysis.R that does the following:  
1. Merges the training and the test sets to create one data set.   
2. Extracts only the measurements on the mean and standard deviation for each measurement.      
3. Uses descriptive activity names to name the activities in the data set         
4. Appropriately labels the data set with descriptive variable names.               
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject. 

#Description of the DATA
The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ. These time domain signals (prefix ‘t’ to denote time) were captured at a constant rate of 50 Hz. and the acceleration signal was then separated into body and gravity acceleration signals (tBodyAcc-XYZ and tGravityAcc-XYZ) – both using a low pass Butterworth filter.

The body linear acceleration and angular velocity were derived in time to obtain Jerk signals (tBodyAccJerk-XYZ and tBodyGyroJerk-XYZ). Also the magnitude of these three-dimensional signals were calculated using the Euclidean norm (tBodyAccMag, tGravityAccMag, tBodyAccJerkMag, tBodyGyroMag, tBodyGyroJerkMag).

A Fast Fourier Transform (FFT) was applied to some of these signals producing fBodyAcc-XYZ, fBodyAccJerk-XYZ, fBodyGyro-XYZ, fBodyAccJerkMag, fBodyGyroMag, fBodyGyroJerkMag. (Note the ‘f’ to indicate frequency domain signals).

Description of abbreviations of measurements

leading t or f is based on time or frequency measurements.
Body = related to body movement.
Gravity = acceleration of gravity
Acc = accelerometer measurement
Gyro = gyroscopic measurements
Jerk = sudden movement acceleration
Mag = magnitude of movement
mean and SD are calculated for each subject for each activity for each mean and SD measurements.
The units given are g’s for the accelerometer and rad/sec for the gyro and g/sec and rad/sec/sec for the corresponding jerks.

These signals were used to estimate variables of the feature vector for each pattern:
‘-XYZ’ is used to denote 3-axial signals in the X, Y and Z directions. They total 33 measurements including the 3 dimensions - the X,Y, and Z axes.

tBodyAcc-XYZ
tGravityAcc-XYZ
tBodyAccJerk-XYZ
tBodyGyro-XYZ
tBodyGyroJerk-XYZ
tBodyAccMag
tGravityAccMag
tBodyAccJerkMag
tBodyGyroMag
tBodyGyroJerkMag
fBodyAcc-XYZ
fBodyAccJerk-XYZ
fBodyGyro-XYZ
fBodyAccMag
fBodyAccJerkMag
fBodyGyroMag
fBodyGyroJerkMag

The set of variables that were estimated from these signals are:
mean(): Mean value
std(): Standard deviation

#Data Set Information:
The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data.

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows. From each window, a vector of features was obtained by calculating variables from the time and frequency domain.
#1.Get the data
####Download the file and put the file in the data folder and unzip the file
if(!file.exists("./data")){dir.create("./data")}                            
fileUrl<-"https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"                                        
download.file(fileUrl,destfile="./data/Dataset.zip",method="libcurl")    
unzip(zipfile="./data/Dataset.zip",exdir="./data")    
####Get the list of unzipped files
files<-list.files("./data/UCI HAR Dataset", recursive=TRUE)   
files

#2.Merges the training and the test sets to create one data set
####Read and merge Fearures files
x.train<-read.table("./data/UCI HAR Dataset/train/X_train.txt",header = FALSE)     
x.test<-read.table("./data/UCI HAR Dataset/test/X_test.txt",header = FALSE)      
x.merge<-rbind(x.train, x.test)    
####Read and merge subject files
subject.train <- read.table("./data/UCI HAR Dataset/train/subject_train.txt",header = FALSE)   
subject.test <- read.table("./data/UCI HAR Dataset/test/subject_test.txt",header = FALSE)   
subject.merge <- rbind(subject.train, subject.test)   
#### Read and merge activity files  
y.train <- read.table("./data/UCI HAR Dataset/train/y_train.txt",header = FALSE)  
y.test <- read.table("./data/UCI HAR Dataset/test/y_test.txt",header = FALSE)  
y.merge<- rbind(y.train, y.test)   

#3.Set names to variables
names(subject.merge)<-c("subject")                                                            
names(y.merge)<- c("activity")      
FeaturesNames <- read.table("./data/UCI HAR Dataset/features.txt",head=FALSE)     
names(x.merge)<- FeaturesNames$V2     
data.merge<-cbind(x.merge,y.merge,subject.merge)    

#4.Extracts only the measurements on the mean and standard deviation for each measurement
sub.FeaturesNames<-grep("mean\\(\\)|std\\(\\)", FeaturesNames$V2)       
finaldata<-cbind(data.merge[,sub.FeaturesNames], subject=data.merge$subject, activity=data.merge$activity)   

#5.Appropriately labels the data set with descriptive variable names
activityLabels <- read.table("./data/UCI HAR Dataset/activity_labels.txt",header = FALSE)    
finaldata$activity<-factor(finaldata$activity,labels=c("WALKING","WALKING_UPSTAIRS","WALKING_DOWNSTAIRS","SITTING","STANDING","LAYING"), ordered=is.ordered(finaldata$activity))   
names(finaldata)<-gsub("^t", "time", names(finaldata))    
names(finaldata)<-gsub("^f", "frequency", names(finaldata))   
names(finaldata)<-gsub("Acc", "Accelerometer", names(finaldata))    
names(finaldata)<-gsub("Gyro", "Gyroscope", names(finaldata))    
names(finaldata)<-gsub("Mag", "Magnitude", names(finaldata))    
names(finaldata)<-gsub("BodyBody", "Body", names(finaldata))   
#6.From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject   
library(plyr)   
finaldata1<-aggregate(. ~subject + activity, finaldata, mean)   
finaldata1<-finaldata1[order(finaldata1$subject,finaldata1$activity),]   
write.table(finaldata1, file = "tidydata.txt",row.name=FALSE)   

