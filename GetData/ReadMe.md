Following are the Key steps of analysis

1.load Training & test data for X, Y & Subject 
2. load variable name and Activity Name	from "features.txt" & "activity_labels.txt"
3. Merge Training and Test data these will result in 3 Data frame X, Y & Subject	
5. Merge Subject, Activity and X data to form Complete data frame "Complete_data"
6. Create vector of col number containing mean and standard deviation in "Complete_data"
7. Subset "Complete_data"  frame based on Sorted col number for	containing mean and standard deviation data resulting in "Complete_data_sorted"
8. Assign Activity name in col 3 of "Complete_data_sorted"
9. Assign Col Name 
10. Create New tidy data set with the average of each variable for each activity and each subject.	
11. Write tiday data set into "tidy_data_set.txt"