# function to geocode addresses to lat long
# 20130403 HCrockford
library(RCurl)
library(RHTMLForms)
library(rjson)

geocode = function(i){
       dn = gsub(" ","+",i)
       ur = sprintf("http://maps.googleapis.com/maps/api/geocode/json?address=%s&sensor=true",dn)
       out = fromJSON(getURL(ur))
       c(lat = out$results[[1]][[3]]$location$lat,lng = out$results[[1]][[3]]$location$lng)
}
