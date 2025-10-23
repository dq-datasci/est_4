# install.packages("rsconnect")
library(rsconnect)
 
rsconnect::setAccountInfo(name=' ',
                          token=' ',
                          secret=' ')
 
rsconnect::deployApp(appDir = "C://..../21_Shiny",
                     appName = "21_myapp")
 
 
#rsconnect::showLogs(appName = "21_myapp")
