### Codebook file for the project

### variables used
fileURL		contains link to a dataframe zip file
y_test		test data from test/y_test.txt file
y_train		train data from train/y_train.txt file
y_all		merged (rows merge) test and train data with renamed columns

X_test		test data from test/X_test.txt file
X_train		train data from train/X_train.txt file
X_all		merged (rows merge) test and train data with renamed columns

subject_test		test data from test/subject_test.txt file
subject_train		train data from train/subject_train.txt file
subject_all		merged (rows merge) test and train data with renamed columns

data			merged (column merge) y_all, X_all, subject_all data
tidy			data grouped by activity and subject with computed mean

### meaning of columns in tidy.txt
The meaning of columns in tidy.txt is the same as in original dataset, the first line contains column names from original dataset files
