# R play with scarping weather data - CIMIS
# 20130205 - Hugh Crockford

library(RCurl)
library(RHTMLForms)

# forms = getHTMLFormDescription("http://wwwcimis.water.ca.gov/cimis/hourlyReport.do")
forms = getHTMLFormDescription("~/Dropbox/heat/thi_index/CIMIS.html")
cimis = forms[[1]]	# get the one form of


nom = names(cimis$elements)	# get names
stations = nom$stationList[["options"]]		# get list of available stations
sensors = nom$sensorList[["options"]]		# and list of available sensors

fun = createFunction(forms[[1]])	# create form function

o = fun(enableHourList="",startYear="2012",startMonth="JAN",startDay="1",hourList="0100")	# 
