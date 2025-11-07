# Cargar paquetes
library(rsconnect)
library(here)
library(dotenv)

# Cargar variables de entorno desde el archivo .env
# Esto busca el archivo .env en la raíz del proyecto (unidad_2)
load_dot_env(file = here::here(".env"))

# Configurar la cuenta usando las variables de entorno
# rsconnect busca automáticamente las variables SHINYAPPS_ACCOUNT,
# SHINYAPPS_TOKEN, y SHINYAPPS_SECRET si existen.
# Pero para ser explícitos (y por si tienen otros nombres), las leemos:
rsconnect::setAccountInfo(
  name   = Sys.getenv("SHINYAPPS_NAME"),
  token  = Sys.getenv("SHINYAPPS_TOKEN"),
  secret = Sys.getenv("SHINYAPPS_SECRET")
)

rsconnect::deployApp(
  appDir = here::here("21_shiny"), 
  appName = "21_myapp"
)

# Mostrar logs
rsconnect::showLogs(appName = "21_myapp")

