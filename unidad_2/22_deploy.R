# install.packages("rsconnect")
library(rsconnect)

rsconnect::setAccountInfo(name='dqdatasci',
                          token='55BD8E47CE6658D123F9A1528A45110A',
                          secret='7SogJUYNK6UfEyrW1OcQssk+LdGGLMp8/TemclU/')

rsconnect::deployApp(appDir = "C://Users/HP/Projects/est_4/unidad_2/22_shiny/",
                     appName = "22_myapp")


rsconnect::showLogs(appName = "22_myapp")

