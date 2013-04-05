# script to map location of gsod stations in CA
# 20130403 HCrockford

library(maps)
gs = read.csv("./gsod_ca_stations.csv",sep = ",",header = FALSE)
names(gs) = c("USAF","WBAN","STATION NAME","CTRY","coutry", "ST", "CALL","LAT", "LON","ELEV(.1M)", "BEGIN","END")
map('county','california')
points(x=gs$LAT/1000,y=gs$LON/1000)

# try with world.. where are the points?

map('world')
points(x=gs$LAT/1000,y=gs$LON/1000,pch = 20, col = "red")
points(x=gs$LAT/1000,y=gs$LON/1000,pch = 20, cex = 4, col = "red")

# lat long off?
summary(gs$LAT/1000)
summary(gs$LON/1000)


geocode = function(i){
       dn = gsub(" ","+",i)
       ur = sprintf("http://maps.googleapis.com/maps/api/geocode/json?address=%s&sensor=true",dn)
       out = fromJSON(getURL(ur))
       c(out$results[[1]][[3]]$location$lat,out$results[[1]][[3]]$location$lng)
}

source("./geocoder.R")
address = c("817 arthur st davis ca","248 calder alternate highway lockwood south victoria australia","97 ocean bvld Jan juc vic aus")

# using ggmap
library(ggmap)
library(mapproj)

# map home
hom = sapply(address,geocode)          # 
world = get_map(location = "australia",zoom = 3)
ggmap(world) + geom_point(aes(x = lng, y = lat, color = "red", size = 10),data = data.frame(t(hom)))

# map stations
points(x=gs$LAT/1000,y=gs$LON/1000)
ca = get_map(location = "ca",zoom = 6)
ggmap(ca) + geom_point(aes(x = LON/1000, y = LAT/1000),data = gs)
