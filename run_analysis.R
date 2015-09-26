# Import column names
cname <- read.table("./features.txt",sep = " ")
# Create a filter of columns with means
means <- grep("mean", cname$V2)
# Create a filter of columns with standard deviations
sds <- grep("std", cname$V2)
# Create vector with column numbers of all means and standard deviations
cname.bound <- sort(append(means,sds))
# Creat vector of subject
subject <- c(1:30)

# Import activity labels
actlabels <- read.table("./activity_labels.txt", col.names = c("Activity", "Label"))


# Import test data
testdata <- read.table("test/X_test.txt", col.names = cname$V2)
# Import test activity codes
testdata["Activity"] <- read.table("test/y_test.txt", col.names="Activity")
# Import test subject codes
testdata["Subject"] <- read.table("test/subject_test.txt", col.names="Subject")
# Add column to use after merge
testdata["Mode"] = "Test"



# Import train data
traindata <- read.table("train/X_train.txt", col.names = cname$V2)
# Import train activity codes
traindata["Activity"] <- read.table("train/y_train.txt", col.names="Activity")
# Import train subject codes
traindata["Subject"] <- read.table("train/subject_train.txt", col.names="Subject")
# Add column to use after merge
traindata["Mode"] = "Train"


# Add elements for Activity Code, Subject & Mode to column filter
cname.bound <- append(cname.bound, c(562,563,564))

# Merge test and train data sets
exportdata <- rbind(testdata[cname.bound],traindata[cname.bound])

# Replace Activity Codes with human readable labels
exportdata[["Activity"]] <- actlabels[match(exportdata[['Activity']],actlabels[['Activity']]), "Label"]

# Export data set
write.table(exportdata,file="part4.txt",row.names = FALSE)

# Create list for subsetted data
sortbylist <- (list(exportdata$Subject,exportdata$Activity))
# Split data into list by Subject and Activity
exportdata.split <- split(exportdata,sortbylist)


# Setup new dataframe to hold subsetted data
exportdata.subset <- data.frame(matrix(ncol = 81, nrow=2372))


# Initialize counter
counter <- 1

for (s in subject){
        for (v in seq_len(ncol(exportdata)-3)) {
                # Set Activity
                exportdata.subset[counter,80] <- as.character(exportdata.split[[s]][[80]][[1]])
                # Set Subject
                exportdata.subset[counter,81] <- as.numeric(s)
                # Set Activity
                # exportdata.subset[counter,2] <- colnames(exportdata.split[[s]])[v]
                
                # Extract Mean
                exportdata.subset[counter,v] <- as.numeric(mean(exportdata.split[[s]][[v]]))
        
                
                # Increment the counter
                counter <- counter + 1
                        
                   
        }
}

# Put names on the columns
colnames.export <-colnames(exportdata)
colnames.export <- colnames.export[-1]
colnames(exportdata.subset) <- colnames.export

# Write data to a file
write.table(exportdata.subset, "dsonenberg.txt", row.name=FALSE)