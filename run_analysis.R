setwd("D:/STUDY/ONLINE COURSES/6. Getting and cleaning data")

##Download the file and put the file in the data folder and unzip the file

if(!file.exists("./data")){dir.create("./data")}
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl,destfile="./data/Dataset.zip",method="libcurl")
unzip(zipfile="./data/Dataset.zip",exdir="./data")

## Get the list of unzipped files

files<-list.files("./data/UCI HAR Dataset", recursive=TRUE)
files

## Read and merges the training and the test sets to create one data set

#Read and merge Fearures files
x.train<-read.table("./data/UCI HAR Dataset/train/X_train.txt",header = FALSE)
x.test<-read.table("./data/UCI HAR Dataset/test/X_test.txt",header = FALSE)
x.merge<-rbind(x.train, x.test)
# Read and merge subject files
subject.train <- read.table("./data/UCI HAR Dataset/train/subject_train.txt",header = FALSE)
subject.test <- read.table("./data/UCI HAR Dataset/test/subject_test.txt",header = FALSE)
subject.merge <- rbind(subject.train, subject.test)
# Read and merge activity files
y.train <- read.table("./data/UCI HAR Dataset/train/y_train.txt",header = FALSE)
y.test <- read.table("./data/UCI HAR Dataset/test/y_test.txt",header = FALSE)
y.merge<- rbind(y.train, y.test)


## Set names to variables

names(subject.merge)<-c("subject")
names(y.merge)<- c("activity")
FeaturesNames <- read.table("./data/UCI HAR Dataset/features.txt",head=FALSE)
names(x.merge)<- FeaturesNames$V2

## Merge all data to get a data frame 

data.merge<-cbind(x.merge,y.merge,subject.merge)

## Extracts only the measurements on the mean and standard deviation for each measurement

sub.FeaturesNames<-grep("mean\\(\\)|std\\(\\)", FeaturesNames$V2)
finaldata<-cbind(data.merge[,sub.FeaturesNames], subject=data.merge$subject, activity=data.merge$activity)

## Appropriately labels the data set with descriptive variable names
activityLabels <- read.table("./data/UCI HAR Dataset/activity_labels.txt",header = FALSE)
finaldata$activity<-factor(finaldata$activity, labels=c("WALKING","WALKING_UPSTAIRS","WALKING_DOWNSTAIRS","SITTING","STANDING","LAYING"), ordered=is.ordered(finaldata$activity))
names(finaldata)<-gsub("^t", "time", names(finaldata))
names(finaldata)<-gsub("^f", "frequency", names(finaldata))
names(finaldata)<-gsub("Acc", "Accelerometer", names(finaldata))
names(finaldata)<-gsub("Gyro", "Gyroscope", names(finaldata))
names(finaldata)<-gsub("Mag", "Magnitude", names(finaldata))
names(finaldata)<-gsub("BodyBody", "Body", names(finaldata))

##From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject

library(plyr)
finaldata1<-aggregate(. ~subject + activity, finaldata, mean)
finaldata1<-finaldata1[order(finaldata1$subject,finaldata1$activity),]
write.table(finaldata1, file = "tidydata.txt",row.name=FALSE)
