### samsung-har

***

Practical practice of my data collection, cleaning, and tidying skills using the UCI Machine Learning Repository "Human Activity Recognition Using Smartphones" dataset.  

You can find more information on the original dataset and research [here](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones).

***

The repo includes the following files:
* 'data/': Original dataset (README included)
* 'README.md'
* 'CodeBook.md'
* 'run_analysis.R': Script for obtaining the tidy datasets.
* 'samsung.txt': Tidy dataset before grouping and averaging
* 'summarized.txt': Tidy dataset after grouping and averaging

***

'run_analysis' follows these general steps:

1. Read in data
2. Merge test and train data into one data frame
3. Subset mean and standard deviation measurements
4. Gather features variables and separate into three variables:
	+ feature
	+ summary
	+ axis
5. Summarize by average of each summary for each axix, each feature, each activity, and each subject

More detailed information is commented into the script.