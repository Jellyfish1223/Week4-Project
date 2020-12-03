# Week4-Project
run_analysis:
  opens a zip file "getdata_projectfiles_UCI HAR Dataset.zip" within the same database
  column names are gathered from "features.txt"
  activities are matched using "activity-labels.txt"
  collects the names of the files contained within the zip file into train_data and test_data
  avg_train and avg_test contain only columns from their respective train_data and test_data that contain either "mean" or "std"
  these avg dataframes are combined and saved as "Step5data.txt"
  the avg dataframes are grouped by subject then activity into grouped_train and grouped_test
  then summarised by mean and printed to the console
