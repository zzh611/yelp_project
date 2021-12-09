library(stringr)
library(ggplot2)
data=read.csv('expand.csv')
data$isgood=data$stars>=4
data$OutdoorSeating=data$OutdoorSeating=='True'
data$RestaurantsTakeOut=data$RestaurantsTakeOut=='True'

data$NoiseLevel=gsub("u'",'',data$NoiseLevel)
data$NoiseLevel=gsub("'",'',data$NoiseLevel)
data$is_loud=str_detect(data$NoiseLevel,'d')

data$freewifi=str_detect(data$WiFi,'e')
data$parking=str_detect(data$garage,'T')|str_detect(data$lot,'T')|str_detect(data$street,'T')

data$category=''
data$category[str_detect(data$categories,'Chinese')]='Chinese'
data$category[str_detect(data$categories,'American')]='American'
data$category[str_detect(data$categories,'Korean')]='Korean'
data$category[data$category=='']='Others'

data$casual=str_detect(data$Ambience,"'casual': True")
data$alco=str_detect(data$Alcohol,'r')
model=lm(isgood~OutdoorSeating+is_loud+freewifi+parking+casual+RestaurantsPriceRange2,data=data)
summary(model)

ggplot(data=data,aes(x=stars,y=..density..,fill=OutdoorSeating))+
  geom_histogram(alpha=0.6,position = position_dodge())
ggplot(data=data,aes(x=stars,y=..density..,fill=is_loud))+
  geom_histogram(alpha=0.6,position = position_dodge())

ks.test(data[data$OutdoorSeating==T,]$stars,data[data$OutdoorSeating==F,]$stars,alternative = 'greater')
ks.test(data[data$is_loud==T,]$stars,data[data$is_loud==F,]$stars,alternative = 'less')
ks.test(data[data$freewifi==T,]$stars,data[data$freewifi==F,]$stars)
ks.test(data[data$parking==T,]$stars,data[data$parking==F,]$stars)
ks.test(data[data$casual==T,]$stars,data[data$casual==F,]$stars)
ks.test(data[data$RestaurantsPriceRange2==1,]$stars,data[data$RestaurantsPriceRange2==2,]$stars)

ggplot(data=data,aes(x=stars,y=..density..,fill=parking))+
  geom_histogram(alpha=0.6,position = position_dodge())
ggplot(data=data,aes(x=stars,y=..density..,fill=casual))+
  geom_histogram(alpha=0.6,position = position_dodge())
ggplot(data=data,aes(x=stars,y=..density..,fill=freewifi))+
  geom_histogram(alpha=0.6,position = position_dodge())


