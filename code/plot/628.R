data=read.csv('expand.csv')
data_o=read.csv('BBQ.csv')
bre=c(1.75,2.25,2.75,3.25,3.75,4.25,4.75,5.25)
hist(data_o$stars[str_detect(data_o$categories,'Chinese')],xlab = 'stars',main='Chinese Barbeque')
hist(data_o$stars[str_detect(data_o$categories,'American')],xlab = 'stars',main='American Barbeque')
hist(data_o$stars[str_detect(data_o$categories,'Korean')],xlab = 'stars',main='Korean Barbeque')

hist(data$stars[str_detect(data$Ambience,"'casual': True")],bre,xlab = 'stars',main='casual ambience')
hist(data$stars[str_detect(data$Ambience,"'casual': False")],bre,xlab = 'stars',main='not casual ambience')
t.test(data$stars[str_detect(data$Ambience,"'casual': True")],data$stars[str_detect(data$Ambience,"'casual': False")])

hist(data$stars[str_detect(data$NoiseLevel,'quiet')],bre,xlab = 'stars',main='quiet noise',freq=F)
hist(data$stars[str_detect(data$NoiseLevel,'average')],bre,xlab = 'stars',main='average noise',freq = F)
hist(data$stars[str_detect(data$NoiseLevel,'loud')],bre,xlab = 'stars',main='loud noise',freq=F)

hist(data$stars[str_detect(data$BusinessParking,'True')],bre,xlab = 'stars',main='parking available',freq=F)
hist(data$stars[str_detect(data$BusinessParking,'True')==FALSE],bre,xlab = 'stars',main='parking unavailable',freq=F)
t.test(data$stars[str_detect(data$BusinessParking,'True')],data$stars[str_detect(data$BusinessParking,'True')==FALSE])

hist(data$stars[str_detect(data$Alcohol,'full_bar')],bre,xlab = 'stars',main='full bar',freq=F)
hist(data$stars[str_detect(data$Alcohol,'beer_and_wine')],bre,xlab = 'stars',main='beer and wine',freq=F)
hist(data$stars[str_detect(data$Alcohol,'none')],bre,xlab = 'stars',main='none',freq=F)

hist(data$stars[data$OutdoorSeating=='True'],bre,xlab = 'stars',main='outseating',freq=F)
hist(data$stars[data$OutdoorSeating!='True'],bre,xlab = 'stars',main='no outseating',freq=F)
t.test(data$stars[data$OutdoorSeating=='True'],data$stars[data$OutdoorSeating!='True'],var.equal = T)

hist(data$stars[data$RestaurantsPriceRange2==1],bre,xlab = 'stars',main='pricerange 1',freq=F)
hist(data$stars[data$RestaurantsPriceRange2==2],bre,xlab = 'stars',main='pricerange 2',freq=F)
t.test(data$stars[data$RestaurantsPriceRange2==1],data$stars[data$RestaurantsPriceRange2==2],var.equal = T)

