# Función para generar la población (usa la primera semilla)
generar_poblacion <- function(seed_poblacion, n, p) {
  set.seed(seed_poblacion)
  rbinom(n, 1, p)
}

# x <- generar_poblacion(123, 1000, 0.3)

# Función para tomar la muestra (usa la segunda semilla para el sampling)
tomar_muestra <- function(poblacion, n_muestra, seed_muestra) {
  # Establecer la semilla de la muestra para asegurar que el proceso de 'sample' sea reproducible
  set.seed(seed_muestra)
  sample(poblacion, n_muestra, replace = FALSE)
}

# tomar_muestra(c(1, 0, 0, 1, 0, 1, 0), 2)
# y <- tomar_muestra(x, 100)

# Función para calcular la proporción muestral
calcular_proporcion <- function(muestra) {
  sum(muestra) / length(muestra)
}

# calcular_proporcion(y)