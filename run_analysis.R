## Read test data and store in variables:
X_test<- read.table("UCI HAR Dataset/test/X_test.txt")
Y_test<- read.table("UCI HAR Dataset/test/Y_test.txt")
subject_test <-read.table("UCI HAR Dataset/test/subject_test.txt")

## Read train data and store in variables:
X_train<- read.table("UCI HAR Dataset/train/X_train.txt")
Y_train<- read.table("UCI HAR Dataset/train/Y_train.txt")
subject_train <-read.table("UCI HAR Dataset/train/subject_train.txt")

## Read features and activity data
features<-read.table("UCI HAR Dataset/features.txt")
activity_labels<-read.table("UCI HAR Dataset/activity_labels.txt")

## Part1 Merge test and train data of X
X_merge<-rbind(X_test, X_train)

## Part1 Merge test and train data of Y
Y_merge<-rbind(Y_test, Y_train)

## Part1 Merge subject_test and subject_train
Subject_merge<-rbind(subject_test, subject_train)

## Remove unuse data
rm(X_test)
rm(Y_test)
rm(X_train)
rm(Y_train)
rm(subject_test)
rm(subject_train)

## Part2 Extracts only the measurements on the mean and standard deviation for each measurement
index<-grep("mean\\(\\)|std\\(\\)", features[,2]) 
length(index) 
X_merge<-X_merge[,index] 

## Part3 Uses descriptive activity names to name the activities in the data set
Y_merge[,1]<-activity_labels[Y_merge[,1],2]

# Part4 Appropriately labels the data set with descriptive variable names
names<-features[index,2] ## getting names for variables
names(X_merge)<-names ## updating colNames for new dataset
names(Subject_merge)<-"SubjectID"
names(Y_merge)<-"Activity"
clean_data<-cbind(Subject_merge, Y_merge, X_merge)

## Part 5 Independent Tidy Dataset
tidy_data <- cleaned_data[order(cleaned_data$SubjectID, clean_data$Activity),]
write.table(tidy_data, file = "Tidy_Data.txt", row.names = FALSE)

