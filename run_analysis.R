# load the required libraries
library(base) # for grep
library(reshape2) # for melt and dcast

# function readTxtFile and return a table
readTxtFile <- function(fileName,...) {
  if(!file.exists(fileName)){
    stop("Error in opening file ",fileName)
    return(NULL)
  }
  txtDF <- read.table(fileName,...)
}

# read the activity_labels.txt - factor labels
activityLabels <- readTxtFile("data/activity_labels.txt",col.names=c("label#","description"))

# read the features.txt - column names for data
featureNames <- readTxtFile(featuresFile,col.names=c("feature#","name"))

# extract the feature numbers that have a mean() and sd()
desiredFeatures <- grep("*.-mean[^Freq]()|*.-std()",featureNames$name,value=TRUE,fixed=FALSE)
desiredColIndices <- grep("*.-mean[^Freq]()|*.-std()",featureNames$name,value=FALSE,fixed=FALSE)

# Read the test data
# read the subject_test.txt -subject IDs
testSubjects <- readTxtFile("data/test/subject_test.txt")

# read X_test.txt for all the test observations
testObs <- readTxtFile("data/test/X_test.txt",col.names=featureNames$name,check.names=FALSE)

# read Y_test.txt for the activity id
testActivityIds <- readTxtFile("data/test/Y_test.txt")
testActivities <- unlist(lapply(testActivityIds$V1,function(x) activityLabels$description[x]))

# We are only interested in columns that contain the mean and standard deviation
# so, use the desiredColIndices to create a secondary dataframe. 
# To this data frame, add the subjects and activities columns
testRecords <- cbind(Subjects=testSubjects$V1,Activities=testActivities,testObs[,desiredColIndices])

# # Read the test data
# read the subject_training.txt -subject IDs
trainingSubjects <- readTxtFile("data/train/subject_train.txt")

# read X_train.txt for all the test observations
trainingObs <- readTxtFile("data/train/X_train.txt",col.names=featureNames$name,check.names=FALSE)

# read Y_train.txt for the activity id
trainingActivityIds <- readTxtFile("data/train/Y_train.txt")
trainingActivities <- unlist(lapply(trainingActivityIds$V1,function(x) activityLabels$description[x]))

# We are only interested in columns that contain the mean and standard deviation
# so, use the desiredColIndices to create a secondary dataframe. 
# To this data frame, add the subjects and activities columns
trainingRecords <- cbind(Subjects=trainingSubjects$V1,Activities=trainingActivities,trainingObs[,desiredColIndices])

#merged records
mergedRecords <- rbind(testRecords,trainingRecords)

# use melt and dcast to compute the tidy data - averages by Subject and Activity
mergeMelt <- melt(mergedRecords,id=c("Subjects","Activities"),measure.vars=desiredFeatures)
tidyData<-dcast(mergeMelt,Subjects+Activities~variable,mean)

# record the data into a file
write.table(tidyData,"data/averages.txt")