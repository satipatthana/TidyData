
#Tidy Data - Human Activity Recognition Using Smartphones Dataset

### READ ME

The UCI Center for Machine Learning and Intelligent Systems provides a Human Activity Recognition
database built from the recordings of 30 subjects performing  activities of daily living
while carrying a waist-mounted smartphone with embedded inertial sensors.

The file Codebook.md provides greater detail on the dataset.

The program run_analysis.R accomplishes the following tasks:

- Reads Activity Labels from file "activity_labels.txt" into data frame
- Reads 561 feature names from "features.txt" as data frame and stores in a list
- For TEST and TRAINING data
  - Reads experimental subject information ("subject_text.txt" and subject_train.txt")
  - Reads experimental activity information (y_test.txt" and "y_train.txt")
  - Reads 561 feature information from TEST data, and assigns names for 561 columns ("X_test.txt" and "X_train.txt")
  - Subsets features related to mean and standard deviation.  This provides 66 columns.
  - Creates a data frame that combines Subject, Activity, and 66 features
  - Converts values in Activity (e.g., 1,2 etc) column to descriptive Activity Labels (e.g., WALKING etc.)
- After conducting above operations separately for TEST and TRAINING data, the 2 sets are merged
- The merged data set is arranged by Subject id, from 1 to 30
- The resulting tidy data set has 66 feature elements for each of 10299 Subject/Activity combinations 
- The program then computes averages of each of the 66 variables for each Activity for each Subject
- The end result is a data frame with 180 rows (i.e. 30 Subjects time 6 Activities) for
  the 66 variables.
- Finally, the results after the last computation are stored in a text file, "TidyStep5.txt"

run_analysis.R can be executed if the following files are in the same directory:

- 'activity_labels.txt': Links the class labels with their activity name.
- 'features.txt': List of all features.
- 'subject_test.txt': Each row identifies the subject who performed the activity.
- 'y_test.txt': Test labels.
- 'X_test.txt': Test set.
- 'subject_train.txt': Each row identifies the subject who performed the activity.
- 'y_train.txt': Training labels.
- 'X_train.txt': Training set.
