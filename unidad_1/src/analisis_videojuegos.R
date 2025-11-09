# Título: Análisis Estadístico de Ventas de Videojuegos
# Autor: David Quintela
# Fecha: 2 de Octubre de 2025
# Descripción: Este script carga datos de ventas de videojuegos, los limpia,
#              y realiza un análisis estadístico y visual para una clase de estadística.

# --------------------------------------------------------------------------
# PASO 1: INSTALACIÓN Y CARGA DE PAQUETES
# --------------------------------------------------------------------------
# Usaremos 'tidyverse' que incluye dplyr para la manipulación de datos y
# ggplot2 para las visualizaciones.
# Si no los tienes instalados, descomenta y ejecuta la siguiente línea:
#install.packages("tidyverse")
#install.packages("knitr")
library(tidyverse)
library(knitr) # Para crear tablas con formato

# --------------------------------------------------------------------------
# PASO 2: CARGA Y EXPLORACIÓN INICIAL DE DATOS
# --------------------------------------------------------------------------
# Cargar el archivo CSV en un dataframe de R.
# Asegúrate de que el archivo 'vgsales.csv' esté en tu directorio de trabajo.
sales_data <- read.csv(here::here("data", "vgsales.csv"))

# Ver las primeras filas del conjunto de datos para entender su estructura.
cat("### Primeras filas del conjunto de datos ###\n")
print(head(sales_data))

# Obtener un resumen estadístico de las columnas numéricas.
cat("\n### Resumen estadístico del conjunto de datos ###\n")
print(summary(sales_data))

# Revisar la estructura de los datos y los tipos de cada columna.
cat("\n### Estructura del conjunto de datos ###\n")
str(sales_data)

# --------------------------------------------------------------------------
# PASO 3: LIMPIEZA DE DATOS
# --------------------------------------------------------------------------
# La columna 'Year' tiene algunos valores "N/A" y debe ser numérica.
# Convertiremos los años a un formato numérico y eliminaremos las filas
# con años no válidos o muy antiguos para nuestro análisis.
sales_data_clean <- sales_data %>%
  filter(Year != "N/A") %>%
  mutate(Year = as.numeric(as.character(Year))) %>%
  filter(!is.na(Year), Year >= 1990) # Filtramos para juegos lanzados desde 1990

cat(sprintf("\nSe eliminaron %d filas con datos de año no válidos.\n", nrow(sales_data) - nrow(sales_data_clean)))
cat(sprintf("El conjunto de datos ahora contiene %d registros.\n", nrow(sales_data_clean)))


# --------------------------------------------------------------------------
# PASO 4: ANÁLISIS DESCRIPTIVO Y VISUALIZACIONES
# --------------------------------------------------------------------------

# --- 4.1 Análisis de Género ---
# Calcular las ventas globales totales por género.
genre_sales <- sales_data_clean %>%
  group_by(Genre) %>%
  summarise(Total_Global_Sales = sum(Global_Sales)) %>%
  arrange(desc(Total_Global_Sales))

cat("\n### Ventas Globales Totales por Género ###\n")
print(kable(genre_sales))

# Gráfico: Top 10 Géneros por Ventas Globales
ggplot(head(genre_sales, 10), aes(x = reorder(Genre, Total_Global_Sales), y = Total_Global_Sales)) +
  geom_bar(stat = "identity", fill = "steelblue") +
  coord_flip() + # Voltear los ejes para mejor legibilidad
  labs(title = "Top 10 Géneros por Ventas Globales",
       x = "Género",
       y = "Ventas Globales (en millones)") +
  theme_minimal()

# --- 4.2 Análisis de Editores (Publishers) ---
# Calcular las ventas globales totales por editor.
publisher_sales <- sales_data_clean %>%
  group_by(Publisher) %>%
  summarise(Total_Global_Sales = sum(Global_Sales)) %>%
  filter(Publisher != "Unknown") %>% # Excluir editores desconocidos
  arrange(desc(Total_Global_Sales))

cat("\n### Top 10 Editores por Ventas Globales ###\n")
print(kable(head(publisher_sales, 10)))

# Gráfico: Top 10 Editores por Ventas Globales
ggplot(head(publisher_sales, 10), aes(x = reorder(Publisher, Total_Global_Sales), y = Total_Global_Sales)) +
  geom_bar(stat = "identity", fill = "darkgreen") +
  coord_flip() +
  labs(title = "Top 10 Editores por Ventas Globales",
       x = "Editor",
       y = "Ventas Globales (en millones)") +
  theme_minimal()


# --- 4.3 Análisis Temporal ---
# Número de juegos lanzados por año.
games_per_year <- sales_data_clean %>%
  group_by(Year) %>%
  summarise(Count = n())

# Gráfico: Lanzamientos de Juegos por Año
ggplot(games_per_year, aes(x = Year, y = Count)) +
  geom_line(color = "red", size = 1) +
  geom_point(color = "red") +
  labs(title = "Número de Juegos Lanzados por Año",
       x = "Año",
       y = "Cantidad de Juegos") +
  theme_minimal()


# --------------------------------------------------------------------------
# PASO 5: ANÁLISIS COMPARATIVO
# --------------------------------------------------------------------------

# --- 5.1 Comparación de Ventas por Región ---
# Calcular el total de ventas para cada región principal.
regional_sales <- sales_data_clean %>%
  summarise(
    NA_Sales = sum(NA_Sales),
    EU_Sales = sum(EU_Sales),
    JP_Sales = sum(JP_Sales),
    Other_Sales = sum(Other_Sales)
  ) %>%
  gather(key = "Region", value = "Total_Sales") # Transformar datos a formato largo

cat("\n### Ventas Totales por Región ###\n")
print(kable(regional_sales))

# Gráfico: Comparación de Ventas Totales por Región
ggplot(regional_sales, aes(x = reorder(Region, -Total_Sales), y = Total_Sales)) +
  geom_bar(stat = "identity", aes(fill = Region)) +
  labs(title = "Ventas Totales por Región",
       x = "Región",
       y = "Ventas Totales (en millones)") +
  theme_minimal()

# --- 5.2 Comparación de la popularidad de Géneros por Región ---
# Seleccionamos los 5 géneros más populares a nivel global para comparar.
top_genres <- head(genre_sales$Genre, 5)

genre_regional_sales <- sales_data_clean %>%
  filter(Genre %in% top_genres) %>%
  group_by(Genre) %>%
  summarise(
    NA_Sales = sum(NA_Sales),
    EU_Sales = sum(EU_Sales),
    JP_Sales = sum(JP_Sales)
  ) %>%
  gather(key = "Region", value = "Sales", -Genre)

# Gráfico: Comparación de Géneros Populares por Región
ggplot(genre_regional_sales, aes(x = Genre, y = Sales, fill = Region)) +
  geom_bar(stat = "identity", position = "dodge") +
  labs(title = "Comparación de Ventas de Géneros Populares por Región",
       x = "Género",
       y = "Ventas (en millones)") +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))

# --------------------------------------------------------------------------
# PASO 6: ANÁLISIS ESTADÍSTICO (PRUEBA DE HIPÓTESIS)
# --------------------------------------------------------------------------
# Pregunta: ¿Existe una diferencia estadísticamente significativa en las ventas
# globales entre los géneros 'Action', 'Sports' y 'Shooter'?

# Usaremos un ANOVA (Análisis de Varianza) para comparar las medias de ventas
# globales de estos tres grupos.

# Hipótesis Nula (H0): Las medias de ventas globales son iguales para los tres géneros.
# Hipótesis Alternativa (H1): Al menos una de las medias es diferente.

# Filtrar los datos para los géneros de interés.
anova_data <- sales_data_clean %>%
  filter(Genre %in% c("Action", "Sports", "Shooter"))

# Realizar la prueba ANOVA.
anova_result <- aov(Global_Sales ~ Genre, data = anova_data)

cat("\n### Resultados de la Prueba ANOVA para Ventas Globales por Género ###\n")
print(summary(anova_result))

# Interpretación: Si el 'p-value' (Pr(>F)) es menor que 0.05, rechazamos la
# hipótesis nula y concluimos que hay una diferencia significativa en las ventas
# medias entre al menos dos de estos géneros.

# Gráfico Boxplot para visualizar la distribución de ventas
ggplot(anova_data, aes(x = Genre, y = Global_Sales, fill = Genre)) +
  geom_boxplot() +
  scale_y_log10() + # Usamos escala logarítmica para manejar valores atípicos
  labs(title = "Distribución de Ventas Globales para Géneros Seleccionados",
       x = "Género",
       y = "Ventas Globales (escala logarítmica)") +
  theme_minimal()

cat("\n--- Fin del Análisis ---\n")
 
