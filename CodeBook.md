Title
========================================================

### Input DataFiles:
   * activity_labels.txt (mapping activity ID to description - used as factors)
   * features.txt (features names that are used as column names for dataframe)
   * test/subject_test.txt (test subject IDs)
   * test/X_test.txt (2947 observations from the test dataset)
   * test/y_test.txt (activity associated with each test observation)
   * train/subject_train.txt (training subject Ids)
   * train/X_train.txt (7352 observation from the training dataset)
   * train/y_train.txt (activity associated with each training observation)
 
### Intermediate dataframes created
* activityLabels:
   * label#: Identifying activity label
   * description: Descriptive name of the activity - this is used in the final tidy data frame
   
* featureNames: A feature here corresponds to the various estimated measures of each variable. There are a total of 516 features. Details are in the input features_info.txt 
   * feature#: feature ID
   * name: descriptive feature name
* desiredFeatures: a vector containing feature names that correspond to only the mean and standard deviation estimates of the various variables. This vector is used as the colnames for the extracted dataset 
   * 66 desired features
* desiredColIndices: a vector containing the featureIds that correspond to only the mean and standard deviation estimates of the various variables. This vector is used to create a subset of the test and training data frames


* testSubjects: dataframe containing the Ids of the test subjects
* trainingSubjects: dataframe containing the Ids of the training subjects

* testActivities: factor containing the descriptive name of the activities conducted by each test subject
* trainingActivities: factor containing the descriptive name of the activities conducted by each training subject

* testObs: dataframe created directly by reading in the X-test.txt
   * 2947 rows, 561 columns
* trainingObs: dataframe created directly by reading in the X-training.txt
   * 7352 rows, 561 columns
* testRecords: dataframe created by combining the testSubjects, testActivitites and the desired columns from the testObs - using cbind
   * 2947 rows, 68 columns
* trainingRecords: dataframe created by combining the trainingSubjects, trainingActivitites and the desired columns from the trainingObs - using cbind
   * 7352 rows, 68 columns
* mergedRecords: dataframe created by combining the testRecords and trainingRecords using rbind
   * 10,299 rows, 68 columns

### Creating tidy dataset
* Process used: 
   * melt over two ids - Subjects and activities
   * dcast over Sibjects + activities to compute the mean of each variable
* The final tidy dataset is grouped by the 30 subjects and their 6 individual activities - total of 180 rows.
   * Subjects: subject ID (range: 1 to 30)
   * Activities: one of 6 activities
   * Each row contains the average of each selected feature - mean is computed for each activity for each individual - For example, row 1, column3, contains the average of tBodyAcc-mean()-X for subject 1 while laying

 
### Output file   
* data/averages.txt - final tidy data outfile
   * First line is a header 
   * followed by 180 rows of average values for each selected measure of the different activities
   

