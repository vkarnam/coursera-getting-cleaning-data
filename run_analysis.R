# This script merges data from a number of .txt files and produces 
## a tidy data set which may be used for further analysis.
getwd()
# Create a direcoty called "data" to save the data
if(!file.exists("./data")){dir.create("./data")}

# Readl the link given
Url1 <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"

# Download the data and save it to a destination file.
download.file(Url1, destfile = "./data/Dataset.zip")

# As data is in zip format unzip the files and extract files inside "data" folder

# unzip needs Which is the zip file and where to extract
unzip(zipfile = "./data/Dataset.zip",exdir = "./data")

# Check what are the files. These files are stored in UCI HAR Dataset folder
# Check list of files
path_dataset <- file.path("./data" , "UCI HAR Dataset")
list.files(path_dataset, recursive = TRUE)

# There are 28 txt files. List has a ReadMe file too
# - 'features_info.txt': Shows information about the variables used on the feature vector.
#  - 'features.txt': List of all features.
#  - 'activity_labels.txt': Links the class labels with their activity name.
#  - 'train/X_train.txt': Training set.
#  - 'train/y_train.txt': Training labels.
#  - 'test/X_test.txt': Test set.
#  - 'test/y_test.txt': Test labels.
# For each test and Training set
# there are Activity files 
# there are subject files and 
# there are Features files.
# The features selected for this database come from the accelerometer and 
# gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ
# __________________________________________________________________________________
#                     READ DATA FROM FILES
# ___________________________________________________________________________________

Activity_labels <- read.table(file.path(path_dataset, "activity_labels.txt"),header = FALSE, stringsAsFactors = F)
head(Activity_labels)

 
FeaturesNames <- read.table(file.path(path_dataset, "features.txt"),head = FALSE)
#FeaturesNames

#Column 2 of the Features file has the list of features.

# Activity files
Activity_Test <- read.table(file.path(path_dataset, "test", "Y_test.txt"), header = F)
# head(Activity_Test)
Activity_Train <- read.table(file.path(path_dataset, "train", "Y_train.txt"), header = F)
# head(Activity_Train)


# Subject files
Subject_Test <- read.table(file.path(path_dataset, "test", "subject_test.txt"), header = F)
#head(Subject_Test)
Subject_Train <- read.table(file.path(path_dataset, "train", "subject_train.txt"), header = F)
# head(Subject_Train)


# Feature files
Feature_Test <- read.table(file.path(path_dataset, "test", "X_test.txt"))
# head(Feature_Test)
Feature_Train <- read.table(file.path(path_dataset, "train", "X_train.txt"))
# head(Feature_Train)


# Check different parameters of these data
nrow((Activity_Test))
nrow((Activity_Train))
nrow(Subject_Test)
nrow(Subject_Train)
nrow(Feature_Test)
nrow(Feature_Train)

class((Activity_Test))
class((Activity_Train))
class(Subject_Test)
class(Subject_Train)
class(Feature_Test)
class(Feature_Train)

str((Activity_Test))
str((Activity_Train))
str(Subject_Test)
str(Subject_Train)
str(Feature_Test)
str(Feature_Train)

# __________________________________________________________________________________
# MERGE TRAINING AND TEST SETS TO CREATE ONE DATASET
#___________________________________________________________________________________
# merge tha data from Training and test files for Activity, Subject and
# Features. Set the names for the column(variable)

# ----------------
# MERGE BY ROWS
# ---------------
# Merge activity files and assign name to the column
Activity_Test_Train <-rbind(Activity_Train, Activity_Test)
# head(Activity_Test_Train)
# names(Activity_Test_Train)
# set name to the variable "V1"
names(Activity_Test_Train) <- c("activity")



# Merge subject files and assign name to the column
Subject_Test_Train <- rbind(Subject_Train, Subject_Test)
# head(Subject_Test_Train)
# names(Subject_Test_Train)
# set name to the variable "V1"
names(Subject_Test_Train) <- c("subject")



# Merge feature files and assign name to the column
Feature_Test_Train<- rbind(Feature_Train, Feature_Test)
# head(Feature_Test_Train)
names(Feature_Test_Train)
# nrow(Feature_Test)
# nrow(Feature_Train)
# Number of rows for merged data for Feature set = nrow(Feature_Test) + nrow(Feature_Train)
nrow(Feature_Test_Train)



# Assign these features listed in column 2 to Feature_Test_Train which is 
# the result of rbind(Feature_Train, Feature_Test)

# The "features.txt" was read above and assigned to "FeaturesNames"



names(Feature_Test_Train) <- FeaturesNames$V2
names(Feature_Test_Train)
head(Feature_Test_Train)
# nrow the columns in Feature_Test_Train got the names of different features



# ------------------
# MERGE BY COLUMNS
#-------------------

# Now all these files need to be merged. Merge Activity_Test_Train and Subject_Test_Train
# and merge the product with Feature_Test_Train

Subject_Activity_Data <- cbind(Subject_Test_Train,Activity_Test_Train)
# head(Subject_Activity_Data)
# ncol(Subject_Test_Train)
# ncol(Subject_Activity_Data)


Subject_Activity_Features_Data <- cbind(Feature_Test_Train, Subject_Activity_Data)

# ncol(Subject_Activity_Features_Data)
head(Subject_Activity_Features_Data)
      
# _______________________________________________________________________________________
# EXTRACT ONLY THE MEASUREMENTS ON THE MEAN AND STANDARD DEVIATION FOR EACH MEASUREMENT
#________________________________________________________________________________________

str(Subject_Activity_Features_Data)
 # 'data.frame':	10299 obs. of  563 variables
# This output now has 563 variables. The list can be obtained by below script
names(Subject_Activity_Features_Data)
# Some of the column names include the term mean or std in them.
# We need to pick the data only from these columns
Mean_Columns <- names(Subject_Activity_Features_Data)[grep("mean|std", names(Subject_Activity_Features_Data))]
MeanStd_Data <- Subject_Activity_Features_Data[c("subject", "activity", Mean_Columns)]


names(MeanStd_Data)
str(MeanStd_Data)
# data.frame':	10299 obs. of  79 variables:

# MeanStd_Data_SubAct <- Subject_Activity_Features_Data[grep("mean|std|subject|activity", names(Subject_Activity_Features_Data))]
# str(MeanStd_Data_SubAct)
# head(MeanStd_Data_SubAct)
# 'data.frame': 10299 obs. of  81 variables

#_______________________________________________________________________________
# USE DESCREIPTIVE ACTIVITY NAMES TO NAME ACTIVITIES IN DATA SET
#_______________________________________________________________________________

# The "activity_labels.txt" was read above and assigned to "Activity_labels"
Activity_labels

Activity_Desc <- Activity_labels$V2
MeanStd_Data$activity_desc <- Activity_Desc[MeanStd_Data$activity]

# Assign names for the column of Activity_labels
#colnames(Activity_labels)
DesiredData <- MeanStd_Data

# DesiredData <- merge(MeanStd_Data, Activity_labels, by = "activity")
# names(DesiredData)
# head(DesiredData)
# unique(DesiredData[,c("activity.y")])
# _______________________________________________________________________________
# Appropriately labels the data set with descriptive variable names
# ______________________________________________________________________________

# Descriptiva variable names
# for t -time, f- frequency, Gyro - Gyroscope, mag - Magnitude,
# BodyBody  by Body

names(DesiredData)<-gsub("^t", "time", names(DesiredData))
names(DesiredData)<-gsub("^f", "frequency", names(DesiredData))
names(DesiredData)<-gsub("Gyro", "Gyroscope", names(DesiredData))
names(DesiredData)<-gsub("Mag", "Magnitude", names(DesiredData))
names(DesiredData)<-gsub("Acc", "Accelerometer", names(DesiredData))
names(DesiredData)<-gsub("BodyBody", "Body", names(DesiredData))
names(DesiredData)

# ________________________________________________________________________________

# Creates a second,independent tidy data set and ouput it
# _______________________________________________________________________________
library(plyr)
tidyData <- aggregate(.~subject + activity_desc, DesiredData, mean)
tidyData<- tidyData[order(tidyData$subject,tidyData$activity_desc),]

# Delete activity column because we already have description in activity_desc column
tidyData$activity <- NULL
write.table(tidyData, file = "tidydata.txt",row.name=FALSE, sep="\t")
View(tidyData)


