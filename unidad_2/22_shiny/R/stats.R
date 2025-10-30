generar_poblacion <- function(seed, n, p) {
  set.seed(seed)
  rbinom(n, 1, p)
}

# x <- generar_poblacion(123, 1000, 0.3)

tomar_muestra <- function(poblacion, n_muestra) {
  sample(poblacion, n_muestra, replace = FALSE)
}

# tomar_muestra(c(1, 0, 0, 1, 0, 1, 0), 2)
# y <- tomar_muestra(x, 100)

calcular_proporcion <- function(muestra) {
  sum(muestra) / length(muestra)
}

# calcular_proporcion(y)
