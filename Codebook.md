The script in run_analysis.R has all steps to complete the Getting and Cleaning Data Course Project.
These steps are:

  1. Downloading data from "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip".
  2. Read the following data sets:
    * activity_labels.tx, 2 variables (id number and activity), 6 observations.
    * features.txt, 2 variables (a number identificator, name of the function), 561 observations.
    * subject_test.txt, subject_train.txt, 1 variable each one (subject identificator), 2947 and 7352 observations, respectively. 
    * X_test.txt, X_train.txt, 561 variables each one (functions), 2947 and 7352 observations, respectively.
    * y_test.txt, y_train.txt, 1 variable each one (id number of activity), 2947 and 7352 observations, respectively.
  
  3. Merge data:
    * By using rbind() function, the data frames: x (xTest, xTrain), y (yTest, yTrain) and subject (subjectTest, subjectTrain) were created.
    * Then mergeData data frame was created from x, y and subject data frames with the cbind() function. This data frame has 10299 observations and 563 variables.
  
  4. Select only variables which has mean or standard deviation values: 
    * First all dots were eliminated of variable names with gsub() function.
    * Then variables of mean and standard deviation were selected by using grepl() function.
    * The result was a new data frame named mean_stdDF (10299 observations, 88 variables).
    
  5. In mean_stdDF data frame activities were labeled with information from activitylabel data frame (second column)
  
  6. Appropriately labels of variables name in mean_stdDF data frame was assigned with the help of features_info.txt
  
  7. A new and final data set containing average of each variable by activity and subject was created with group_by() and summarize_all() functions.
     The resulting data was exported to a .txt archive with write.table() function.
    
