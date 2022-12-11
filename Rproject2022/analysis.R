setwd("~/Desktop/finalproj/Rproject/Rproject2022")

# set up and link
library(ggplot2)
library(cowplot)
source('supportingFunctions.R')

################# main script that calls all the functions in supportingFunctions.R   ########################


###### FUNCTION CONVERT CALL ##########
# function that converts tab or space delimeted text files to comma delimited csv files
#   ***countryX is already in csv form so this step is not necessary
convert_csv("countryY")


###### FUNCTION COMPILE CALL ##########
# function that compiles ALL csv files into a SINGLE csv file
# same 12 columns as original and countryX/Y and day of year in new columns

### mini function user input ###
# user options
    # 1. remove rows with NAs in any column
    # 2. include NAs but be warned of their presence
    # 3. include NAs but don't be warned

# call compile function with choice
    # clear any previous compilations
if (file.exists("all.csv")) {
  unlink("all.csv")
}
x_df <- compile("countryX", 2)
y_df <- compile("countryY", 2)
combined <- rbind(x_df, y_df)
write.csv(combined, "all.csv", row.names = FALSE)



###### FUNCTION SUMMARIZE CALL ##########
file <- read.csv("allData.csv")   # provided data, we can test with our file too 
summarize(file)


####### THINGS TO DO #########
# 1. do we have to check if they put like an invalid number in
# 2. i don't know how to check if 2 works, if it is actually catching those NAs
# 3. answer questions from beginning of PDF

