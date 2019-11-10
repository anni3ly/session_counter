library(plyr)
library(forcats)
library(data.table)
library(tidyr)
library(purrr)
library(dplyr)

session_count<-function(df) {
  seq(1, nrow(df), by=1)
}

FR_data <- read.csv(file="FR_data.csv")

FR_data$subject<-fct_inorder(FR_data$subject)
FR_data<- as.data.table(FR_data)
FR_data<- FR_data[order(FR_data$edate),]
FR_data<-FR_data %>% group_by(subject)%>% nest()
FR_data<-FR_data %>% mutate(session=map(data,session_count))
FR_data<-FR_data %>% unnest()
FR_data<-with(FR_data, FR_data[order(session),])


