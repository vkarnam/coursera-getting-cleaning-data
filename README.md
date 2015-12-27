Getting and Cleaning Data: Course Project

The repository "Getting and Cleaning Data: Course Project" has the Code book, data details and the script I wrote to complete the course project for the course "Getting and Cleaning Data"

Data
Data given for the course project has test and Training set data for each of the Activity, subject, and Features data.
The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ
There are 561 features unlabeled are give in x_test.txt. The activity labels are listed in the y_test.txt file. The test subjects are in the subject_test.txt file.
Likewise training set also has similar structure.

run_analysis.R
This is the name of the file for the scripts.
All the files after unzipping the dataset were stored in a directory called "UCI HAR Dataset". After combining all the needed datasets, extracted only the columns with mean and standard deviation as asked. Created a tidy data containing the means of all the columns per test subject and per activity. This tidy dataset was written to a tab-delimited file called tidyData.txt, which can also be found in this repository.

About the Code Book
The CodeBook.md file contains the information on data, transformation details and other work performed to generate the tidyData.
