107-2 大數據分析方法 作業一
================
put your name here

搞不清楚各行各業的薪資差異嗎? 念研究所到底對第一份工作的薪資影響有多大? CP值高嗎? 透過分析**初任人員平均經常性薪資**-
[開放資料連結](https://data.gov.tw/dataset/6647)，可初步了解台灣近幾年各行各業、各學歷的起薪。

## 比較103年度和106年度大學畢業者的薪資資料

### 資料匯入與處理

``` r
library(jsonlite)
```

    ## Warning: package 'jsonlite' was built under R version 3.5.3

``` r
library(dplyr)
```

    ## Warning: package 'dplyr' was built under R version 3.5.3

    ## 
    ## Attaching package: 'dplyr'

    ## The following objects are masked from 'package:stats':
    ## 
    ##     filter, lag

    ## The following objects are masked from 'package:base':
    ## 
    ##     intersect, setdiff, setequal, union

``` r
library(readr)
```

    ## Warning: package 'readr' was built under R version 3.5.3

``` r
#fromjson()
#inner_join()

  X103eduatta_salary <- read_csv("C:/Users/kazusa/Desktop/work/103eduatta_salary.csv")
```

    ## Parsed with column specification:
    ## cols(
    ##   年度 = col_double(),
    ##   大職業別 = col_character(),
    ##   `經常性薪資-薪資` = col_double(),
    ##   `經常性薪資-女/男` = col_double(),
    ##   `國中及以下-薪資` = col_character(),
    ##   `國中及以下-女/男` = col_character(),
    ##   `高中或高職-薪資` = col_character(),
    ##   `高中或高職-女/男` = col_character(),
    ##   `專科-薪資` = col_character(),
    ##   `專科-女/男` = col_character(),
    ##   `大學-薪資` = col_character(),
    ##   `大學-女/男` = col_character(),
    ##   `研究所及以上-薪資` = col_character(),
    ##   `研究所及以上-女/男` = col_character()
    ## )

``` r
  X104eduatta_salary <- read_csv("C:/Users/kazusa/Desktop/work/104eduatta_salary.csv")
```

    ## Parsed with column specification:
    ## cols(
    ##   年度 = col_double(),
    ##   大職業別 = col_character(),
    ##   `經常性薪資-薪資` = col_double(),
    ##   `經常性薪資-女/男` = col_character(),
    ##   `國中及以下-薪資` = col_character(),
    ##   `國中及以下-女/男` = col_character(),
    ##   `高中或高職-薪資` = col_character(),
    ##   `高中或高職-女/男` = col_character(),
    ##   `專科-薪資` = col_character(),
    ##   `專科-女/男` = col_character(),
    ##   `大學-薪資` = col_character(),
    ##   `大學-女/男` = col_character(),
    ##   `研究所及以上-薪資` = col_character(),
    ##   `研究所及以上-女/男` = col_character()
    ## )

``` r
  X105eduatta_salary <- read_csv("C:/Users/kazusa/Desktop/work/105eduatta_salary.csv")
```

    ## Parsed with column specification:
    ## cols(
    ##   年度 = col_double(),
    ##   大職業別 = col_character(),
    ##   `經常性薪資-薪資` = col_double(),
    ##   `經常性薪資-女/男` = col_character(),
    ##   `國中及以下-薪資` = col_character(),
    ##   `國中及以下-女/男` = col_character(),
    ##   `高中或高職-薪資` = col_character(),
    ##   `高中或高職-女/男` = col_character(),
    ##   `專科-薪資` = col_character(),
    ##   `專科-女/男` = col_character(),
    ##   `大學-薪資` = col_character(),
    ##   `大學-女/男` = col_character(),
    ##   `研究所及以上-薪資` = col_character(),
    ##   `研究所及以上-女/男` = col_character()
    ## )

``` r
  X106eduatta_salary <- read_csv("C:/Users/kazusa/Desktop/work/106eduatta_salary.csv")
```

    ## Parsed with column specification:
    ## cols(
    ##   年度 = col_double(),
    ##   大職業別 = col_character(),
    ##   `經常性薪資-薪資` = col_double(),
    ##   `經常性薪資-女/男` = col_character(),
    ##   `國中及以下-薪資` = col_character(),
    ##   `國中及以下-女/男` = col_character(),
    ##   `高中或高職-薪資` = col_character(),
    ##   `高中或高職-女/男` = col_character(),
    ##   `專科-薪資` = col_character(),
    ##   `專科-女/男` = col_character(),
    ##   `大學-薪資` = col_character(),
    ##   `大學-女/男` = col_character(),
    ##   `研究所及以上-薪資` = col_character(),
    ##   `研究所及以上-女/男` = col_character()
    ## )

``` r
  X103eduatta_salary$大職業別<-gsub("_","、",X103eduatta_salary$大職業別)
  X104eduatta_salary$大職業別<-gsub("_","、",X104eduatta_salary$大職業別)
  X105eduatta_salary$大職業別<-gsub("_","、",X105eduatta_salary$大職業別)
  X106eduatta_salary$大職業別<-gsub("_","、",X106eduatta_salary$大職業別)
  
  X106eduatta_salary$`經常性薪資-薪資`<-gsub("—","0",X106eduatta_salary$`經常性薪資-薪資`)
  
  X106eduatta_salary$`經常性薪資-女/男`<-gsub("…","0",X106eduatta_salary$`經常性薪資-女/男`)
  
  X106eduatta_salary$`國中及以下-薪資`<-gsub("—","0",X106eduatta_salary$`國中及以下-薪資`)
  X106eduatta_salary$`國中及以下-薪資`<-gsub("…","0",X106eduatta_salary$`國中及以下-薪資`)
  
  X106eduatta_salary$`國中及以下-女/男`<-gsub("—","0",X106eduatta_salary$`國中及以下-女/男`)
  X106eduatta_salary$`國中及以下-女/男`<-gsub("…","0",X106eduatta_salary$`國中及以下-女/男`)
  
  X106eduatta_salary$`高中或高職-薪資`<-gsub("—","0",X106eduatta_salary$`高中或高職-薪資`)
  X106eduatta_salary$`高中或高職-薪資`<-gsub("…","0",X106eduatta_salary$`高中或高職-薪資`)
  
  X106eduatta_salary$`高中或高職-女/男`<-gsub("—","0",X106eduatta_salary$`高中或高職-女/男`)
  X106eduatta_salary$`高中或高職-女/男`<-gsub("…","0",X106eduatta_salary$`高中或高職-女/男`)
  
  X106eduatta_salary$`專科-薪資`<-gsub("—","0",X106eduatta_salary$`專科-薪資`)
  X106eduatta_salary$`專科-薪資`<-gsub("…","0",X106eduatta_salary$`專科-薪資`)
  
  X106eduatta_salary$`專科-女/男`<-gsub("—","0",X106eduatta_salary$`專科-女/男`)
  X106eduatta_salary$`專科-女/男`<-gsub("…","0",X106eduatta_salary$`專科-女/男`)
  
  X106eduatta_salary$`大學-薪資`<-gsub("—","0",X106eduatta_salary$`大學-薪資`)
  X106eduatta_salary$`大學-薪資`<-gsub("…","0",X106eduatta_salary$`大學-薪資`)
  
  X106eduatta_salary$`大學-女/男`<-gsub("—","0",X106eduatta_salary$`大學-女/男`)
  X106eduatta_salary$`大學-女/男`<-gsub("…","0",X106eduatta_salary$`大學-女/男`)
  
  X106eduatta_salary$`研究所及以上-薪資`<-gsub("—","0",X106eduatta_salary$`研究所及以上-薪資`)
  X106eduatta_salary$`研究所及以上-薪資`<-gsub("…","0",X106eduatta_salary$`研究所及以上-薪資`)
  
  X106eduatta_salary$`研究所及以上-女/男`<-gsub("—","0",X106eduatta_salary$`研究所及以上-女/男`)
  X106eduatta_salary$`研究所及以上-女/男`<-gsub("…","0",X106eduatta_salary$`研究所及以上-女/男`)
  
  
  X103eduatta_salary$`經常性薪資-薪資`<-gsub("—","0",X103eduatta_salary$`經常性薪資-薪資`)
  
  X103eduatta_salary$`經常性薪資-女/男`<-gsub("…","0",X103eduatta_salary$`經常性薪資-女/男`)
  
  X103eduatta_salary$`國中及以下-薪資`<-gsub("—","0",X103eduatta_salary$`國中及以下-薪資`)
  X103eduatta_salary$`國中及以下-薪資`<-gsub("…","0",X103eduatta_salary$`國中及以下-薪資`)
  
  X103eduatta_salary$`國中及以下-女/男`<-gsub("—","0",X103eduatta_salary$`國中及以下-女/男`)
  X103eduatta_salary$`國中及以下-女/男`<-gsub("…","0",X103eduatta_salary$`國中及以下-女/男`)
  
  X103eduatta_salary$`高中或高職-薪資`<-gsub("—","0",X103eduatta_salary$`高中或高職-薪資`)
  X103eduatta_salary$`高中或高職-薪資`<-gsub("…","0",X103eduatta_salary$`高中或高職-薪資`)
  
  X103eduatta_salary$`高中或高職-女/男`<-gsub("—","0",X103eduatta_salary$`高中或高職-女/男`)
  X103eduatta_salary$`高中或高職-女/男`<-gsub("…","0",X103eduatta_salary$`高中或高職-女/男`)
  
  X103eduatta_salary$`專科-薪資`<-gsub("—","0",X103eduatta_salary$`專科-薪資`)
  X103eduatta_salary$`專科-薪資`<-gsub("…","0",X103eduatta_salary$`專科-薪資`)
  
  X103eduatta_salary$`專科-女/男`<-gsub("—","0",X103eduatta_salary$`專科-女/男`)
  X103eduatta_salary$`專科-女/男`<-gsub("…","0",X103eduatta_salary$`專科-女/男`)
  
  X103eduatta_salary$`大學-薪資`<-gsub("—","0",X103eduatta_salary$`大學-薪資`)
  X103eduatta_salary$`大學-薪資`<-gsub("…","0",X103eduatta_salary$`大學-薪資`)
  
  X103eduatta_salary$`大學-女/男`<-gsub("—","0",X103eduatta_salary$`大學-女/男`)
  X103eduatta_salary$`大學-女/男`<-gsub("…","0",X103eduatta_salary$`大學-女/男`)
  
  X103eduatta_salary$`研究所及以上-薪資`<-gsub("—","0",X103eduatta_salary$`研究所及以上-薪資`)
  X103eduatta_salary$`研究所及以上-薪資`<-gsub("…","0",X103eduatta_salary$`研究所及以上-薪資`)
  
  X103eduatta_salary$`研究所及以上-女/男`<-gsub("—","0",X103eduatta_salary$`研究所及以上-女/男`)
  X103eduatta_salary$`研究所及以上-女/男`<-gsub("…","0",X103eduatta_salary$`研究所及以上-女/男`)
  
  X104eduatta_salary$`大學-女/男`<-gsub("—","0",X104eduatta_salary$`大學-女/男`)
  X104eduatta_salary$`大學-女/男`<-gsub("…","0",X104eduatta_salary$`大學-女/男`)
  
  X105eduatta_salary$`大學-女/男`<-gsub("—","0",X105eduatta_salary$`大學-女/男`)
  X105eduatta_salary$`大學-女/男`<-gsub("…","0",X105eduatta_salary$`大學-女/男`)
  
  X106eduatta_salary$`大學-薪資`<-as.numeric(X106eduatta_salary$`大學-薪資`)
  X103eduatta_salary$`大學-薪資`<-as.numeric(X103eduatta_salary$`大學-薪資`)
  X106eduatta_salary$`大學-女/男`<-as.numeric(X106eduatta_salary$`大學-女/男`)
  X105eduatta_salary$`大學-女/男`<-as.numeric(X105eduatta_salary$`大學-女/男`)
  X104eduatta_salary$`大學-女/男`<-as.numeric(X104eduatta_salary$`大學-女/男`)
  X103eduatta_salary$`大學-女/男`<-as.numeric(X103eduatta_salary$`大學-女/男`)

X106eduatta_salary$`大學-薪資`<-as.numeric(X106eduatta_salary$`大學-薪資`)
X103eduatta_salary$`大學-薪資`<-as.numeric(X103eduatta_salary$`大學-薪資`)
X106eduatta_salary$`經常性薪資-女/男`<-as.numeric(X106eduatta_salary$`經常性薪資-女/男`)

a1<-X106eduatta_salary$`大學-薪資`
b1<-X103eduatta_salary$`大學-薪資`
```

### 106年度薪資較103年度薪資高的職業有哪些?

解釋:106難度較103年度薪資高的工作前十名，yearincreaserate為增加的比率

方法:我是用X106eduatta\_salary和X103eduatta\_salary資料表的`大學-薪資`向量計算出新的yearincreaserate向量再將該向量加入X106eduatta\_salary資料表進行排序取前10項

``` r
#這是R Code Chunk

        a1<-X106eduatta_salary$`大學-薪資`
        b1<-X103eduatta_salary$`大學-薪資`
        X106eduatta_salary$yearincreaserate<-(a1-b1)/b1

knitr::kable(
        head(arrange(X106eduatta_salary,desc(yearincreaserate)),10)
            )
```

|  年度  | 大職業別                  | 經常性薪資-薪資 | 經常性薪資-女/男 | 國中及以下-薪資 | 國中及以下-女/男 | 高中或高職-薪資 | 高中或高職-女/男 | 專科-薪資 | 專科-女/男 | 大學-薪資 | 大學-女/男 | 研究所及以上-薪資 | 研究所及以上-女/男 | yearincreaserate |
| :--: | :-------------------- | :------- | :-------: | :------- | :-------- | :------- | :-------- | :---- | :----- | :---: | :----: | :-------- | :--------- | ---------------: |
| 2017 | 其他服務業-技術員及助理專業人員      | 27270    |   98.31   | 0        | 0         | 0        | 0         | 25785 | 97.84  | 27929 | 96.84  | 33500     | 0          |        0.1312784 |
| 2017 | 住宿及餐飲業-服務及銷售工作人員      | 24468    |   99.76   | 23639    | 99.64     | 23873    | 99.65     | 24506 | 99.75  | 25486 | 99.98  | 0         | 0          |        0.1294983 |
| 2017 | 用水供應及污染整治業-技術員及助理專業人員 | 31505    |   98.77   | 0        | 0         | 0        | 0         | 30475 | 99.86  | 31560 | 99.61  | 33588     | 95.7       |        0.1294017 |
| 2017 | 專業、科學及技術服務業-專業人員      | 35538    |   98.80   | 0        | 0         | 0        | 0         | 0     | 0      | 33384 | 98.93  | 38415     | 99.07      |        0.1136538 |
| 2017 | 其他服務業-技藝、機械設備操作及組裝人員  | 24938    |   98.20   | 0        | 0         | 23638    | 98.03     | 25513 | 97.75  | 26880 | 99.49  | 0         | 0          |        0.1097350 |
| 2017 | 營造業-服務及銷售工作人員         | 27308    |   96.68   | 24667    | 0         | 26000    | 0         | 27500 | 0      | 30125 | 95.93  | 0         | 0          |        0.1090046 |
| 2017 | 其他服務業-專業人員            | 32250    |  100.00   | 0        | 0         | 0        | 0         | 0     | 0      | 32000 |  0.00  | 32500     | 0          |        0.1034483 |
| 2017 | 資訊及通訊傳播業-專業人員         | 33646    |   99.03   | 0        | 0         | 0        | 0         | 0     | 0      | 31817 | 98.60  | 36545     | 99.62      |        0.1032629 |
| 2017 | 不動產業-專業人員             | 34237    |  100.00   | 0        | 0         | 0        | 0         | 0     | 0      | 33632 | 100.00 | 35196     | 100        |        0.0977576 |
| 2017 | 教育服務業-事務支援人員          | 24326    |   98.42   | 0        | 0         | 22431    | 99.79     | 23658 | 98.15  | 24471 | 98.97  | 27826     | 96.37      |        0.0956837 |

### 提高超過5%的的職業有哪些?

解釋:106年教103年薪資提高\>0.05的工作

方法:這邊直接用之前的X106eduatta\_salary和新增的yearincreaserate向量篩選\>0.05的資料進行排序

``` r
#這是R Code Chunk
#X106eduatta_salary$大職業別[X106eduatta_salary$yearincreaserate>0.05]
knitr::kable(
                  head(filter(X106eduatta_salary,
                  yearincreaserate>0.05)%>%
                  arrange(desc(yearincreaserate)),10)
            )
```

|  年度  | 大職業別                  | 經常性薪資-薪資 | 經常性薪資-女/男 | 國中及以下-薪資 | 國中及以下-女/男 | 高中或高職-薪資 | 高中或高職-女/男 | 專科-薪資 | 專科-女/男 | 大學-薪資 | 大學-女/男 | 研究所及以上-薪資 | 研究所及以上-女/男 | yearincreaserate |
| :--: | :-------------------- | :------- | :-------: | :------- | :-------- | :------- | :-------- | :---- | :----- | :---: | :----: | :-------- | :--------- | ---------------: |
| 2017 | 其他服務業-技術員及助理專業人員      | 27270    |   98.31   | 0        | 0         | 0        | 0         | 25785 | 97.84  | 27929 | 96.84  | 33500     | 0          |        0.1312784 |
| 2017 | 住宿及餐飲業-服務及銷售工作人員      | 24468    |   99.76   | 23639    | 99.64     | 23873    | 99.65     | 24506 | 99.75  | 25486 | 99.98  | 0         | 0          |        0.1294983 |
| 2017 | 用水供應及污染整治業-技術員及助理專業人員 | 31505    |   98.77   | 0        | 0         | 0        | 0         | 30475 | 99.86  | 31560 | 99.61  | 33588     | 95.7       |        0.1294017 |
| 2017 | 專業、科學及技術服務業-專業人員      | 35538    |   98.80   | 0        | 0         | 0        | 0         | 0     | 0      | 33384 | 98.93  | 38415     | 99.07      |        0.1136538 |
| 2017 | 其他服務業-技藝、機械設備操作及組裝人員  | 24938    |   98.20   | 0        | 0         | 23638    | 98.03     | 25513 | 97.75  | 26880 | 99.49  | 0         | 0          |        0.1097350 |
| 2017 | 營造業-服務及銷售工作人員         | 27308    |   96.68   | 24667    | 0         | 26000    | 0         | 27500 | 0      | 30125 | 95.93  | 0         | 0          |        0.1090046 |
| 2017 | 其他服務業-專業人員            | 32250    |  100.00   | 0        | 0         | 0        | 0         | 0     | 0      | 32000 |  0.00  | 32500     | 0          |        0.1034483 |
| 2017 | 資訊及通訊傳播業-專業人員         | 33646    |   99.03   | 0        | 0         | 0        | 0         | 0     | 0      | 31817 | 98.60  | 36545     | 99.62      |        0.1032629 |
| 2017 | 不動產業-專業人員             | 34237    |  100.00   | 0        | 0         | 0        | 0         | 0     | 0      | 33632 | 100.00 | 35196     | 100        |        0.0977576 |
| 2017 | 教育服務業-事務支援人員          | 24326    |   98.42   | 0        | 0         | 22431    | 99.79     | 23658 | 98.15  | 24471 | 98.97  | 27826     | 96.37      |        0.0956837 |

``` r
joban<-filter(X106eduatta_salary,
              yearincreaserate>0.05)
```

### 主要的職業種別是哪些種類呢?

解釋:主要的職業種別與其統計量

方法:我將大職業別以-分割取出再存入spjob中進行統計

``` r
#這是R Code Chunk
job<-strsplit(joban$大職業別,"[-]")

spjob<- c()
for(i in 1:length(job)){
  spjob[i]<- job[[i]][1]}

knitr::kable(table(spjob))
```

| spjob       | Freq |
| :---------- | ---: |
| 工業及服務業部門    |    1 |
| 工業部門        |    1 |
| 不動產業        |    1 |
| 支援服務業       |    3 |
| 用水供應及污染整治業  |    6 |
| 住宿及餐飲業      |    4 |
| 其他服務業       |    5 |
| 服務業部門       |    5 |
| 金融及保險業      |    1 |
| 專業、科學及技術服務業 |    5 |
| 教育服務業       |    5 |
| 資訊及通訊傳播業    |    5 |
| 運輸及倉儲業      |    4 |
| 電力及燃氣供應業    |    2 |
| 製造業         |    1 |
| 營造業         |    3 |
| 醫療保健服務業     |    2 |
| 藝術、娛樂及休閒服務業 |    3 |
| 礦業及土石採取業    |    1 |

## 男女同工不同酬現況分析

男女同工不同酬一直是性別平等中很重要的問題，分析資料來源為103到106年度的大學畢業薪資。

### 103到106年度的大學畢業薪資資料，哪些行業男生薪資比女生薪資多?

解釋:103-106年男生薪資持續\>女生的工作,排序後前十名(以4年平均)

方法:這裡是先將每年的:大職業別，大學-女/男 以select
function取出再以`大學-女/男`\<100篩選並存在分別的4個向量中，以inner\_join
function將4個向量合併並排序取出前10個

``` r
#這是R Code Chunk
BGY106<-select(X106eduatta_salary,大職業別,`大學-女/男`)%>%
  filter(`大學-女/男`<100)


BGY105<-select(X105eduatta_salary,大職業別,`大學-女/男`)%>%
  filter(`大學-女/男`<100)

BGY104<-select(X104eduatta_salary,大職業別,`大學-女/男`)%>%
  filter(`大學-女/男`<100)

BGY103<-select(X103eduatta_salary,大職業別,`大學-女/男`)%>%
  filter(`大學-女/男`<100)

  #arrange(desc(`經常性薪資-女/男`))

f<-inner_join(BGY106,BGY105,by="大職業別")%>%
  inner_join(BGY104,by="大職業別")%>%
  inner_join(BGY103,by="大職業別")

f$Yearsmean<-round((f$`大學-女/男.x`+
                      f$`大學-女/男.y`+
                      f$`大學-女/男.x.x`+
                      f$`大學-女/男.y.y`)/4,digits =2)

knitr::kable(
    head(filter(f,`大學-女/男.x`<100&`大學-女/男.x`!=0&
                  `大學-女/男.y`<100&`大學-女/男.y`!=0&
                  `大學-女/男.x.x`<100&`大學-女/男.x.x`!=0&
                  `大學-女/男.y.y`<100&`大學-女/男.y.y`!=0)%>%arrange(Yearsmean)
               ,10)
             )
```

| 大職業別                    | 大學-女/男.x | 大學-女/男.y | 大學-女/男.x.x | 大學-女/男.y.y | Yearsmean |
| :---------------------- | :------: | :------: | :--------: | :--------: | --------: |
| 礦業及土石採取業-技藝、機械設備操作及組裝人員 |  96.91   |  99.18   |   93.10    |   84.97    |     93.54 |
| 電力及燃氣供應業-技藝、機械設備操作及組裝人員 |  95.51   |  98.20   |   91.69    |   91.77    |     94.29 |
| 營造業                     |  96.71   |  95.78   |   96.35    |   95.58    |     96.11 |
| 其他服務業-技術員及助理專業人員        |  96.84   |  99.37   |   98.94    |   89.36    |     96.13 |
| 其他服務業                   |  96.57   |  96.72   |   96.84    |   96.21    |     96.58 |
| 其他服務業-事務支援人員            |  96.23   |  97.48   |   95.47    |   97.26    |     96.61 |
| 礦業及土石採取業                |  97.41   |  97.70   |   95.28    |   96.27    |     96.66 |
| 運輸及倉儲業-事務支援人員           |  96.83   |  96.89   |   96.95    |   97.15    |     96.96 |
| 營造業-事務支援人員              |  97.46   |  95.65   |   98.12    |   97.11    |     97.09 |
| 教育服務業                   |  97.59   |  98.40   |   96.44    |   95.91    |     97.09 |

### 哪些行業女生薪資比男生薪資多?

解釋:103-106年男生薪資持續\<女生的工作,排序後前十名(以4年平均),不幸的並無資料符合標準,因此我仍列出各年度符合標準的資料

方法:這裡是先將每年的:大職業別，大學-女/男 以select
function取出再以`大學-女/男`\>100篩選並存在分別的4個向量中，以inner\_join
function將4個向量合併並排序取出前10個

``` r
#這是R Code Chunk
GBY106<-select(X106eduatta_salary,大職業別,`大學-女/男`)%>%
  filter(`大學-女/男`>100)%>%arrange(desc(`大學-女/男`))


GBY105<-select(X105eduatta_salary,大職業別,`大學-女/男`)%>%
  filter(`大學-女/男`>100)%>%arrange(desc(`大學-女/男`))

GBY104<-select(X104eduatta_salary,大職業別,`大學-女/男`)%>%
  filter(`大學-女/男`>100)%>%arrange(desc(`大學-女/男`))

GBY103<-select(X103eduatta_salary,大職業別,`大學-女/男`)%>%
  filter(`大學-女/男`>100)%>%arrange(desc(`大學-女/男`))

  #arrange(desc(`經常性薪資-女/男`))

f2<-inner_join(GBY106,GBY105,by="大職業別")%>%
  inner_join(GBY104,by="大職業別")%>%
  inner_join(GBY103,by="大職業別")

f2$Yearsmean<-round((f2$`大學-女/男.x`+
                      f2$`大學-女/男.y`+
                      f2$`大學-女/男.x.x`+
                      f2$`大學-女/男.y.y`)/4,digits =2)

knitr::kable(
      head(filter(f2,`大學-女/男.x`>100&`大學-女/男.x`!=0&
                    `大學-女/男.y`>100&`大學-女/男.y`!=0&
                    `大學-女/男.x.x`>100&`大學-女/男.x.x`!=0&
                    `大學-女/男.y.y`>100&`大學-女/男.y.y`!=0)%>%arrange(desc(Yearsmean))
                 ,10)
            )
```

| 大職業別 | 大學-女/男.x | 大學-女/男.y | 大學-女/男.x.x | 大學-女/男.y.y | Yearsmean |
| :--- | -------: | -------: | ---------: | ---------: | --------: |

``` r
#106年度
knitr::kable(GBY106)
```

| 大職業別               | 大學-女/男 |
| :----------------- | :----: |
| 資訊及通訊傳播業-服務及銷售工作人員 | 100.33 |

``` r
#105年度
knitr::kable(GBY105)
```

| 大職業別        | 大學-女/男 |
| :---------- | :----: |
| 金融及保險業-專業人員 | 100.11 |

``` r
#104年度
knitr::kable(GBY104)
```

| 大職業別                       | 大學-女/男 |
| :------------------------- | :----: |
| 專業、科學及技術服務業-技藝、機械設備操作及組裝人員 | 100.26 |

``` r
#103年度
knitr::kable(GBY103)
```

| 大職業別 | 大學-女/男 |
| :--- | -----: |

## 研究所薪資差異

以106年度的資料來看，哪個職業別念研究所最划算呢
(研究所學歷薪資與大學學歷薪資增加比例最多)?

解釋:礦業及土石採取業-事務支援人員CP值最高，並且列出之後10名的工作

方法:這裡我是將X106eduatta\_salary先存入x106edua變數中，將`研究所及以上-薪資`和`大學-薪資`以as.numeric()數據化，並計算薪資增加的比例存成increaserate\_from\_UStoGU向量在x106edua中在排序出結果

``` r
#這是R Code Chunk
x106edua<-X106eduatta_salary

x106edua$`研究所及以上-薪資`<-gsub("—","0",x106edua$`研究所及以上-薪資`)%>%as.numeric()
x106edua$`大學-薪資`<-gsub("—","0",x106edua$`大學-薪資`)%>%as.numeric()

x106edua<-mutate(x106edua,Increaserate_from_UStoGU = (`研究所及以上-薪資`/`大學-薪資`)/`大學-薪資`)

knitr::kable(
     head(filter(x106edua,Increaserate_from_UStoGU>0)%>%
     arrange(desc(Increaserate_from_UStoGU)),10)
     )
```

|  年度  | 大職業別               | 經常性薪資-薪資 | 經常性薪資-女/男 | 國中及以下-薪資 | 國中及以下-女/男 | 高中或高職-薪資 | 高中或高職-女/男 | 專科-薪資 | 專科-女/男 | 大學-薪資 | 大學-女/男 | 研究所及以上-薪資 | 研究所及以上-女/男 | yearincreaserate | Increaserate\_from\_UStoGU |
| :--: | :----------------- | :------- | :-------: | :------- | :-------- | :------- | :-------- | :---- | :----- | :---: | :----: | :-------: | :--------- | ---------------: | -------------------------: |
| 2017 | 礦業及土石採取業-事務支援人員    | 23441    |   97.21   | 0        | 0         | 22274    | 98.48     | 23075 | 97.63  | 24815 | 99.35  |   30000   | 0          |      \-0.0223387 |                   4.87e-05 |
| 2017 | 藝術、娛樂及休閒服務業-事務支援人員 | 24602    |   97.67   | 0        | 0         | 23648    | 98.13     | 24244 | 99.35  | 24970 | 97.22  |   29657   | 96.13      |        0.0579612 |                   4.76e-05 |
| 2017 | 教育服務業-事務支援人員       | 24326    |   98.42   | 0        | 0         | 22431    | 99.79     | 23658 | 98.15  | 24471 | 98.97  |   27826   | 96.37      |        0.0956837 |                   4.65e-05 |
| 2017 | 其他服務業              | 23848    |   97.61   | 21810    | 99.97     | 22685    | 98.01     | 24007 | 97.41  | 25517 | 96.57  |   29841   | 99.85      |        0.0530291 |                   4.58e-05 |
| 2017 | 教育服務業              | 25383    |   97.80   | 22235    | 101.18    | 22776    | 100.06    | 23953 | 97.84  | 25784 | 97.59  |   29365   | 96.56      |        0.0731261 |                   4.42e-05 |
| 2017 | 專業、科學及技術服務業-事務支援人員 | 26712    |   98.51   | 0        | 0         | 23885    | 99.87     | 25169 | 99.99  | 27035 | 98.85  |   32234   | 99.05      |        0.0420119 |                   4.41e-05 |
| 2017 | 不動產業-事務支援人員        | 26155    |   97.90   | 0        | 0         | 24327    | 98.41     | 26054 | 96.91  | 26212 | 99.68  |   30237   | 98.1       |      \-0.0174307 |                   4.40e-05 |
| 2017 | 支援服務業-事務支援人員       | 25107    |   98.45   | 0        | 0         | 23504    | 98.46     | 24573 | 98.77  | 25628 | 98.87  |   28841   | 99.04      |        0.0429757 |                   4.39e-05 |
| 2017 | 營造業-事務支援人員         | 25195    |   97.49   | 0        | 0         | 23214    | 97.73     | 24520 | 98.02  | 26256 | 97.46  |   29948   | 99.81      |        0.0547967 |                   4.34e-05 |
| 2017 | 批發及零售業             | 26457    |   98.54   | 23376    | 99.02     | 23946    | 98.24     | 25151 | 98.3   | 27611 | 98.70  |   32910   | 99.05      |        0.0398840 |                   4.32e-05 |

## 我有興趣的職業別薪資狀況分析

### 有興趣的職業別篩選，呈現薪資

我有興趣的職業別“工業及服務業部門-專業人員”

``` r
#這是R Code Chunk
favwork<-head(filter(x106edua,grepl("工業及服務業部門-專業人員",x106edua$大職業別)),5)

knitr::kable(
    select(favwork,大職業別,`研究所及以上-薪資`,`大學-薪資`)
            )
```

| 大職業別          | 研究所及以上-薪資 | 大學-薪資 |
| :------------ | :-------: | :---: |
| 工業及服務業部門-專業人員 |   36778   | 32108 |

### 這些職業別研究所薪資與大學薪資差多少呢？

薪資與我想像中不同，太少(增加4670元)，我決定改行

``` r
#這是R Code Chunk
favwork$defferent=(favwork$`研究所及以上-薪資`-favwork$`大學-薪資`)
favwork$GUobUN=(favwork$`研究所及以上-薪資`/favwork$`大學-薪資`)

knitr::kable(
  select(favwork,大職業別,`研究所及以上-薪資`,`大學-薪資`,GUobUN,defferent)%>%
  arrange(by=desc(GUobUN))
            )
```

| 大職業別          | 研究所及以上-薪資 | 大學-薪資 |   GUobUN | defferent |
| :------------ | :-------: | :---: | -------: | --------: |
| 工業及服務業部門-專業人員 |   36778   | 32108 | 1.145447 |      4670 |
