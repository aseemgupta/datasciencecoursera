run_analysis <- function() {

#load data

	X_train <- read.table("data/train/X_train.txt")

	Y_train <- read.table("data/train/y_train.txt")

	Subject_train <- read.table("data/train/subject_train.txt")

	X_test <- read.table("data/test/X_test.txt")

	Y_test <- read.table("data/test/y_test.txt")

	Subject_test <- read.table("data/test/subject_test.txt")

#load variable name and Activity Name	
	X_names<- read.table("data/features.txt")

	Y_names<- read.table("data/activity_labels.txt")

#Merge Training and Test data	
	Subject<-rbind(Subject_test,Subject_train)

	X<-rbind(X_test,X_train)

	Y<-rbind(Y_test,Y_train)

# update Col name of subjest and activity	
	names(Subject)<-"Subject"
	names(Y)<-"Activity"

#Merge Subject, Activity and X data
	Complete_data<-cbind(Subject,Y,Y,X)

	
#Create vector of col number containing mean and standard deviation
	X_names_mean<-X_names[grep("mean",X_names$V2),]

	X_names_std<-X_names[grep("std",X_names$V2),]

	X_names_sorted<-rbind(X_names_mean,X_names_std)

	X_names_sorted<-X_names_sorted[order(X_names_sorted$V1),]
	
#Subset data based on Sorted col number for	containing mean and standard deviation data

	Complete_data_sorted<-Complete_data[,c(1,2,3,X_names_sorted$V1+3)]

# Assign activity name	
	Complete_data_sorted$Activity.1 <- as.character(Complete_data_sorted$Activity.1)

	Y_names$V1 <- as.character(Y_names$V1)
	Y_names$V2 <- as.character(Y_names$V2)
	
	for (i in 1:6) {

		Complete_data_sorted$Activity.1[Complete_data_sorted$Activity.1==Y_names[i,1]] <- Y_names[i,2]

	}

# Assign Col name
	df_temp<-data.frame()
	df_temp[1,1]<-1
	df_temp[1,2]<-"Subject"
	df_temp[2,2]<-"Activity"
	df_temp[3,2]<-"Activity.Name"

	df_name<-rbind(df_temp,X_names_sorted)

	Cname<-gsub("(","",df_name$V2,fixed = TRUE)

	Cname<-gsub(")","",Cname,fixed = TRUE)
	Cname<-gsub(" ","",Cname,fixed = TRUE)

	names(Complete_data_sorted)<-Cname
	tidy_data_set<-data.frame()

# New tidy data set with the average of each variable for each activity and each subject.	
	for(i in 1:30) {
		for (j in 1:6) {
			tidy_mean<-data.frame()
			temp<-Complete_data_sorted[(Complete_data_sorted$Subject==i & Complete_data_sorted$Activity==j),]
			tidy_mean[1,1]<-i
			tidy_mean[1,2]<-j
			tidy_mean[1,3]<-temp[1,3]
			tidy_mean[,4:82]<-colMeans(temp[,4:82])

			tidy_data_set<-rbind(tidy_data_set,tidy_mean)

		}
	}

	names(tidy_data_set)<-Cname

	write.table(tidy_data_set,"tidy_data_set.txt",row.name=FALSE)

}