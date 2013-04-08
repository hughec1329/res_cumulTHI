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

# map all stations
points(x=gs$LAT/1000,y=gs$LON/1000)
ca = get_map(location = "ca",zoom = 6)
jpeg("gsod_map.jpg",quality = 100)

pdf("gsod_map.pdf")
ggmap(ca) + geom_point(aes(x = LON/1000, y = LAT/1000),data = gs,pch=4) + ggtitle('Location of GSOD stations, CA')
dev.off()

# only big stations - data 2000 - 2012
gsbig = read.csv("./bigCA.csv",sep = ",",header = FALSE)
names(gsbig) = c("USAF","WBAN","STATION NAME","CTRY","coutry", "ST", "CALL","LAT", "LON","ELEV(.1M)", "BEGIN","END")
ca = get_map(location = "ca",zoom = 6)
ggmap(ca) + geom_point(aes(x = LON/1000, y = LAT/1000),data = gsbig)

# both
ggmap(ca,legend = 'bottomright') + 
geom_point(aes(x = LON/1000, y = LAT/1000),data = gs) + 
geom_point(aes(x = LON/1000, y = LAT/1000,colour = c(stationsGT10y = "red")),data = gsbig) +
ggtitle('GSOD station in CA')

# with dairies
dairy = read.csv("ca_dairy_list.csv",header = TRUE,stringsAsFactors = FALSE)
addy = do.call(paste,dairy[,3:6])
add = addy[!grepl("BOX",addy)]         # 1323 that arent po box (lost 13 %)

source("geocoder.R")
coords = sapply(add,geocode)
u = data.frame(t(coords))              # ggmap's geocode does funny things, mine overflows
o = data.frame(matrix(unlist(u),,2))

ggmap(ca) + 
geom_point(aes(x = LON/1000, y = LAT/1000),data = gs,pch=4) + 
geom_point(aes(x = lon, y = lat),data = data.frame(t(coords)),pch=18,color = "red") + 
ggtitle('Location of GSOD stations, CA')

pdf("gsod_dairies.pdf")
ggmap(ca) + 
geom_point(aes(x = lon, y = lat),data = o,pch=18,color = "red") +
geom_point(aes(x = LON/1000, y = LAT/1000),data = gs,pch=4)+
ggtitle('Location of GSOD stations(black) and dairies(red) in CA')
dev.off()

# using cimis		## can calc distance from w lat long, then querey cimis data with script.
# or just dl all cimis data from cimis big station then calc nearest
cimis = read.csv("CIMIS_STATIONS.csv")
pdf("cimis_map.pdf")
ggmap(ca) + 
geom_point(aes(x = lon, y = lat),data = o,pch=18,color = "red") +
geom_point(aes(x = Long, y = Lat),data = cimis,pch=4)+
ggtitle('Location of CIMIS stations(black) and dairies(red) in CA')
dev.off()

# only big cimis
bigcimis = cimis[start < as.POSIXct("2000-01-01") & is.na(end),]
pdf("cimis_map.pdf")
ggmap(ca) + 
geom_point(aes(x = Long, y = Lat),data = bigcimis,pch=4)
ggtitle('Location of CIMIS stations(black) and dairies(red) in CA')
dev.off()
