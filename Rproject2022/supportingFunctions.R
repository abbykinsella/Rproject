setwd("~/Desktop/finalproj/Rproject/Rproject2022")

# function to convert .txt files to csv 
convertY <- function(dir) {
  # get all the files from the directory
  files <- list.files(dir, pattern="*.txt")
  for(i in 1:length(files)){
    # get the path of the file
    curr <- paste(dir, files[i], sep="/")
    # read the file
    csv_curr <- read.table(file = curr, sep = " ", header = TRUE)
    # create csv file 
    write.csv(csv_curr, file = (paste(dir, gsub("txt", "csv", files[i]), sep = "/")), row.names = FALSE)
  }
}

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
  # remove NAs if remove is passed to function
  if(toWarn == "remove"){
    if(sum(is.na(df))) {
      df <- na.omit(df)
    }
  }
  # else warn of NAs presence if warn is passed to function
  else if(toWarn == "warn"){
    if(sum(is.na(df))) {
      print("Warning: NAs are present")
    }
  }
  write.csv(df, "all.csv", row.names=FALSE)
  return(df)
}
