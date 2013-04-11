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



forms = getHTMLFormDescription(loginurl)	# logins?
cimis.logon = createFunction(forms[[1]])
curl = getCurlHandle(cookiefile = "")
cimis.logon(pars,.curl = curl)
cimi = getURL("http://wwwcimis.water.ca.gov/cimis/logon.do?forwardURL=/frontHourlyReport&selTab=data",curl = curl,followlocation = TRUE)


forms = getHTMLFormDescription("~/Dropbox/heat/thi_index/CIMIS.html")
cimis = forms[[1]]	# get the one form of
names(cimis$elements)

cimiform = getURL("http://wwwcimis.water.ca.gov/cimis/logon.do?forwardURL=/frontHourlyReport&selTab=data",curl = curl)


getHTMLFormDescription(cimiform)

agent="Mozilla/5.0"
curl = getCurlHandle()
curlSetOpt(cookiejar="cookies.txt",  useragent = agent, followlocation = TRUE, curl=curl)

pars=list(username="hughec", password="tKEk3K9H")
loginurl = "http://wwwcimis.water.ca.gov/cimis/frontLogonData.do"

html=postForm(loginurl, .params = pars, curl=curl)


cimiform = getURL("http://wwwcimis.water.ca.gov/cimis/logon.do?forwardURL=/frontHourlyReport&selTab=data",cookie = "JSESSIONID=25C463314F65CD9442285AFD8EF559DB")
cimiform = getURL("http://wwwcimis.water.ca.gov/cimis/logon.do?forwardURL=/frontHourlyReport&selTab=data",cookie = "BIGipServerPL_CIMIS=2104754954.36895.0000")
cimiform = getURL("http://wwwcimis.water.ca.gov/cimis/logon.do?forwardURL=/frontHourlyReport&selTab=data",cookie = "BIGipServerPL_CIMIS=2104754954.36895.0000",followlocation = TRUE)
cimiform = getURL("wwwcimis.water.ca.gov/",cookie = "BIGipServerPL_CIMIS=2104754954.36895.0000")



############
## DTL example	# WORKING???!??
#############

ff = getHTMLFormDescription("http://pems.dot.ca.gov")
pems.login = createFunction(ff[[1]])
curl = getCurlHandle(cookiefile = "")
invisible(pems.login(username = "hughcrockford@gmail.com",password = "blueod",.curl = curl))

pems.doc = getForm("http://pems.dot.ca.gov/",
		   dnode = "Controller",
		   content = "detector_health",
		   tab = "dh_raw",
		   controller_id = 403159, curl = curl)

out = getURL("http://pems.dot.ca.gov/?dnode=Controller&content=detector_health&tab=dh_raw&controller_id=403159",curl = curl) # do manually
getHTMLFormDescription(out)[[2]]       # works?!?!

fcimi = getHTMLFormDescription("http://wwwcimis.water.ca.gov/cimis/frontLogonData.do")
cimi.logon = createFunction(fcimi[[1]])
curl = getCurlHandle(cookiefile = "")
invisible(cimi.logon(username = "hughec1329",password = "tKEk3K9H",.curl = curl))
ret = getURL("http://wwwcimis.water.ca.gov/cimis/frontHourlyReport.do",curl = curl)
getHTMLFormDescription(ret)       # works?!?!



