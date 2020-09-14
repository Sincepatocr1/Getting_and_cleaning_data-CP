######COURSE PROJECT####
library(plyr)
library(dplyr)


#Downloading and unzip data

if(!file.exists("Course project")){dir.create("./Course project")}
fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileURL, "./Course project/data.zip", method = "curl")
unzip("./Course project/data.zip")

#Reading data sets 

activityLabel <- read.table("./Course project/UCI HAR Dataset/activity_labels.txt", col.names = c("id", "activity"))
features <- read.table("./Course project/UCI HAR Dataset/features.txt", col.names = c("number", "function"))
head(activityLabel)
head(features)


##Test

subjectTest <- read.table("./Course project/UCI HAR Dataset/test/subject_test.txt", col.names = "subject")
xTest <- read.table("./Course project/UCI HAR Dataset/test/X_test.txt", col.names = features$function.)
yTest <- read.table("./Course project/UCI HAR Dataset/test/y_test.txt", col.names = "id")
head(subjectTest)
head(xTest)
head(yTest)

##Train
subjectTrain <- read.table("./Course project/UCI HAR Dataset/train/subject_train.txt", col.names = "subject")
xTrain <- read.table("./Course project/UCI HAR Dataset/train/X_train.txt", col.names = features$function.)
yTrain <- read.table("./Course project/UCI HAR Dataset/train/y_train.txt", col.names = "id")
head(subjectTrain)
head(xTrain)
head(yTrain)


##1. Merge training and test

x <- rbind(xTest, xTrain)
y <- rbind(yTest, yTrain)
subject <- rbind(subjectTest,subjectTrain)
mergedData <- cbind(x,y,subject)

##2. Measurments on the mean and standard deviations

names(mergedData)
col
colnames(mergedData) <- gsub("\\.", "", names(mergedData),)

mean_stdDF <- mergedData[,grepl("[Mm]ean|[Ss]td|id|subject",names(mergedData))]

##3. Name activities in the data set

mean_stdDF$id <- activityLabel[mean_stdDF$id, "activity"]
mean_stdDF$id

## 4. Appropriately labels the data set with descriptive variable names. 

names(mean_stdDF)
names(mean_stdDF) <- gsub("id", "Activity", names(mean_stdDF),)
names(mean_stdDF) <- gsub("^t", "Time", names(mean_stdDF),)
names(mean_stdDF) <- gsub("^f", "Frequency", names(mean_stdDF),)
names(mean_stdDF) <- gsub("subject", "Subject", names(mean_stdDF),)
names(mean_stdDF) <- gsub("Acc", "Accelerometer", names(mean_stdDF),)
names(mean_stdDF) <- gsub("mean", "Mean", names(mean_stdDF),)
names(mean_stdDF) <- gsub("std", "Std", names(mean_stdDF),)
names(mean_stdDF) <- gsub("Gyro", "Gyroscope", names(mean_stdDF),)
names(mean_stdDF) <- gsub("BodyBody", "Body", names(mean_stdDF),)
names(mean_stdDF) <- gsub("Mag", "Magnitude", names(mean_stdDF),)
names(mean_stdDF) <- gsub("angle", "Angle", names(mean_stdDF),)
names(mean_stdDF) <- gsub("gravity", "Gravity", names(mean_stdDF),)
##5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.


average_data <- summarize_all(group_by(mean_stdDF, Activity, Subject), funs(mean))

head(average_data)
str(average_data)

write.table(average_data, "./Course project/average_data.txt", row.name=FALSE)


