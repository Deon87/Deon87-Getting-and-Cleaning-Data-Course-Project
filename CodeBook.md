                          Tidy Data CodeBook
                                By
                          Gideon Obeisun

# The Processing Steps

 - read.table()` - function used to import raw txt files into R Dataframes.
 
 - `gsub("\\(|\\),gsub("-|,","_",..),and grep("_std_|_std$|_mean_|_mean$)`, -  are used to name  the columns the two main dataframes which are for the training and testing datasets.
 
 - `write.table(...,row.names=FALSE)` - exporting tidy data into txt file format.

 - Other subsequent major data processing were performed with merge() and aggregate() functions. 

# Experimental Methods & Data

  The experimental methods and empirical data are described below from features_info.txt:

  > The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ. These time domain signals (prefix 't' to denote time) were captured at a constant rate of 50 Hz. Then they were filtered using a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise. Similarly, the acceleration signal was then separated into body and gravity acceleration signals (tBodyAcc-XYZ and tGravityAcc-XYZ) using another low pass Butterworth filter with a corner frequency of 0.3 Hz. 

 > Subsequently, the body linear acceleration and angular velocity were derived in time to obtain Jerk signals (tBodyAccJerk-XYZ and tBodyGyroJerk-XYZ). Also the magnitude of these three-dimensional signals were calculated using the Euclidean norm (tBodyAccMag, tGravityAccMag, tBodyAccJerkMag, tBodyGyroMag, tBodyGyroJerkMag). 

 > Finally a Fast Fourier Transform (FFT) was applied to some of these signals producing fBodyAcc-XYZ, fBodyAccJerk-XYZ, fBodyGyro-XYZ, fBodyAccJerkMag, fBodyGyroMag, fBodyGyroJerkMag. (Note the 'f' to indicate frequency domain signals). 

 > These signals were used to estimate variables of the feature vector for each pattern:  
'-XYZ' is used to denote 3-axial signals in the X, Y and Z directions.

> R program named run_analysis was used to analyze subset of the datasets from the experiment.The x_test, y_test, x_train, y_train, features,subject_train, subject_test, activity_labels.txt files are first extracted into dataframes and then merged into one dataframe called Complete_Datasets. This dataset was coded through these following procedures:

> 1. Variables or measurements of the means and standard deviations were extracted from the features.txt file into a dataframe using the read.table(),grep() functions and the resulting dataframe is named Mean_Std_ColNames.

> 2.The activity_labels.txt file is used to create a lookup table or list called Activity_Labels with a ActivityName=ActivityID format for future value reference or interchange.

> 3.ActivityID column in the Complete_Datasets dataframe is change to value in the ActivityName column of the Activity_Labels dataframe.

> 4. Column names in the Complete_Datasets are changed to meaningful names using the second column of the Features dataframe after been filtered by the sub() function.

> 5.A new dataset or dataframe called Tidy_Datasets is then created from the Complete_Datasets with results of the average of each variables for each empirical activity and subject of the experiment using aggregate() and order() functions.

> 6. The Tidy_Dataset is finally exported into a text file using write.table() and called tidy_data.txt, the final output of the coding project.




