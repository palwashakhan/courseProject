Introduction

The script runAnalysis.R performs the 5 steps described in the course project's definition.

The code merges the training and test sets to create one data set. All the similar data is merged using the rbind() function. 

The code then reads features.txt and extracts only the measurements on the mean and standard deviation for each measurement from the whole dataset. 

After extracting these columns, they are given the correct names, taken from features.txt.

Then the activity names and IDs are taken from activity_labels.txt and they are substituted in the dataset.

On the whole dataset, those columns with vague column names are corrected by giving more descriptive activity names.

Finally, we generate a new dataset with all the average measures for each subject and activity type. The output file is called tidyData.txt, and uploaded to this repository.

Original description: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones
