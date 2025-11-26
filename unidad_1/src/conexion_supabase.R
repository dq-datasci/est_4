# --- SCRIPT DE CONEXIÓN PARA LA CLASE DE ESTADÍSTICA ---
# Instalar librerías automáticamente si no las tienen
if (!require("DBI")) install.packages("DBI")
if (!require("RPostgres")) install.packages("RPostgres")
if (!require("tidyverse")) install.packages("tidyverse")

library(DBI)
library(RPostgres)
library(tidyverse)

# 1. Conexión a la Nube (Solo Lectura)
# Nota: Esta conexión es segura porque el usuario 'estudiante_stats' solo puede leer.
con <- dbConnect(
  RPostgres::Postgres(),

  host = "aws-1-sa-east-1.pooler.supabase.com", 
  dbname = "postgres",
  user = "estudiante_stats.nmxjlpiayanuncdlyhdt",
  password = "estadistica2025",
  port = 5432
)

# 2. Descargar los datos limpios a R
df_encuesta <- dbReadTable(con, "encuesta_estudiantes")

# 3. Ver que todo funcionó
print(paste("✅ ¡Conexión exitosa! Se descargaron", nrow(df_encuesta), "encuestas."))
glimpse(df_encuesta)

# (Opcional) Desconectar al terminar, aunque R lo hace solo al cerrar.
dbDisconnect(con)