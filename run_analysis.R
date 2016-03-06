library(dplyr)
library(data.table)

# Read Activity Labels from file "activity_labels.txt" into data frame "actlabel"

    actlabel<-read.table("activity_labels.txt")

# Read 561 feature vector from "features.txt" into data frame "fnames"

    fnames<-read.table("features.txt")

#Store 561 variable names in a list, "flist", for use in future to name columns

    flist<-as.vector(fnames$V2)

# Read experimental subject information from TEST data, and give column name "Subject"

    subtest<-read.table("subject_test.txt")
    names(subtest)<-"Subject"

# Read experimental activity information from TEST data, and give column name "Activity"

    ytest<-read.table("y_test.txt")
    names(ytest)<-"Activity"

# Read 561 feature information from TEST data, and give names for 561 columns

    xtest<-read.table("X_test.txt")
    colnames(xtest)<-flist

# Select column names that relate to mean() and std().  meanFreq names excluded by regex..
# ..."mean[^a-zA-Z]()|std()".  This is Step 2 of the course project.
# Performing this operation first to reduce the number of columns that need to be merged..
#...with training data.  By doing this operation first, only 66 mean/std columns need...
#...to be merged rather than all 561 features.  Repeated operation for TRAIN data in...
#...in subsequent lines of code. 

    xtest<-xtest[,grep("mean[^a-zA-Z]()|std()",colnames(xtest))]

# Create data frame testdf

    testdf<-cbind(subtest,ytest,xtest)

# Convert values in Acitivty column from numbers to descriptive words (e.g., WALKING, LAYING etc.)
#....by matching with Activity Labels.  This is Step 3 of the course project.
# Repeat operation below for TRAIN data.

    testdf$Activity<-actlabel[,2][match(testdf$Activity,actlabel[,1])]


# Next 9 lines of code repeat process for TRAIN data

    subtrain<-read.table("subject_train.txt")
    names(subtrain)<-"Subject"
    ytrain<-read.table("y_train.txt")
    names(ytrain)<-"Activity"
    xtrain<-read.table("X_train.txt")
    colnames(xtrain)<-flist
    xtrain<-xtrain[,grep("mean[^a-zA-Z]()|std()",colnames(xtrain))]
    traindf<-cbind(ystrain,yttrain,xtrain)
    traindf$Activity<-actlabel[,2][match(traindf$Activity,actlabel[,1])]

# Merge TEST and TRAIN data frames and arrange them by Subject id.  This is Step 1 of the course project.
# Tidy data set contained in data frame "alldat"

    alldat<-rbind(testdf,traindf)
    alldat<-arrange(alldat,Subject)

# Calculate means by subject and activity for each of the 66 columns.
# This accomplished by first grouping "alldat" by Subject and Activity, followed by...
#...the summarise_each operation that calculates means for each of the 66 features.
# Data frame "ans" contains 180 rows (i.e. 30 subjects times 6 activites/subject)...
#...for each of the 66 features.

    sdat<-group_by(alldat,Subject,Activity)
    ans<-summarise_each(sdat,funs(mean))
    write.table(ans,"TidyStep5.txt",row.names=FALSE)
