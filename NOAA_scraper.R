# cumul_THI project
# function to scrape noaa site
# 20120322 HCrockford

library(RCurl)
library(RHTMLForms)
library(rjson)
token = "nnHAnvvghOAhHpmKEZtTWWplMXQCQvto"


vmtrc = c(lat = 36.132156,long = -119.321694)
data = getForm("http://www.ncdc.noaa.gov/cdo-services/services/datasets",token = token, .opts = list(httpheader = c("Accept" = "application/xml"))) #  get available datasets in XML
data = getForm("http://www.ncdc.noaa.gov/cdo-services/services/datasets",token = token) #  get available datasets in JSON
fromJSON(data)

p = getForm("http://www.ncdc.noaa.gov/cdo-services/services/datasets/GHCND/locations/ZIP:93274/datatypes",token = token) # search by zip
p = getForm("http://www.ncdc.noaa.gov/cdo-services/services/datasets/GHCND/locations?latitude=36.132156&longitude=-119.321694/datatypes",token = token) # search by lat long
p = getForm("http://www.ncdc.noaa.gov/cdo-services/services/datasets/GHCND",token = token) # seatch by data type

o =  getForm("http://www.ncdc.noaa.gov/cdo-services/services/datasets/GHCND/locationsearch?latitude=36.132156&longitude=-119.321694",token = token, radius = 25)	# get stations 25 clicks around vmtrc
t = unlist(strsplit(o,'"'))
stats = t[grepl("GHCND",t)]	# stations

       q = getForm(sprintf("http://www.ncdc.noaa.gov/cdo-services/services/datasets/GHCND/stations/%s/datatypes",i), token = token) # tulare doesnt have temp, visalia does

w = sapply(stats, function(i){
       Sys.sleep(1)
       getForm(sprintf("http://www.ncdc.noaa.gov/cdo-services/services/datasets/GHCND/stations/%s/datatypes",i), token = token)
})

grep("Dew",w)                          #  none of the datasets accesible by CDO/REST have Humid !!!

home = getURL("http://maps.googleapis.com/maps/api/geocode/json?address=817+Arthur+st+davis+CA&sensor=true")
fromJSON(home)


