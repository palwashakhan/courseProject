setwd('/Users/Palwasha/Documents/GitHub/CourseProject/UCI HAR Dataset/');
# 1. Merge the training and the test sets to create one data set.
# 2. Extract measurements on the mean and standard deviation for each measurement.
# 3. Name the activities in the data set.
# 4. Label data set with descriptive activity names.
# 5. Create a second independent tidy data set with the average of each variable for each activity and each subject.

# 1.
#read data
xTrain <- read.table("train/X_train.txt")
subjectTrain <- read.table("train/subject_train.txt")
yTrain <- read.table("train/y_train.txt")

#read test data
xTest <- read.table("test/X_test.txt")
subjectTest <- read.table("test/subject_test.txt")
yTest <- read.table("test/y_test.txt")

X <- rbind(xTrain, xTest)
S <- rbind(subjectTrain, subjectTest)
Y <- rbind(yTrain, yTest)

# 2. 

features <- read.table("features.txt")

# get columns with mean() or std() in their names
indices_features <- grep("-(mean|-std)\\(\\)", features[, 2])

# subset the desired columns
X <- X[, indices_features]

# correct the column names
names(X) <- features[indices_features, 2]



# 3. 

activity <- read.table("activity_labels.txt")

# update values with correct activity names
Y[,1] = activity[Y[,1], 2]

# correct column name
names(Y) <- "activity"

# 4. 

# correct column name
names(S) <- "subject"

# bind all the data in a single data set
cleaned <- cbind(S, Y, X)
write.table(cleaned, "merged.txt")

# 5. 

#activity & subject
uniqueSubjects = unique(S)[,1]
numSubjects = length(unique(S)[,1])
numActivities = length(activities[,1])
numCols = dim(cleaned)[2]
result = cleaned[1:(numSubjects*numActivities), ]

row = 1
for (s in 1:numSubjects) {
    for (a in 1:numActivities) {
        result[row, 1] = uniqueSubjects[s]
        result[row, 2] = activities[a, 2]
        tmp <- cleaned[cleaned$subject==s & cleaned$activity==activities[a, 2], ]
        result[row, 3:numCols] <- colMeans(tmp[, 3:numCols])
        row = row+1
    }
}
write.table(result, "tidyData.txt")
