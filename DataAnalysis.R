library(jsonlite)
library(dplyr)
library(readr)

X103eduatta_salary <- read_csv("C:/Users/kazusa/Desktop/work/103eduatta_salary.csv")
X104eduatta_salary <- read_csv("C:/Users/kazusa/Desktop/work/104eduatta_salary.csv")
X105eduatta_salary <- read_csv("C:/Users/kazusa/Desktop/work/105eduatta_salary.csv")
X106eduatta_salary <- read_csv("C:/Users/kazusa/Desktop/work/106eduatta_salary.csv")

X106eduatta_salary$大職業別[X106eduatta_salary$yearincreaserate>0.05]

head(filter(X106eduatta_salary,yearincreaserate>0.05)%>%
            arrange(desc(yearincreaserate)),10)

joban<-filter(X106eduatta_salary,
              yearincreaserate>0.05)%>%
  arrange(desc(yearincreaserate)
          
          
job<-strsplit(joban$大職業別,"[-]")

spjob<- c()
for(i in 1:length(job)){
  spjob[i]<- job[[i]][1]}

table(spjob)

X103salary <- read_csv("C:/Users/kazusa/Desktop/work/103worksalary.csv")
X103salary <- read_csv("C:/Users/kazusa/Desktop/work/104worksalary.csv")
X105salary <- read_csv("C:/Users/kazusa/Desktop/work/105worksalary.csv")
X106salary <- read_csv("C:/Users/kazusa/Desktop/work/106worksalary.csv")

X103salary$`專業人員-薪資`<-as.numeric(X103salary$`專業人員-薪資`)
X104salary$`專業人員-薪資`<-as.numeric(X104salary$`專業人員-薪資`)
X105salary$`專業人員-薪資`<-as.numeric(X105salary$`專業人員-薪資`)
X106salary$`專業人員-薪資`<-as.numeric(X106salary$`專業人員-薪資`)

X103salary$年度<-as.numeric(X103salary$年度)
X104salary$年度<-as.numeric(X104salary$年度)
X105salary$年度<-as.numeric(X105salary$年度)
X106salary$年度<-as.numeric(X106salary$年度)

rbind(X103salary,X103salary,X105salary,X106salary)

