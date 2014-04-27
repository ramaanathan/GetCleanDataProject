DataCleaning Project - README
=========================

### Script: run_analysis.R 
   * This script, reads in the given features, activities, test and training data sets and computes the average of the mean and sd of the various variables for each Subject's activities. 
   * Summary of script
      * The script first extracts only the columns corresponding to the mean and stand deviatons of the various variables
      * Next, the test and training sets are merged together
      * Finally, the averages of each column grouped by subject and activity are computed


### Input DataFiles:
   * activity_labels.txt (mapping activity ID to description - used as factors)
   * features.txt (features names that are used as column names for dataframe)
   * test/subject_test.txt (test subject IDs)
   * test/X_test.txt (2947 observations from the test dataset)
   * test/y_test.txt (activity associated with each test observation)
   * train/subject_train.txt (training subject Ids)
   * train/X_train.txt (7352 observation from the training dataset)
   * train/y_train.txt (activity associated with each training observation)
 
### Output DataFile:
   * data/averages - clean data set containing the averages of the mean and standard deviations of the differnet variables grouped by each subject and activity from the combined test and training data sets
 
### To run the project
source("run_analysis.R"")

