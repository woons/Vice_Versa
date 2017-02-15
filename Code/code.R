#install.packages("foreign")
#install.packages("tidyverse")
library(foreign)
library(tidyverse)


#http://stat.seoul.go.kr/jsp3/stat.db.jsp?link=4&cot=021
fire <- read.csv("fire.csv", stringsAsFactors = F, encoding = "utf-8")
seoul_map <- read.dbf("convert.dbf")

#필요한 열만 선택
fire <- fire %>% select(동, 합계)

#동이름을 seoul_map 기준으로 맞춤
colnames(fire) <- c("name", "value")

#중간의 구별 소계값 날림
fire <- fire %>% filter(name != "합계" & name != "소계")

final <- left_join(seoul_map, fire)
final[is.na(final)] <- 0

final$value <- as.numeric(final$value)
is.numeric(final$value)

write.dbf(final, "convert2.dbf")
