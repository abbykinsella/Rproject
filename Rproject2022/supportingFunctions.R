setwd("~/Desktop/finalproj/Rproject/Rproject2022")


######## FUNCTION CONVERT  ##########
# function to convert .txt files to csv 
convert_csv <- function(dir) {
  # get all the files from the directory
  files <- list.files(dir, pattern="*.txt")
  
  print("Files being converted to CSV files...")
  
  for(i in 1:length(files)){
    # get the path of the file
    curr <- paste(dir, files[i], sep="/")
    # read the file
    csv_curr <- read.table(file = curr, sep = " ", header = TRUE)
    # create csv file 
    write.csv(csv_curr, file = (paste(dir, gsub("txt", "csv", files[i]), sep = "/")), row.names = FALSE)
  }
  
  print("Files converted.")
}


######## FUNCTION COMPILE  ##########
# function to compile all .csv files in a dir to a single file
compile <- function(dir, toWarn){
  # get all the files in dir
  files <- list.files(dir, pattern = "*.csv")
  # make the data frame for the new csv file
  df <- data.frame(matrix(data = NA, ncol=14, nrow=0))
  for(i in 1:length(files)){
    # get path of current file
    curr <- paste(dir, files[i], sep="/")
    # read the curr file
    curr_csv <- read.csv(curr)
    # set country to whichever country directory passed in
    country <- dir
    # find the day of the file 
    day <- strtoi(substr(files[i],8,10))
    # make the two extra cols
    curr_csv <- cbind(curr_csv, country, day)
    # add the row to the data frame
    df <- rbind(df, curr_csv)
  }
  
  # user options
  # 1. remove rows with NAs in any column
  # 2. include NAs but be warned of their presence
  # 3. include NAs but don't be warned
  
  
  # handle NAs based on user input
  if(toWarn == "1"){
    if(sum(is.na(df))) {
      df <- na.omit(df)
    }
  }
  else{
    if(sum(is.na(df))) {
      if(toWarn == "2") {
        print("Warning: NAs are present")   # only warn if 2 is selected
      }
    }
  }
  
  # write everything to a file!
  write.csv(df, "all.csv", append=TRUE, row.names=FALSE)
  return(df)
}

###### FUNCTION SUMMARIZE  ##########
summarize <- function(file) {
  # number of screens run
  # percent of patients screened that were infected
  # male vs female patients
  # age distribution of patients
  
  summary = data.frame(matrix(ncol = 7, nrow = 0))
  cols <- c("Num of Screens", "Patients Infected", "Male", "Female", "Age Min", "Age Max", "Age Mean")
  colnames(summary) = cols

  return(summary)
}



######## HELPER FUNCTIONS   ##########

# helper function that asks user for choice regarding csv file with all the data
get_choice <- function() {
  print("1. Remove rows with NAs in any column")
  print("2. Include NAs but be warned of their presence")
  print("3. Include NAs but don't be warned")
  choice = readline(prompt = "Enter any number : ")
  return(choice)
}









