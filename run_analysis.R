files <- unzip("getdata_projectfiles_UCI HAR Dataset.zip")
files<- files[-grep(("Inertial Signals"), files)]
train_files<-files[grep("train", files)]
test_files<-files[grep("test", files)]

train_data<-data.frame()
test_data<-data.frame()

X_train<-read.table(files[grep("X_train", files)])
y_train<-read.table(files[grep("y_train", files)])
subject_train<-read.table(files[grep("subject_train", files)])

X_test<-read.table(files[grep("X_test", files)])
y_test<-read.table(files[grep("y_test", files)])
subject_test<-read.table(files[grep("subject_test", files)])

train_data<-cbind(cbind(subject_train,y_train), X_train)
test_data<-cbind(cbind(subject_test, y_test), X_test)

features<-read.table(files[grep("features.txt", files)])
featurelist<- list("id", "activity")
featurelist<-append(featurelist,features[,2])
featurelist<-gsub("[\\(\\)]*[-]*","",featurelist)
featurelist<-gsub("^t","time",featurelist)
featurelist<-gsub("^f","freq",featurelist)
featurelist<-gsub("BodyBody","Body",featurelist)
test_data<-setNames(test_data, featurelist)
avg_test<-cbind(test_data[1:2], test_data[grep("mean|std", colnames(test_data))])
train_data<-setNames(train_data, featurelist)
avg_train<-cbind(train_data[1:2], train_data[grep("mean|std", colnames(test_data))])

activity_levels<-read.table(files[grep("activity_labels", files)])
avg_test$activity<-activity_levels$V2[match(avg_test$activity, activity_levels$V1)]
avg_train$activity<-activity_levels$V2[match(avg_train$activity, activity_levels$V1)]

write.table(rbind(avg_test,avg_train),file = "Step5data.txt", row.name=FALSE)

grouped_train<-group_by(avg_train, id, activity)
summarise_each(grouped_train, mean)
grouped_test<-group_by(avg_test, id, activity)
summarise_each(grouped_test, mean)
