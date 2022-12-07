setwd("~/Desktop/finalproj/Rproject/Rproject2022")

# function to convert .txt files to csv 
convertY <- function(dir) {
  files <- list.files(dir, pattern="*.txt")
  for(i in 1:length(files)){
    curr <- paste(dir, files[i], sep="/")
    csv_curr <- read.table(file = curr, sep = " ", header = TRUE)
    write.csv(csv_curr, file = (paste(dir, gsub("txt", "csv", files[i]), sep = "/")), row.names = FALSE)
  }
}

