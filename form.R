# R play with scarping weather data - CIMIS
# 20130205 - Hugh Crockford

library(RCurl)
library(RHTMLForms)

# forms = getHTMLFormDescription("http://wwwcimis.water.ca.gov/cimis/hourlyReport.do")	# logins?
forms = getHTMLFormDescription("http://wwwcimis.water.ca.gov/cimis/hourlyReport.do", userpwd="hughec:tKEk3K9H")	# logins?
forms = getHTMLFormDescription("~/Dropbox/heat/thi_index/CIMIS.html")
cimis = forms[[1]]	# get the one form of

str(cimis)	# better way to visualise lists?


opts = cimis$elements
names(opts)
stations = opts$stationList[["options"]]		# get list of available stations
sensors = opts$sensorList[["options"]]		# and list of available sensors

fun = createFunction(forms[[1]])	# create form function

o = fun(enableHourList="",startYear="2012",startMonth="JAN",startDay="1",hourList="0100")	# dont think it;s connecting?


# getcurl handle
# cookijar cookie file.
# take cookie and pass w curl - bervose - true

# geturlcontent frontpage -  login
# get htmlform desc.
# htmlparse astect -= text =true.

# createfun(login,curl=curl - return cookie to curl function)

# always use curl handle


# to test - grab ccokie.

# noaa - rest server
# return json, xml.


