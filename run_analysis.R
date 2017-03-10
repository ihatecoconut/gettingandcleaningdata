Xtest <- read.table("X_test.txt")
Ytest <- read.table("y_test.txt")
subjecttest<-read.table("subject_test.txt")
Xtrain <- read.table("X_train.txt")
Ytrain <- read.table("y_train.txt")
subjecttrain<-read.table("subject_train.txt")
Xdata <- rbind(Xtest, Xtrain)
Ydata <- rbind(Ytest, Ytrain)
subjectdata <- rbind(subjecttest, subjecttrain)
features <- read.table("features.txt")
meanstdfeatures <- grep("-(mean|std)\\(\\)", features[, 2])
Xdata2 <- Xdata[, meanstdfeatures]
names(Xdata2) <- features[meanstdfeatures, 2]
activities <- read.table("activity_labels.txt")
Ydata[, 1] <- activities[Ydata[,1], 2]
names(Ydata) <- "activity"
names(subjectdata) <- "subject"
alldata <- cbind(Xdata2, Ydata, subjectdata)
avgalldata <- aggregate(. ~subject + activity, alldata, mean)
avgalldata2 <- avgalldata[order(avgalldata$subject, avgalldata$activity),]
write.table(avgalldata2, file="avgalldata2.txt", row.names = FALSE)
