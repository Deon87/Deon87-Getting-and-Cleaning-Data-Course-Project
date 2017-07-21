run_analysis <- function() {
  
  setwd("C:/Users/Gideon87/Documents/R/UCI HAR Dataset")
  
  # Extract the features.txt into a datafram and parse its second column.
  
  Features <- read.table("features.txt")
  Features[,2] <- as.character(Features[,2])
  Features[,2] <- gsub("\\(|\\)","",Features[,2])
  Features[,2] <- gsub("-|,","_", Features[,2])
  


  
  ### Extract the subject_test.txt into a dataframe.
  Subject_Test<- read.table("test/subject_test.txt")
  colnames(Subject_Test)<-"Subject"
  
  
  #Extract the x_test.txt and y_test.txt into dataframes.
  
  X_Test<-read.table("test/X_test.txt")
  colnames(X_Test) <- Features[,2]
  
  Y_Test <- read.table("test/y_test.txt")
  colnames(Y_Test) <- "ActivityID"
  
  # Merges the Subject_Test, X_Test, and Y_Test dataframes together.
  
  Subject_XY_Test <- cbind(Subject_Test,Y_Test,X_Test)
  
  
  Mean_Std_ColNames <- c(1,2,grep("_mean_|_mean$|_std_|_std$",names(Subject_XY_Test)))
 
  
 # Only mean and standard deviation measurements are needed
  Dataset1 <- Subject_XY_Test[,Mean_Std_ColNames]
  
  
  # Extract train subject and activity in Dataframes.
  Subject_Train <- read.table("train/subject_train.txt")
  colnames(Subject_Train) <- "Subject"
  
  X_Train <- read.table("train/X_train.txt")
  colnames(X_Train) <- Features[,2]
  
  Y_Train <- read.table("train/y_train.txt")
  colnames(Y_Train) <- "ActivityID"
  
  # Merge the Subject_Train, X_Train,and Y_Train Datasets together.
  
  Subject_XY_Train <- cbind(Subject_Train,Y_Train,X_Train)
  
  # Only mean and standard deviation measurements are needed
  
  Trained_MeanStd_ColNames<- c(1,2,grep("_mean_|_mean$|_std_|_std$", names(Subject_XY_Train)))
  
  Dataset2 <- Subject_XY_Train[,Trained_MeanStd_ColNames]
  
  # Merging the Test and the Train Datasets together.
  Complete_Datasets <- rbind(Dataset1,Dataset2)
  
  
  # Extracts activity_labels.txt into a dataframe.
  Activity_Labels <- read.table("activity_labels.txt")
  Activity_Labels[ ,2] <- as.character(Activity_Labels[,2])
  
  colnames(Activity_Labels) <- c("ActivityID", "Activity_Name")
  
  
  # Joining Activity_Labels with the Complete_Datasets.
  Complete_Datasets <- merge(Activity_Labels, Complete_Datasets)
  Complete_Datasets$Activity_Name <- tolower(Complete_Datasets$Activity_Name)
  
  # Removes duplicated columns from Complete_Datasets.
  Duplicated_Columns <- names(Complete_Datasets) %in% c("ActivityID")
  Complete_Datasets<- Complete_Datasets[!Duplicated_Columns]
  
  # Use the aggregate() function to clean up Complete_Datasets.
  Tidy_Dataset <- aggregate(Complete_Datasets[,4:ncol(Complete_Datasets)], by=list(Subject=Complete_Datasets$Subject,Activity_Name=Complete_Datasets$Activity_Name), FUN=mean, na.rm=TRUE)
  
  Tidy_Dataset <- Tidy_Dataset[order(Tidy_Dataset$Subject,Tidy_Dataset$Activity_Name),]
  
  # The result is a tidy dataset in txt format.
  
  write.table(Tidy_Dataset, "tidy_data.txt", row.names=FALSE)
  
}
