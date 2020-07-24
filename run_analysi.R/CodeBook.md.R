library(dplyr)
##Cleaning the UCI HAR Dataset
# setting the working directory
setwd("C:/Users/Aman Jaiswal/Desktop/R/UCI HAR Dataset")
# reading the files from dir
activitys <- read.table("activity_labels.txt")
features <- read.table("features.txt")
# reading the test and train data
test <- read.table("./test/X_test.txt")
train <- read.table("./train/X_train.txt")
sub_test <- read.table("./test/subject_test.txt")
act_test <- read.table("./test/y_test.txt")
sub_train <- read.table("./train/subject_train.txt")
act_train <- read.table("./train/y_train.txt")
#4> Giving descriptive variable names
colnames(activitys) <- c("id", "activity")
colnames(features) <- c("id", "feature")
colnames(test) <- features[,2]
colnames(train) <- features[,2]
colnames(sub_test) <- "subject_id"
colnames(sub_train) <- "subject_id"
colnames(act_test) <- "activity"s
colnames(act_train) <- "activity"
#1> Binding the data in one data set
testbind <- cbind(sub_test, act_test, test)
trainbind <- cbind(sub_train, act_train, train)
final <- rbind(testbind, trainbind)
#3> Giving descriptive name to activities
for (i in 1:6){
  final[final[,2]==activitys[i,1],2] <- activitys[i,2]
}
#2> extracting only mean and standard deviation for each measurement
meanstd <- cbind(final[,grep(".+mean.+", colnames(final))],
                 final[,grep(".+std.+", colnames(final))])

#5> tidy data set with average of each var for each activity and each subject
tidy <- meanstd %>% group_by(subject_id, ativity) %>% summarise_all(mean)
write.table(tidydata, "TidyData.txt", row.name=FALSE)