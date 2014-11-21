# CodeBook.md

The script "run_analysis.R" takes the raw dataset found [here](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip) and creates two tidy datasets:
* "samsung.txt": Before grouping and averaging
* "summarized.txt": After grouping and averaging

For the purposes of this codebook, only information regarding "summarized.txt" will be included.

I chose two create a tall dataset. I accomplished this by splitting the original "features.txt" observations along the "-" character into three variables:
* features
* axis
* summary

The codebook is structured using the following format:

###### Variable
Description: An outline of what the variable measures

Source: The file(s) from the raw dataset which 
contributed to creating the variable

Class: the class of the object

Values: the range of observations
###

###### subject
Description: Subject who performed the activity

Source:
* "test/subject_test.txt"
* "train/subject_train.txt"

Class: Factor (Unordered)

Values: 1:30
###

###### activity
Description: Action being performed by the subject

Source:
* "activity_labels.txt"
* "test/y_test.txt"
* "train/y_train.txt"

Class: Factor (Unordered)

Values:
* "walking"
* "walking_upstairs"
* "walking_downstairs"
* "sitting"
* "standing"
* "laying"
###

###### feature
Description: Domain signals for accelerometer and gyroscope measurements. feature names contain two parts:
1. Domain Signal Type: Either 't' for time domain signal or 'f' for frequency domain signal
2. Signal: What is being measured

Source:
* "features.txt"
* "test/X_test.txt"
* "train/X_train.txt"

Class: Factor (Unordered)

Values:
* "fBodyAcc": Frequency body acceleration
* "fBodyAccJerk": Frequency body acceleration jerk
* "fBodyAccMag": Frequency body acceleration magnitude
* "fBodyBodyAccJerkMag": Frequency body acceleration jerk magnitude
* "fBodyBodyGyroJerkMag": Frequency body gryoscope jerk magnitude
* "fBodyBodyGyroMag": Frequency body gyroscope magnitude
* "fBodyGyro": Frequency body gyroscope signal
* "tBodyAcc": Time body gyroscope signal
* "tBodyAccJerk": Time body acceleration jerk
* "tBodyAccJerkMag": Time body acceleration jerk magnitude
* "tBodyAccMag": Time body acceleration magnitude
* "tBodyGyro": Time body gyroscope signal
* "tBodyGyroJerk": Time body gyroscope jerk
* "tBodyGyroJerkMag": Time body gyroscope jerk maginitude
* "tBodyGyroMag": Time body gyroscope magnitude
* "tGravityAcc": Time gravity acceleration
* "tGravityAccMag": Time gravity acceleration magnitude
###

###### axis
Description: The axis on which the feature is measured

Source:
* "features.txt"
* "test/X_test.txt"
* "train/X_train.txt"

Class: Factor (Unordered)

Values:
* "x"
* "y"
* "z"
* "all": Stand-in for magnitude features
***

###### summary
Description: Summary statistic

Source:
* "features.txt"
* "test/X_test.txt"
* "train/X_train.txt"

Class: Factor (Unordered)

Values:
* "mean"
* "std" = Standard deviation
***

###### average
Description: Mean of all records matching variables of that row

Source:
* "test/X_test.txt"
* "train/X_train.txt"

Class: Numeric

Values: Bounded between [-1, 1]