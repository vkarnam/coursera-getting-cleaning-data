The data given has readings collected from the accelerometers from the Samsung Galaxy S smartphone and has a vector consisting of 561 features. Experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. The file features_info.txt in the zipped dataset has this list of features.
The variables identify the unique subject/activity pair the variables relate to: Subject: the integer subject ID. Activity: the string activity name: Walking, Walking Upstairs, Walking Downstairs, Sitting, Standing and Laying.

Data - Transformation details

First step is to bring together the data from training and test datasets for each of activity, subject and features. 
Further the activity, subject and features data has to be combined. 
Extract dataset for required features (measurements on the mean and standard deviation for each measurement from the original feature vector set). This will result in the dataframe with 79 variables.
Assign descriptive activity names to name the activities in the data set. Labell the dataset with descriptive names.
A tidy data set is created with the average of each variable for each activity and each subject.


run_analysis.R - some important steps:

Data was brought together by row nbinding and column binding.
Mean and standard deviation column names and data were extracted using grep function.
Desired tidy data was generated using Aggregate and mean functions.
