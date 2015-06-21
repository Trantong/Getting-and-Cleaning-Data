#Project's Purpose
The purpose of this project is to demonstrate your ability to collect, work with, and clean a data set. The goal is to prepare tidy data that can be used for later analysis. You will be graded by your peers on a series of yes/no questions related to the project. You will be required to submit: 1) a tidy data set as described below, 2) a link to a Github repository with your script for performing the analysis, and 3) a code book that describes the variables, the data, and any transformations or work that you performed to clean up the data called CodeBook.md. You should also include a README.md in the repo with your scripts. This repo explains how all of the scripts work and how they are connected.  

One of the most exciting areas in all of data science right now is wearable computing - see for example this article . Companies like Fitbit, Nike, and Jawbone Up are racing to develop the most advanced algorithms to attract new users. The data linked to from the course website represent data collected from the accelerometers from the Samsung Galaxy S smartphone. A full description is available at the site where the data was obtained: 

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 

Here are the data for the project: 

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

You should create one R script called run_analysis.R that does the following:  
1. Merges the training and the test sets to create one data set.   
2. Extracts only the measurements on the mean and standard deviation for each measurement.      
3. Uses descriptive activity names to name the activities in the data set         
4. Appropriately labels the data set with descriptive variable names.               
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject. 

#Description of the DATA
The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ. These time domain signals (prefix ‘t’ to denote time) were captured at a constant rate of 50 Hz. and the acceleration signal was then separated into body and gravity acceleration signals (tBodyAcc-XYZ and tGravityAcc-XYZ) – both using a low pass Butterworth filter.

The body linear acceleration and angular velocity were derived in time to obtain Jerk signals (tBodyAccJerk-XYZ and tBodyGyroJerk-XYZ). Also the magnitude of these three-dimensional signals were calculated using the Euclidean norm (tBodyAccMag, tGravityAccMag, tBodyAccJerkMag, tBodyGyroMag, tBodyGyroJerkMag).

A Fast Fourier Transform (FFT) was applied to some of these signals producing fBodyAcc-XYZ, fBodyAccJerk-XYZ, fBodyGyro-XYZ, fBodyAccJerkMag, fBodyGyroMag, fBodyGyroJerkMag. (Note the ‘f’ to indicate frequency domain signals).

Description of abbreviations of measurements

leading t or f is based on time or frequency measurements.
Body = related to body movement.
Gravity = acceleration of gravity
Acc = accelerometer measurement
Gyro = gyroscopic measurements
Jerk = sudden movement acceleration
Mag = magnitude of movement
mean and SD are calculated for each subject for each activity for each mean and SD measurements.
The units given are g’s for the accelerometer and rad/sec for the gyro and g/sec and rad/sec/sec for the corresponding jerks.

These signals were used to estimate variables of the feature vector for each pattern:
‘-XYZ’ is used to denote 3-axial signals in the X, Y and Z directions. They total 33 measurements including the 3 dimensions - the X,Y, and Z axes.

tBodyAcc-XYZ
tGravityAcc-XYZ
tBodyAccJerk-XYZ
tBodyGyro-XYZ
tBodyGyroJerk-XYZ
tBodyAccMag
tGravityAccMag
tBodyAccJerkMag
tBodyGyroMag
tBodyGyroJerkMag
fBodyAcc-XYZ
fBodyAccJerk-XYZ
fBodyGyro-XYZ
fBodyAccMag
fBodyAccJerkMag
fBodyGyroMag
fBodyGyroJerkMag

The set of variables that were estimated from these signals are:
mean(): Mean value
std(): Standard deviation

#Data Set Information:
The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data.

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows. From each window, a vector of features was obtained by calculating variables from the time and frequency domain.
#1.Get the data
####Download the file and put the file in the data folder and unzip the file
if(!file.exists("./data")){dir.create("./data")}                            
fileUrl<-"https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"                                        
download.file(fileUrl,destfile="./data/Dataset.zip",method="libcurl")    
unzip(zipfile="./data/Dataset.zip",exdir="./data")    
####Get the list of unzipped files
files<-list.files("./data/UCI HAR Dataset", recursive=TRUE)   
files
[1] "activity_labels.txt"                          "features.txt"                                
 [3] "features_info.txt"                            "README.txt"                                  
 [5] "test/Inertial Signals/body_acc_x_test.txt"    "test/Inertial Signals/body_acc_y_test.txt"   
 [7] "test/Inertial Signals/body_acc_z_test.txt"    "test/Inertial Signals/body_gyro_x_test.txt"  
 [9] "test/Inertial Signals/body_gyro_y_test.txt"   "test/Inertial Signals/body_gyro_z_test.txt"  
[11] "test/Inertial Signals/total_acc_x_test.txt"   "test/Inertial Signals/total_acc_y_test.txt"  
[13] "test/Inertial Signals/total_acc_z_test.txt"   "test/subject_test.txt"                       
[15] "test/X_test.txt"                              "test/y_test.txt"                             
[17] "train/Inertial Signals/body_acc_x_train.txt"  "train/Inertial Signals/body_acc_y_train.txt" 
[19] "train/Inertial Signals/body_acc_z_train.txt"  "train/Inertial Signals/body_gyro_x_train.txt"
[21] "train/Inertial Signals/body_gyro_y_train.txt" "train/Inertial Signals/body_gyro_z_train.txt"
[23] "train/Inertial Signals/total_acc_x_train.txt" "train/Inertial Signals/total_acc_y_train.txt"
[25] "train/Inertial Signals/total_acc_z_train.txt" "train/subject_train.txt"                     
[27] "train/X_train.txt"                            "train/y_train.txt"     

#2.Merges the training and the test sets to create one data set
####Read and merge Fearures files
x.train<-read.table("./data/UCI HAR Dataset/train/X_train.txt",header = FALSE)     
x.test<-read.table("./data/UCI HAR Dataset/test/X_test.txt",header = FALSE)      
x.merge<-rbind(x.train, x.test)  
names(x.merge)
 [1] "V1"   "V2"   "V3"   "V4"   "V5"   "V6"   "V7"   "V8"   "V9"   "V10"  "V11"  "V12"  "V13"  "V14"  "V15" 
 [16] "V16"  "V17"  "V18"  "V19"  "V20"  "V21"  "V22"  "V23"  "V24"  "V25"  "V26"  "V27"  "V28"  "V29"  "V30" 
 [31] "V31"  "V32"  "V33"  "V34"  "V35"  "V36"  "V37"  "V38"  "V39"  "V40"  "V41"  "V42"  "V43"  "V44"  "V45" 
 [46] "V46"  "V47"  "V48"  "V49"  "V50"  "V51"  "V52"  "V53"  "V54"  "V55"  "V56"  "V57"  "V58"  "V59"  "V60" 
 [61] "V61"  "V62"  "V63"  "V64"  "V65"  "V66"  "V67"  "V68"  "V69"  "V70"  "V71"  "V72"  "V73"  "V74"  "V75" 
 [76] "V76"  "V77"  "V78"  "V79"  "V80"  "V81"  "V82"  "V83"  "V84"  "V85"  "V86"  "V87"  "V88"  "V89"  "V90" 
 [91] "V91"  "V92"  "V93"  "V94"  "V95"  "V96"  "V97"  "V98"  "V99"  "V100" "V101" "V102" "V103" "V104" "V105"
[106] "V106" "V107" "V108" "V109" "V110" "V111" "V112" "V113" "V114" "V115" "V116" "V117" "V118" "V119" "V120"
[121] "V121" "V122" "V123" "V124" "V125" "V126" "V127" "V128" "V129" "V130" "V131" "V132" "V133" "V134" "V135"
[136] "V136" "V137" "V138" "V139" "V140" "V141" "V142" "V143" "V144" "V145" "V146" "V147" "V148" "V149" "V150"
[151] "V151" "V152" "V153" "V154" "V155" "V156" "V157" "V158" "V159" "V160" "V161" "V162" "V163" "V164" "V165"
[166] "V166" "V167" "V168" "V169" "V170" "V171" "V172" "V173" "V174" "V175" "V176" "V177" "V178" "V179" "V180"
[181] "V181" "V182" "V183" "V184" "V185" "V186" "V187" "V188" "V189" "V190" "V191" "V192" "V193" "V194" "V195"
[196] "V196" "V197" "V198" "V199" "V200" "V201" "V202" "V203" "V204" "V205" "V206" "V207" "V208" "V209" "V210"
[211] "V211" "V212" "V213" "V214" "V215" "V216" "V217" "V218" "V219" "V220" "V221" "V222" "V223" "V224" "V225"
[226] "V226" "V227" "V228" "V229" "V230" "V231" "V232" "V233" "V234" "V235" "V236" "V237" "V238" "V239" "V240"
[241] "V241" "V242" "V243" "V244" "V245" "V246" "V247" "V248" "V249" "V250" "V251" "V252" "V253" "V254" "V255"
[256] "V256" "V257" "V258" "V259" "V260" "V261" "V262" "V263" "V264" "V265" "V266" "V267" "V268" "V269" "V270"
[271] "V271" "V272" "V273" "V274" "V275" "V276" "V277" "V278" "V279" "V280" "V281" "V282" "V283" "V284" "V285"
[286] "V286" "V287" "V288" "V289" "V290" "V291" "V292" "V293" "V294" "V295" "V296" "V297" "V298" "V299" "V300"
[301] "V301" "V302" "V303" "V304" "V305" "V306" "V307" "V308" "V309" "V310" "V311" "V312" "V313" "V314" "V315"
[316] "V316" "V317" "V318" "V319" "V320" "V321" "V322" "V323" "V324" "V325" "V326" "V327" "V328" "V329" "V330"
[331] "V331" "V332" "V333" "V334" "V335" "V336" "V337" "V338" "V339" "V340" "V341" "V342" "V343" "V344" "V345"
[346] "V346" "V347" "V348" "V349" "V350" "V351" "V352" "V353" "V354" "V355" "V356" "V357" "V358" "V359" "V360"
[361] "V361" "V362" "V363" "V364" "V365" "V366" "V367" "V368" "V369" "V370" "V371" "V372" "V373" "V374" "V375"
[376] "V376" "V377" "V378" "V379" "V380" "V381" "V382" "V383" "V384" "V385" "V386" "V387" "V388" "V389" "V390"
[391] "V391" "V392" "V393" "V394" "V395" "V396" "V397" "V398" "V399" "V400" "V401" "V402" "V403" "V404" "V405"
[406] "V406" "V407" "V408" "V409" "V410" "V411" "V412" "V413" "V414" "V415" "V416" "V417" "V418" "V419" "V420"
[421] "V421" "V422" "V423" "V424" "V425" "V426" "V427" "V428" "V429" "V430" "V431" "V432" "V433" "V434" "V435"
[436] "V436" "V437" "V438" "V439" "V440" "V441" "V442" "V443" "V444" "V445" "V446" "V447" "V448" "V449" "V450"
[451] "V451" "V452" "V453" "V454" "V455" "V456" "V457" "V458" "V459" "V460" "V461" "V462" "V463" "V464" "V465"
[466] "V466" "V467" "V468" "V469" "V470" "V471" "V472" "V473" "V474" "V475" "V476" "V477" "V478" "V479" "V480"
[481] "V481" "V482" "V483" "V484" "V485" "V486" "V487" "V488" "V489" "V490" "V491" "V492" "V493" "V494" "V495"
[496] "V496" "V497" "V498" "V499" "V500" "V501" "V502" "V503" "V504" "V505" "V506" "V507" "V508" "V509" "V510"
[511] "V511" "V512" "V513" "V514" "V515" "V516" "V517" "V518" "V519" "V520" "V521" "V522" "V523" "V524" "V525"
[526] "V526" "V527" "V528" "V529" "V530" "V531" "V532" "V533" "V534" "V535" "V536" "V537" "V538" "V539" "V540"
[541] "V541" "V542" "V543" "V544" "V545" "V546" "V547" "V548" "V549" "V550" "V551" "V552" "V553" "V554" "V555"
[556] "V556" "V557" "V558" "V559" "V560" "V561"

####Read and merge subject files
subject.train <- read.table("./data/UCI HAR Dataset/train/subject_train.txt",header = FALSE)   
subject.test <- read.table("./data/UCI HAR Dataset/test/subject_test.txt",header = FALSE)   
subject.merge <- rbind(subject.train, subject.test) 
names(subject.merge)
[1] "V1"

#### Read and merge activity files  
y.train <- read.table("./data/UCI HAR Dataset/train/y_train.txt",header = FALSE)  
y.test <- read.table("./data/UCI HAR Dataset/test/y_test.txt",header = FALSE)  
y.merge<- rbind(y.train, y.test)   
names(y.merge)
[1] "V1"

#3.Set names to variables
names(subject.merge)<-c("subject")                                                            
names(y.merge)<- c("activity")      
FeaturesNames <- read.table("./data/UCI HAR Dataset/features.txt",head=FALSE)     
names(x.merge)<- FeaturesNames$V2     
data.merge<-cbind(x.merge,y.merge,subject.merge)    
names(data.merge)
  [1] "tBodyAcc-mean()-X"                    "tBodyAcc-mean()-Y"                   
  [3] "tBodyAcc-mean()-Z"                    "tBodyAcc-std()-X"                    
  [5] "tBodyAcc-std()-Y"                     "tBodyAcc-std()-Z"                    
  [7] "tBodyAcc-mad()-X"                     "tBodyAcc-mad()-Y"                    
  [9] "tBodyAcc-mad()-Z"                     "tBodyAcc-max()-X"                    
 [11] "tBodyAcc-max()-Y"                     "tBodyAcc-max()-Z"                    
 [13] "tBodyAcc-min()-X"                     "tBodyAcc-min()-Y"                    
 [15] "tBodyAcc-min()-Z"                     "tBodyAcc-sma()"                      
 [17] "tBodyAcc-energy()-X"                  "tBodyAcc-energy()-Y"                 
 [19] "tBodyAcc-energy()-Z"                  "tBodyAcc-iqr()-X"                    
 [21] "tBodyAcc-iqr()-Y"                     "tBodyAcc-iqr()-Z"                    
 [23] "tBodyAcc-entropy()-X"                 "tBodyAcc-entropy()-Y"                
 [25] "tBodyAcc-entropy()-Z"                 "tBodyAcc-arCoeff()-X,1"              
 [27] "tBodyAcc-arCoeff()-X,2"               "tBodyAcc-arCoeff()-X,3"              
 [29] "tBodyAcc-arCoeff()-X,4"               "tBodyAcc-arCoeff()-Y,1"              
 [31] "tBodyAcc-arCoeff()-Y,2"               "tBodyAcc-arCoeff()-Y,3"              
 [33] "tBodyAcc-arCoeff()-Y,4"               "tBodyAcc-arCoeff()-Z,1"              
 [35] "tBodyAcc-arCoeff()-Z,2"               "tBodyAcc-arCoeff()-Z,3"              
 [37] "tBodyAcc-arCoeff()-Z,4"               "tBodyAcc-correlation()-X,Y"          
 [39] "tBodyAcc-correlation()-X,Z"           "tBodyAcc-correlation()-Y,Z"          
 [41] "tGravityAcc-mean()-X"                 "tGravityAcc-mean()-Y"                
 [43] "tGravityAcc-mean()-Z"                 "tGravityAcc-std()-X"                 
 [45] "tGravityAcc-std()-Y"                  "tGravityAcc-std()-Z"                 
 [47] "tGravityAcc-mad()-X"                  "tGravityAcc-mad()-Y"                 
 [49] "tGravityAcc-mad()-Z"                  "tGravityAcc-max()-X"                 
 [51] "tGravityAcc-max()-Y"                  "tGravityAcc-max()-Z"                 
 [53] "tGravityAcc-min()-X"                  "tGravityAcc-min()-Y"                 
 [55] "tGravityAcc-min()-Z"                  "tGravityAcc-sma()"                   
 [57] "tGravityAcc-energy()-X"               "tGravityAcc-energy()-Y"              
 [59] "tGravityAcc-energy()-Z"               "tGravityAcc-iqr()-X"                 
 [61] "tGravityAcc-iqr()-Y"                  "tGravityAcc-iqr()-Z"                 
 [63] "tGravityAcc-entropy()-X"              "tGravityAcc-entropy()-Y"             
 [65] "tGravityAcc-entropy()-Z"              "tGravityAcc-arCoeff()-X,1"           
 [67] "tGravityAcc-arCoeff()-X,2"            "tGravityAcc-arCoeff()-X,3"           
 [69] "tGravityAcc-arCoeff()-X,4"            "tGravityAcc-arCoeff()-Y,1"           
 [71] "tGravityAcc-arCoeff()-Y,2"            "tGravityAcc-arCoeff()-Y,3"           
 [73] "tGravityAcc-arCoeff()-Y,4"            "tGravityAcc-arCoeff()-Z,1"           
 [75] "tGravityAcc-arCoeff()-Z,2"            "tGravityAcc-arCoeff()-Z,3"           
 [77] "tGravityAcc-arCoeff()-Z,4"            "tGravityAcc-correlation()-X,Y"       
 [79] "tGravityAcc-correlation()-X,Z"        "tGravityAcc-correlation()-Y,Z"       
 [81] "tBodyAccJerk-mean()-X"                "tBodyAccJerk-mean()-Y"               
 [83] "tBodyAccJerk-mean()-Z"                "tBodyAccJerk-std()-X"                
 [85] "tBodyAccJerk-std()-Y"                 "tBodyAccJerk-std()-Z"                
 [87] "tBodyAccJerk-mad()-X"                 "tBodyAccJerk-mad()-Y"                
 [89] "tBodyAccJerk-mad()-Z"                 "tBodyAccJerk-max()-X"                
 [91] "tBodyAccJerk-max()-Y"                 "tBodyAccJerk-max()-Z"                
 [93] "tBodyAccJerk-min()-X"                 "tBodyAccJerk-min()-Y"                
 [95] "tBodyAccJerk-min()-Z"                 "tBodyAccJerk-sma()"                  
 [97] "tBodyAccJerk-energy()-X"              "tBodyAccJerk-energy()-Y"             
 [99] "tBodyAccJerk-energy()-Z"              "tBodyAccJerk-iqr()-X"                
[101] "tBodyAccJerk-iqr()-Y"                 "tBodyAccJerk-iqr()-Z"                
[103] "tBodyAccJerk-entropy()-X"             "tBodyAccJerk-entropy()-Y"            
[105] "tBodyAccJerk-entropy()-Z"             "tBodyAccJerk-arCoeff()-X,1"          
[107] "tBodyAccJerk-arCoeff()-X,2"           "tBodyAccJerk-arCoeff()-X,3"          
[109] "tBodyAccJerk-arCoeff()-X,4"           "tBodyAccJerk-arCoeff()-Y,1"          
[111] "tBodyAccJerk-arCoeff()-Y,2"           "tBodyAccJerk-arCoeff()-Y,3"          
[113] "tBodyAccJerk-arCoeff()-Y,4"           "tBodyAccJerk-arCoeff()-Z,1"          
[115] "tBodyAccJerk-arCoeff()-Z,2"           "tBodyAccJerk-arCoeff()-Z,3"          
[117] "tBodyAccJerk-arCoeff()-Z,4"           "tBodyAccJerk-correlation()-X,Y"      
[119] "tBodyAccJerk-correlation()-X,Z"       "tBodyAccJerk-correlation()-Y,Z"      
[121] "tBodyGyro-mean()-X"                   "tBodyGyro-mean()-Y"                  
[123] "tBodyGyro-mean()-Z"                   "tBodyGyro-std()-X"                   
[125] "tBodyGyro-std()-Y"                    "tBodyGyro-std()-Z"                   
[127] "tBodyGyro-mad()-X"                    "tBodyGyro-mad()-Y"                   
[129] "tBodyGyro-mad()-Z"                    "tBodyGyro-max()-X"                   
[131] "tBodyGyro-max()-Y"                    "tBodyGyro-max()-Z"                   
[133] "tBodyGyro-min()-X"                    "tBodyGyro-min()-Y"                   
[135] "tBodyGyro-min()-Z"                    "tBodyGyro-sma()"                     
[137] "tBodyGyro-energy()-X"                 "tBodyGyro-energy()-Y"                
[139] "tBodyGyro-energy()-Z"                 "tBodyGyro-iqr()-X"                   
[141] "tBodyGyro-iqr()-Y"                    "tBodyGyro-iqr()-Z"                   
[143] "tBodyGyro-entropy()-X"                "tBodyGyro-entropy()-Y"               
[145] "tBodyGyro-entropy()-Z"                "tBodyGyro-arCoeff()-X,1"             
[147] "tBodyGyro-arCoeff()-X,2"              "tBodyGyro-arCoeff()-X,3"             
[149] "tBodyGyro-arCoeff()-X,4"              "tBodyGyro-arCoeff()-Y,1"             
[151] "tBodyGyro-arCoeff()-Y,2"              "tBodyGyro-arCoeff()-Y,3"             
[153] "tBodyGyro-arCoeff()-Y,4"              "tBodyGyro-arCoeff()-Z,1"             
[155] "tBodyGyro-arCoeff()-Z,2"              "tBodyGyro-arCoeff()-Z,3"             
[157] "tBodyGyro-arCoeff()-Z,4"              "tBodyGyro-correlation()-X,Y"         
[159] "tBodyGyro-correlation()-X,Z"          "tBodyGyro-correlation()-Y,Z"         
[161] "tBodyGyroJerk-mean()-X"               "tBodyGyroJerk-mean()-Y"              
[163] "tBodyGyroJerk-mean()-Z"               "tBodyGyroJerk-std()-X"               
[165] "tBodyGyroJerk-std()-Y"                "tBodyGyroJerk-std()-Z"               
[167] "tBodyGyroJerk-mad()-X"                "tBodyGyroJerk-mad()-Y"               
[169] "tBodyGyroJerk-mad()-Z"                "tBodyGyroJerk-max()-X"               
[171] "tBodyGyroJerk-max()-Y"                "tBodyGyroJerk-max()-Z"               
[173] "tBodyGyroJerk-min()-X"                "tBodyGyroJerk-min()-Y"               
[175] "tBodyGyroJerk-min()-Z"                "tBodyGyroJerk-sma()"                 
[177] "tBodyGyroJerk-energy()-X"             "tBodyGyroJerk-energy()-Y"            
[179] "tBodyGyroJerk-energy()-Z"             "tBodyGyroJerk-iqr()-X"               
[181] "tBodyGyroJerk-iqr()-Y"                "tBodyGyroJerk-iqr()-Z"               
[183] "tBodyGyroJerk-entropy()-X"            "tBodyGyroJerk-entropy()-Y"           
[185] "tBodyGyroJerk-entropy()-Z"            "tBodyGyroJerk-arCoeff()-X,1"         
[187] "tBodyGyroJerk-arCoeff()-X,2"          "tBodyGyroJerk-arCoeff()-X,3"         
[189] "tBodyGyroJerk-arCoeff()-X,4"          "tBodyGyroJerk-arCoeff()-Y,1"         
[191] "tBodyGyroJerk-arCoeff()-Y,2"          "tBodyGyroJerk-arCoeff()-Y,3"         
[193] "tBodyGyroJerk-arCoeff()-Y,4"          "tBodyGyroJerk-arCoeff()-Z,1"         
[195] "tBodyGyroJerk-arCoeff()-Z,2"          "tBodyGyroJerk-arCoeff()-Z,3"         
[197] "tBodyGyroJerk-arCoeff()-Z,4"          "tBodyGyroJerk-correlation()-X,Y"     
[199] "tBodyGyroJerk-correlation()-X,Z"      "tBodyGyroJerk-correlation()-Y,Z"     
[201] "tBodyAccMag-mean()"                   "tBodyAccMag-std()"                   
[203] "tBodyAccMag-mad()"                    "tBodyAccMag-max()"                   
[205] "tBodyAccMag-min()"                    "tBodyAccMag-sma()"                   
[207] "tBodyAccMag-energy()"                 "tBodyAccMag-iqr()"                   
[209] "tBodyAccMag-entropy()"                "tBodyAccMag-arCoeff()1"              
[211] "tBodyAccMag-arCoeff()2"               "tBodyAccMag-arCoeff()3"              
[213] "tBodyAccMag-arCoeff()4"               "tGravityAccMag-mean()"               
[215] "tGravityAccMag-std()"                 "tGravityAccMag-mad()"                
[217] "tGravityAccMag-max()"                 "tGravityAccMag-min()"                
[219] "tGravityAccMag-sma()"                 "tGravityAccMag-energy()"             
[221] "tGravityAccMag-iqr()"                 "tGravityAccMag-entropy()"            
[223] "tGravityAccMag-arCoeff()1"            "tGravityAccMag-arCoeff()2"           
[225] "tGravityAccMag-arCoeff()3"            "tGravityAccMag-arCoeff()4"           
[227] "tBodyAccJerkMag-mean()"               "tBodyAccJerkMag-std()"               
[229] "tBodyAccJerkMag-mad()"                "tBodyAccJerkMag-max()"               
[231] "tBodyAccJerkMag-min()"                "tBodyAccJerkMag-sma()"               
[233] "tBodyAccJerkMag-energy()"             "tBodyAccJerkMag-iqr()"               
[235] "tBodyAccJerkMag-entropy()"            "tBodyAccJerkMag-arCoeff()1"          
[237] "tBodyAccJerkMag-arCoeff()2"           "tBodyAccJerkMag-arCoeff()3"          
[239] "tBodyAccJerkMag-arCoeff()4"           "tBodyGyroMag-mean()"                 
[241] "tBodyGyroMag-std()"                   "tBodyGyroMag-mad()"                  
[243] "tBodyGyroMag-max()"                   "tBodyGyroMag-min()"                  
[245] "tBodyGyroMag-sma()"                   "tBodyGyroMag-energy()"               
[247] "tBodyGyroMag-iqr()"                   "tBodyGyroMag-entropy()"              
[249] "tBodyGyroMag-arCoeff()1"              "tBodyGyroMag-arCoeff()2"             
[251] "tBodyGyroMag-arCoeff()3"              "tBodyGyroMag-arCoeff()4"             
[253] "tBodyGyroJerkMag-mean()"              "tBodyGyroJerkMag-std()"              
[255] "tBodyGyroJerkMag-mad()"               "tBodyGyroJerkMag-max()"              
[257] "tBodyGyroJerkMag-min()"               "tBodyGyroJerkMag-sma()"              
[259] "tBodyGyroJerkMag-energy()"            "tBodyGyroJerkMag-iqr()"              
[261] "tBodyGyroJerkMag-entropy()"           "tBodyGyroJerkMag-arCoeff()1"         
[263] "tBodyGyroJerkMag-arCoeff()2"          "tBodyGyroJerkMag-arCoeff()3"         
[265] "tBodyGyroJerkMag-arCoeff()4"          "fBodyAcc-mean()-X"                   
[267] "fBodyAcc-mean()-Y"                    "fBodyAcc-mean()-Z"                   
[269] "fBodyAcc-std()-X"                     "fBodyAcc-std()-Y"                    
[271] "fBodyAcc-std()-Z"                     "fBodyAcc-mad()-X"                    
[273] "fBodyAcc-mad()-Y"                     "fBodyAcc-mad()-Z"                    
[275] "fBodyAcc-max()-X"                     "fBodyAcc-max()-Y"                    
[277] "fBodyAcc-max()-Z"                     "fBodyAcc-min()-X"                    
[279] "fBodyAcc-min()-Y"                     "fBodyAcc-min()-Z"                    
[281] "fBodyAcc-sma()"                       "fBodyAcc-energy()-X"                 
[283] "fBodyAcc-energy()-Y"                  "fBodyAcc-energy()-Z"                 
[285] "fBodyAcc-iqr()-X"                     "fBodyAcc-iqr()-Y"                    
[287] "fBodyAcc-iqr()-Z"                     "fBodyAcc-entropy()-X"                
[289] "fBodyAcc-entropy()-Y"                 "fBodyAcc-entropy()-Z"                
[291] "fBodyAcc-maxInds-X"                   "fBodyAcc-maxInds-Y"                  
[293] "fBodyAcc-maxInds-Z"                   "fBodyAcc-meanFreq()-X"               
[295] "fBodyAcc-meanFreq()-Y"                "fBodyAcc-meanFreq()-Z"               
[297] "fBodyAcc-skewness()-X"                "fBodyAcc-kurtosis()-X"               
[299] "fBodyAcc-skewness()-Y"                "fBodyAcc-kurtosis()-Y"               
[301] "fBodyAcc-skewness()-Z"                "fBodyAcc-kurtosis()-Z"               
[303] "fBodyAcc-bandsEnergy()-1,8"           "fBodyAcc-bandsEnergy()-9,16"         
[305] "fBodyAcc-bandsEnergy()-17,24"         "fBodyAcc-bandsEnergy()-25,32"        
[307] "fBodyAcc-bandsEnergy()-33,40"         "fBodyAcc-bandsEnergy()-41,48"        
[309] "fBodyAcc-bandsEnergy()-49,56"         "fBodyAcc-bandsEnergy()-57,64"        
[311] "fBodyAcc-bandsEnergy()-1,16"          "fBodyAcc-bandsEnergy()-17,32"        
[313] "fBodyAcc-bandsEnergy()-33,48"         "fBodyAcc-bandsEnergy()-49,64"        
[315] "fBodyAcc-bandsEnergy()-1,24"          "fBodyAcc-bandsEnergy()-25,48"        
[317] "fBodyAcc-bandsEnergy()-1,8"           "fBodyAcc-bandsEnergy()-9,16"         
[319] "fBodyAcc-bandsEnergy()-17,24"         "fBodyAcc-bandsEnergy()-25,32"        
[321] "fBodyAcc-bandsEnergy()-33,40"         "fBodyAcc-bandsEnergy()-41,48"        
[323] "fBodyAcc-bandsEnergy()-49,56"         "fBodyAcc-bandsEnergy()-57,64"        
[325] "fBodyAcc-bandsEnergy()-1,16"          "fBodyAcc-bandsEnergy()-17,32"        
[327] "fBodyAcc-bandsEnergy()-33,48"         "fBodyAcc-bandsEnergy()-49,64"        
[329] "fBodyAcc-bandsEnergy()-1,24"          "fBodyAcc-bandsEnergy()-25,48"        
[331] "fBodyAcc-bandsEnergy()-1,8"           "fBodyAcc-bandsEnergy()-9,16"         
[333] "fBodyAcc-bandsEnergy()-17,24"         "fBodyAcc-bandsEnergy()-25,32"        
[335] "fBodyAcc-bandsEnergy()-33,40"         "fBodyAcc-bandsEnergy()-41,48"        
[337] "fBodyAcc-bandsEnergy()-49,56"         "fBodyAcc-bandsEnergy()-57,64"        
[339] "fBodyAcc-bandsEnergy()-1,16"          "fBodyAcc-bandsEnergy()-17,32"        
[341] "fBodyAcc-bandsEnergy()-33,48"         "fBodyAcc-bandsEnergy()-49,64"        
[343] "fBodyAcc-bandsEnergy()-1,24"          "fBodyAcc-bandsEnergy()-25,48"        
[345] "fBodyAccJerk-mean()-X"                "fBodyAccJerk-mean()-Y"               
[347] "fBodyAccJerk-mean()-Z"                "fBodyAccJerk-std()-X"                
[349] "fBodyAccJerk-std()-Y"                 "fBodyAccJerk-std()-Z"                
[351] "fBodyAccJerk-mad()-X"                 "fBodyAccJerk-mad()-Y"                
[353] "fBodyAccJerk-mad()-Z"                 "fBodyAccJerk-max()-X"                
[355] "fBodyAccJerk-max()-Y"                 "fBodyAccJerk-max()-Z"                
[357] "fBodyAccJerk-min()-X"                 "fBodyAccJerk-min()-Y"                
[359] "fBodyAccJerk-min()-Z"                 "fBodyAccJerk-sma()"                  
[361] "fBodyAccJerk-energy()-X"              "fBodyAccJerk-energy()-Y"             
[363] "fBodyAccJerk-energy()-Z"              "fBodyAccJerk-iqr()-X"                
[365] "fBodyAccJerk-iqr()-Y"                 "fBodyAccJerk-iqr()-Z"                
[367] "fBodyAccJerk-entropy()-X"             "fBodyAccJerk-entropy()-Y"            
[369] "fBodyAccJerk-entropy()-Z"             "fBodyAccJerk-maxInds-X"              
[371] "fBodyAccJerk-maxInds-Y"               "fBodyAccJerk-maxInds-Z"              
[373] "fBodyAccJerk-meanFreq()-X"            "fBodyAccJerk-meanFreq()-Y"           
[375] "fBodyAccJerk-meanFreq()-Z"            "fBodyAccJerk-skewness()-X"           
[377] "fBodyAccJerk-kurtosis()-X"            "fBodyAccJerk-skewness()-Y"           
[379] "fBodyAccJerk-kurtosis()-Y"            "fBodyAccJerk-skewness()-Z"           
[381] "fBodyAccJerk-kurtosis()-Z"            "fBodyAccJerk-bandsEnergy()-1,8"      
[383] "fBodyAccJerk-bandsEnergy()-9,16"      "fBodyAccJerk-bandsEnergy()-17,24"    
[385] "fBodyAccJerk-bandsEnergy()-25,32"     "fBodyAccJerk-bandsEnergy()-33,40"    
[387] "fBodyAccJerk-bandsEnergy()-41,48"     "fBodyAccJerk-bandsEnergy()-49,56"    
[389] "fBodyAccJerk-bandsEnergy()-57,64"     "fBodyAccJerk-bandsEnergy()-1,16"     
[391] "fBodyAccJerk-bandsEnergy()-17,32"     "fBodyAccJerk-bandsEnergy()-33,48"    
[393] "fBodyAccJerk-bandsEnergy()-49,64"     "fBodyAccJerk-bandsEnergy()-1,24"     
[395] "fBodyAccJerk-bandsEnergy()-25,48"     "fBodyAccJerk-bandsEnergy()-1,8"      
[397] "fBodyAccJerk-bandsEnergy()-9,16"      "fBodyAccJerk-bandsEnergy()-17,24"    
[399] "fBodyAccJerk-bandsEnergy()-25,32"     "fBodyAccJerk-bandsEnergy()-33,40"    
[401] "fBodyAccJerk-bandsEnergy()-41,48"     "fBodyAccJerk-bandsEnergy()-49,56"    
[403] "fBodyAccJerk-bandsEnergy()-57,64"     "fBodyAccJerk-bandsEnergy()-1,16"     
[405] "fBodyAccJerk-bandsEnergy()-17,32"     "fBodyAccJerk-bandsEnergy()-33,48"    
[407] "fBodyAccJerk-bandsEnergy()-49,64"     "fBodyAccJerk-bandsEnergy()-1,24"     
[409] "fBodyAccJerk-bandsEnergy()-25,48"     "fBodyAccJerk-bandsEnergy()-1,8"      
[411] "fBodyAccJerk-bandsEnergy()-9,16"      "fBodyAccJerk-bandsEnergy()-17,24"    
[413] "fBodyAccJerk-bandsEnergy()-25,32"     "fBodyAccJerk-bandsEnergy()-33,40"    
[415] "fBodyAccJerk-bandsEnergy()-41,48"     "fBodyAccJerk-bandsEnergy()-49,56"    
[417] "fBodyAccJerk-bandsEnergy()-57,64"     "fBodyAccJerk-bandsEnergy()-1,16"     
[419] "fBodyAccJerk-bandsEnergy()-17,32"     "fBodyAccJerk-bandsEnergy()-33,48"    
[421] "fBodyAccJerk-bandsEnergy()-49,64"     "fBodyAccJerk-bandsEnergy()-1,24"     
[423] "fBodyAccJerk-bandsEnergy()-25,48"     "fBodyGyro-mean()-X"                  
[425] "fBodyGyro-mean()-Y"                   "fBodyGyro-mean()-Z"                  
[427] "fBodyGyro-std()-X"                    "fBodyGyro-std()-Y"                   
[429] "fBodyGyro-std()-Z"                    "fBodyGyro-mad()-X"                   
[431] "fBodyGyro-mad()-Y"                    "fBodyGyro-mad()-Z"                   
[433] "fBodyGyro-max()-X"                    "fBodyGyro-max()-Y"                   
[435] "fBodyGyro-max()-Z"                    "fBodyGyro-min()-X"                   
[437] "fBodyGyro-min()-Y"                    "fBodyGyro-min()-Z"                   
[439] "fBodyGyro-sma()"                      "fBodyGyro-energy()-X"                
[441] "fBodyGyro-energy()-Y"                 "fBodyGyro-energy()-Z"                
[443] "fBodyGyro-iqr()-X"                    "fBodyGyro-iqr()-Y"                   
[445] "fBodyGyro-iqr()-Z"                    "fBodyGyro-entropy()-X"               
[447] "fBodyGyro-entropy()-Y"                "fBodyGyro-entropy()-Z"               
[449] "fBodyGyro-maxInds-X"                  "fBodyGyro-maxInds-Y"                 
[451] "fBodyGyro-maxInds-Z"                  "fBodyGyro-meanFreq()-X"              
[453] "fBodyGyro-meanFreq()-Y"               "fBodyGyro-meanFreq()-Z"              
[455] "fBodyGyro-skewness()-X"               "fBodyGyro-kurtosis()-X"              
[457] "fBodyGyro-skewness()-Y"               "fBodyGyro-kurtosis()-Y"              
[459] "fBodyGyro-skewness()-Z"               "fBodyGyro-kurtosis()-Z"              
[461] "fBodyGyro-bandsEnergy()-1,8"          "fBodyGyro-bandsEnergy()-9,16"        
[463] "fBodyGyro-bandsEnergy()-17,24"        "fBodyGyro-bandsEnergy()-25,32"       
[465] "fBodyGyro-bandsEnergy()-33,40"        "fBodyGyro-bandsEnergy()-41,48"       
[467] "fBodyGyro-bandsEnergy()-49,56"        "fBodyGyro-bandsEnergy()-57,64"       
[469] "fBodyGyro-bandsEnergy()-1,16"         "fBodyGyro-bandsEnergy()-17,32"       
[471] "fBodyGyro-bandsEnergy()-33,48"        "fBodyGyro-bandsEnergy()-49,64"       
[473] "fBodyGyro-bandsEnergy()-1,24"         "fBodyGyro-bandsEnergy()-25,48"       
[475] "fBodyGyro-bandsEnergy()-1,8"          "fBodyGyro-bandsEnergy()-9,16"        
[477] "fBodyGyro-bandsEnergy()-17,24"        "fBodyGyro-bandsEnergy()-25,32"       
[479] "fBodyGyro-bandsEnergy()-33,40"        "fBodyGyro-bandsEnergy()-41,48"       
[481] "fBodyGyro-bandsEnergy()-49,56"        "fBodyGyro-bandsEnergy()-57,64"       
[483] "fBodyGyro-bandsEnergy()-1,16"         "fBodyGyro-bandsEnergy()-17,32"       
[485] "fBodyGyro-bandsEnergy()-33,48"        "fBodyGyro-bandsEnergy()-49,64"       
[487] "fBodyGyro-bandsEnergy()-1,24"         "fBodyGyro-bandsEnergy()-25,48"       
[489] "fBodyGyro-bandsEnergy()-1,8"          "fBodyGyro-bandsEnergy()-9,16"        
[491] "fBodyGyro-bandsEnergy()-17,24"        "fBodyGyro-bandsEnergy()-25,32"       
[493] "fBodyGyro-bandsEnergy()-33,40"        "fBodyGyro-bandsEnergy()-41,48"       
[495] "fBodyGyro-bandsEnergy()-49,56"        "fBodyGyro-bandsEnergy()-57,64"       
[497] "fBodyGyro-bandsEnergy()-1,16"         "fBodyGyro-bandsEnergy()-17,32"       
[499] "fBodyGyro-bandsEnergy()-33,48"        "fBodyGyro-bandsEnergy()-49,64"       
[501] "fBodyGyro-bandsEnergy()-1,24"         "fBodyGyro-bandsEnergy()-25,48"       
[503] "fBodyAccMag-mean()"                   "fBodyAccMag-std()"                   
[505] "fBodyAccMag-mad()"                    "fBodyAccMag-max()"                   
[507] "fBodyAccMag-min()"                    "fBodyAccMag-sma()"                   
[509] "fBodyAccMag-energy()"                 "fBodyAccMag-iqr()"                   
[511] "fBodyAccMag-entropy()"                "fBodyAccMag-maxInds"                 
[513] "fBodyAccMag-meanFreq()"               "fBodyAccMag-skewness()"              
[515] "fBodyAccMag-kurtosis()"               "fBodyBodyAccJerkMag-mean()"          
[517] "fBodyBodyAccJerkMag-std()"            "fBodyBodyAccJerkMag-mad()"           
[519] "fBodyBodyAccJerkMag-max()"            "fBodyBodyAccJerkMag-min()"           
[521] "fBodyBodyAccJerkMag-sma()"            "fBodyBodyAccJerkMag-energy()"        
[523] "fBodyBodyAccJerkMag-iqr()"            "fBodyBodyAccJerkMag-entropy()"       
[525] "fBodyBodyAccJerkMag-maxInds"          "fBodyBodyAccJerkMag-meanFreq()"      
[527] "fBodyBodyAccJerkMag-skewness()"       "fBodyBodyAccJerkMag-kurtosis()"      
[529] "fBodyBodyGyroMag-mean()"              "fBodyBodyGyroMag-std()"              
[531] "fBodyBodyGyroMag-mad()"               "fBodyBodyGyroMag-max()"              
[533] "fBodyBodyGyroMag-min()"               "fBodyBodyGyroMag-sma()"              
[535] "fBodyBodyGyroMag-energy()"            "fBodyBodyGyroMag-iqr()"              
[537] "fBodyBodyGyroMag-entropy()"           "fBodyBodyGyroMag-maxInds"            
[539] "fBodyBodyGyroMag-meanFreq()"          "fBodyBodyGyroMag-skewness()"         
[541] "fBodyBodyGyroMag-kurtosis()"          "fBodyBodyGyroJerkMag-mean()"         
[543] "fBodyBodyGyroJerkMag-std()"           "fBodyBodyGyroJerkMag-mad()"          
[545] "fBodyBodyGyroJerkMag-max()"           "fBodyBodyGyroJerkMag-min()"          
[547] "fBodyBodyGyroJerkMag-sma()"           "fBodyBodyGyroJerkMag-energy()"       
[549] "fBodyBodyGyroJerkMag-iqr()"           "fBodyBodyGyroJerkMag-entropy()"      
[551] "fBodyBodyGyroJerkMag-maxInds"         "fBodyBodyGyroJerkMag-meanFreq()"     
[553] "fBodyBodyGyroJerkMag-skewness()"      "fBodyBodyGyroJerkMag-kurtosis()"     
[555] "angle(tBodyAccMean,gravity)"          "angle(tBodyAccJerkMean),gravityMean)"
[557] "angle(tBodyGyroMean,gravityMean)"     "angle(tBodyGyroJerkMean,gravityMean)"
[559] "angle(X,gravityMean)"                 "angle(Y,gravityMean)"                
[561] "angle(Z,gravityMean)"                 "activity"                            
[563] "subject"

#4.Extracts only the measurements on the mean and standard deviation for each measurement
sub.FeaturesNames<-grep("mean\\(\\)|std\\(\\)", FeaturesNames$V2)       
finaldata<-cbind(data.merge[,sub.FeaturesNames], subject=data.merge$subject, activity=data.merge$activity)   

#5.Appropriately labels the data set with descriptive variable names
activityLabels <-read.table("./data/UCI HAR Dataset/activity_labels.txt",header = FALSE)    
finaldata$activity<-factor(finaldata$activity,labels=c("WALKING","WALKING_UPSTAIRS","WALKING_DOWNSTAIRS","SITTING","STANDING","LAYING"), ordered=is.ordered(finaldata$activity))   
names(finaldata)<-gsub("^t", "time", names(finaldata))    
names(finaldata)<-gsub("^f", "frequency", names(finaldata))   
names(finaldata)<-gsub("Acc", "Accelerometer", names(finaldata))    
names(finaldata)<-gsub("Gyro", "Gyroscope", names(finaldata))    
names(finaldata)<-gsub("Mag", "Magnitude", names(finaldata))    
names(finaldata)<-gsub("BodyBody", "Body", names(finaldata))   

#6.From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject   
library(plyr)   
finaldata1<-aggregate(. ~subject + activity, finaldata, mean)   
finaldata1<-finaldata1[order(finaldata1$subject,finaldata1$activity),]   
write.table(finaldata1, file = "tidydata.txt",row.name=FALSE)   

