# -------------------------------------------------------------------
# GUÍA DE ESTUDIO: MÉTODOS Y PROGRAMAS ESTADÍSTICOS IV
# Basado en los PDF de la materia (U01-011, U01-021, U02-021)
# Generado por Gemini
# -------------------------------------------------------------------

# ===================================================================
# Tema 1: Distribuciones Muestrales (PDF: EST4-U01-011)
# ===================================================================
# Este tema es la base de la inferencia. Describe cómo se comportan 
# las estadísticas (como la media muestral x_bar o la proporción 
# muestral p_gorro) si tomáramos muchas muestras de una población.

# ---
## 1.1 Teorema Central del Límite (TCL)
# ---
# Cuándo se usa: El TCL es fundamental. Nos permite usar la 
# distribución normal para calcular probabilidades sobre la 
# MEDIA MUESTRAL (x_bar), incluso si la población original 
# *no* es normal, siempre y cuando la muestra sea lo 
# suficientemente grande.
#
# * Regla general: Se considera "grande" si n >= 30.
# * Si la población *ya es* normal, la distribución muestral de 
#   x_bar es normal para cualquier tamaño de muestra n.

# ---
## 1.2 Distribución Muestral de la Media Muestral (x_bar)
# ---
# Cuándo se usa: Cuando conoces los parámetros de la población 
# (mu y sigma) y quieres saber la PROBABILIDAD DE OBTENER un 
# cierto valor de MEDIA MUESTRAL (x_bar) en una muestra de tamaño n.
#
# Fórmulas Clave:
# 1. Media de la distribución muestral: E(x_bar) = mu
# 2. Error Estándar (SE) de x_bar: SE(x_bar) = sigma / sqrt(n)
# 3. Puntaje Z para x_bar: z = (x_bar - mu) / (sigma / sqrt(n))

# ---
# [cite_start]Ejemplo en R (Basado en el caso de Alzheimer [cite: 357-363]):
# Contexto: Duración de Alzheimer: mu = 8 años, sigma = 4 años. 
# Se toma una muestra de n = 30 pacientes.
# Pregunta 1: ¿Probabilidad de que la duración promedio x_bar sea 
# menor a 7 años? P(x_bar < 7).
# ---

# 1. Definir parámetros
mu <- 8
sigma <- 4
n <- 30
x_bar <- 7 # El valor que queremos evaluar

# 2. Calcular el Error Estándar (SE)
SE_x_bar <- sigma / sqrt(n)
print(paste("Error Estándar (SE):", round(SE_x_bar, 2))) # 0.73 en el PDF

# 3. Calcular el puntaje Z
z_score <- (x_bar - mu) / SE_x_bar
print(paste("Puntaje Z:", round(z_score, 2))) # Coincide con el -1.37 del PDF

# 4. Calcular la probabilidad P(x_bar < 7) que es P(Z < -1.37)
# Usamos pnorm() para la probabilidad acumulada
prob_menor_7 <- pnorm(z_score)
print(paste("P(x_bar < 7):", round(prob_menor_7, 4))) # Coincide con el 0.0853 del PDF

# Pregunta 3: Probabilidad de que x_bar esté a no más de 1 año 
# de la media (entre 7 y 9)
# P(7 < x_bar < 9)
z_score_sup <- (9 - mu) / SE_x_bar # z para 9
z_score_inf <- (7 - mu) / SE_x_bar # z para 7

# P(-1.37 < Z < 1.37)
prob_entre_7_y_9 <- pnorm(z_score_sup) - pnorm(z_score_inf)
print(paste("P(7 < x_bar < 9):", round(prob_entre_7_y_9, 4))) # Coincide con el 0.8294 del PDF


# ---
## 1.3 Distribución Muestral de la Proporción Muestral (p_gorro)
# ---
# Cuándo se usa: Cuando trabajas con datos categóricos (ej. sí/no, 
# acuerdo/desacuerdo) y quieres saber la PROBABILIDAD DE OBTENER 
# una cierta PROPORCIÓN MUESTRAL (p_gorro) en una muestra de tamaño n, 
# dado que conoces la proporción poblacional p.
#
# * Condición para normalidad: La aproximación normal se considera 
#   adecuada si np > 5 y nq > 5.
#
# Fórmulas Clave:
# 1. Estimador: p_gorro = x / n (x = número de éxitos)
# 2. Media de la distribución muestral: E(p_gorro) = p
# 3. Error Estándar (SE) de p_gorro: SE(p_gorro) = sqrt(pq / n)
# 4. Puntaje Z para p_gorro: z = (p_gorro - p) / sqrt(pq / n)

# ---
# [cite_start]Ejemplo en R (Basado en la encuesta a padres [cite: 492-493]):
# Contexto: Se *supone* que la verdadera proporción de padres que 
# están de acuerdo es p = 0.55. Se toma una muestra de n = 500.
# Pregunta: ¿Cuál es la probabilidad de observar una proporción 
# muestral p_gorro de 0.60 o más? P(p_gorro >= 0.60).
# ---

# 1. Definir parámetros
p_poblacion <- 0.55
n_prop <- 500 # Renombrado de 'n' para evitar conflictos
p_gorro <- 0.60 # El valor que queremos evaluar

# 2. Verificar condición (opcional pero buena práctica)
n_prop * p_poblacion > 5
n_prop * (1 - p_poblacion) > 5

# 3. Calcular el Error Estándar (SE)
q_poblacion <- 1 - p_poblacion
SE_p_gorro <- sqrt((p_poblacion * q_poblacion) / n_prop)
print(paste("Error Estándar (SE):", round(SE_p_gorro, 4))) # Coincide con 0.0222

# 4. Calcular el puntaje Z
z_score_p <- (p_gorro - p_poblacion) / SE_p_gorro
print(paste("Puntaje Z:", round(z_score_p, 2))) # Coincide con 2.25

# 5. Calcular la probabilidad P(p_gorro >= 0.60) que es P(Z >= 2.25)
# Usamos lower.tail = FALSE para la cola derecha
prob_mayor_60 <- pnorm(z_score_p, lower.tail = FALSE)
print(paste("P(p_gorro >= 0.60):", round(prob_mayor_60, 4))) # Coincide con 0.0122


# ===================================================================
# Tema 2: Estimación (PDF: EST4-U01-021)
# ===================================================================
# Aquí es donde usamos los datos de la muestra para *estimar* los 
# parámetros desconocidos de la población (como mu o p).

# ---
## 2.1 Estimación Puntual y Margen de Error
# ---
# Cuándo se usa: Cuando quieres dar una *única estimación* del 
# parámetro poblacional y acompañarla de su MARGEN DE ERROR (ME), 
# que usualmente se calcula para un 95% de confianza.
#
# Fórmulas Clave (para ME 95%):
# 1. ME para Media (mu) (n >= 30): 
#    ME = 1.96 * SE(x_bar) = 1.96 * (s / sqrt(n))
#    (Usamos s, la desv. est. de la *muestra*, para aproximar sigma).
# 2. ME para Proporción (p): 
#    ME = 1.96 * SE(p_gorro) = 1.96 * sqrt(p_gorro * q_gorro / n)

# ---
# [cite_start]Ejemplo en R (ME para la Media - Osos Polares [cite: 563-567]):
# Contexto: Muestra n = 50 osos. Media muestral x_bar = 980 libras. 
# Desviación estándar muestral s = 105 libras.
# Pregunta: Estimar mu y calcular el margen de error del 95%.
# ---

# 1. Datos de la muestra
n_osos <- 50
x_bar_osos <- 980
s_osos <- 105

# 2. Calcular SE (usando s)
SE_osos <- s_osos / sqrt(n_osos)

# 3. Calcular Margen de Error (ME) del 95%
ME_osos <- 1.96 * SE_osos

print(paste("Estimación puntual de la media (x_bar):", x_bar_osos))
print(paste("Margen de Error (95%):", round(ME_osos, 2))) # Coincide con 29.10 (aprox 29)

# ---
# [cite_start]Ejemplo en R (ME para Proporción - Calentamiento Global [cite: 577-580]):
# Contexto: Muestra n = 100 adultos. Proporción muestral p_gorro = 0.73 
# (73%) piensa que es un problema serio.
# Pregunta: Estimar p y encontrar el margen de error.
# ---

# 1. Datos de la muestra
n_adultos <- 100
p_gorro_calent <- 0.73
q_gorro_calent <- 1 - p_gorro_calent

# 2. Calcular SE (usando p_gorro)
SE_calent <- sqrt((p_gorro_calent * q_gorro_calent) / n_adultos)

# 3. Calcular Margen de Error (ME) del 95%
ME_calent <- 1.96 * SE_calent

print(paste("Estimación puntual de la proporción (p_gorro):", p_gorro_calent))
print(paste("Margen de Error (95%):", round(ME_calent, 2))) # Coincide con 0.09


# ---
## 2.2 Estimación por Intervalo (Intervalos de Confianza - IC)
# ---
# Cuándo se usa: Es la forma más completa de estimación. En lugar 
# de un solo número, damos un RANGO DE VALORES (un intervalo) 
# dentro del cual tenemos cierta confianza (ej. 90%, 95%, 99%) 
# de que se encuentra el verdadero parámetro poblacional.
#
# Fórmula General (para Muestras Grandes):
# (Estimador Puntual) +/- (Valor Crítico z_alfa/2) * (Error Estándar)
#
# Valor Crítico (z_alfa/2): Depende del nivel de confianza. 
# Se encuentra en R con qnorm().
# 90% confianza: alfa = 0.10, alfa/2 = 0.05. z_.05 = qnorm(1 - 0.05) = 1.645
# 95% confianza: alfa = 0.05, alfa/2 = 0.025. z_.025 = qnorm(1 - 0.025) = 1.96
# 99% confianza: alfa = 0.01, alfa/2 = 0.005. z_.005 = qnorm(1 - 0.005) = 2.58

# ---
### 2.2.1 IC de Muestra Grande para la Media (mu)
# ---
# Fórmula: x_bar +/- z_alfa/2 * (s / sqrt(n))  (para n >= 30)

# ---
# [cite_start]Ejemplo en R (IC para la Media - Lácteos [cite: 708-710]):
# Contexto: n = 50 hombres. x_bar = 756 gramos/día. s = 35 gramos/día.
# Pregunta: Construir un IC del 95% para mu.
# ---

# 1. Datos
n_lacteos <- 50
x_bar_lacteos <- 756
s_lacteos <- 35
confianza <- 0.95

# 2. Calcular z_critico
alfa <- 1 - confianza
z_critico <- qnorm(1 - alfa / 2) # 1.96

# 3. Calcular SE
SE_lacteos <- s_lacteos / sqrt(n_lacteos)

# 4. Calcular el Margen de Error
ME_ic_lacteos <- z_critico * SE_lacteos
print(paste("Margen de Error (ME):", round(ME_ic_lacteos, 2))) # Coincide con 9.70

# 5. Calcular Intervalo
LCI_media <- x_bar_lacteos - ME_ic_lacteos
UCI_media <- x_bar_lacteos + ME_ic_lacteos

print(paste("IC del 95% para la media:", round(LCI_media, 2), "a", round(UCI_media, 2)))
# Coincide con 746.30 a 765.70

# ---
### 2.2.2 IC de Muestra Grande para la Proporción (p)
# ---
# Fórmula: p_gorro +/- z_alfa/2 * sqrt(p_gorro * q_gorro / n)

# ---
# [cite_start]Ejemplo en R (IC para Proporción - Candidata Republicana [cite: 741-744]):
# Contexto: n = 985 electores. x = 592 planean votar por ella.
# Pregunta: Construir un IC del 90% para p. 
# ¿Se puede concluir que ganará (> 0.50)?
# ---

# 1. Datos
n_electores <- 985
x_exitos <- 592
confianza_elect <- 0.90

# 2. Calcular p_gorro (estimador puntual)
p_gorro_elect <- x_exitos / n_electores
q_gorro_elect <- 1 - p_gorro_elect
print(paste("Estimación puntual (p_gorro):", round(p_gorro_elect, 3))) # 0.601

# 3. Calcular z_critico
alfa_elect <- 1 - confianza_elect
z_critico_elect <- qnorm(1 - alfa_elect / 2) # 1.645

# 4. Calcular SE
SE_elect <- sqrt((p_gorro_elect * q_gorro_elect) / n_electores)
print(paste("Error Estándar (SE):", round(SE_elect, 3))) # 0.016

# 5. Calcular Margen de Error
ME_ic_elect <- z_critico_elect * SE_elect
print(paste("Margen de Error (ME):", round(ME_ic_elect, 3))) # 0.026

# 6. Calcular Intervalo
LCI_prop <- p_gorro_elect - ME_ic_elect
UCI_prop <- p_gorro_elect + ME_ic_elect

print(paste("IC del 90% para la proporción:", round(LCI_prop, 3), "a", round(UCI_prop, 3)))
# Coincide con .575 a .627

# 7. Conclusión
# Como el límite inferior (0.575) es mayor que 0.50, se puede concluir
# con 90% de confianza que la candidata ganará.


# ---
## 2.3 Selección del Tamaño de Muestra (n)
# ---
# Cuándo se usa: ANTES de recolectar datos. Se usa para determinar 
# cuántas observaciones (n) necesitas para lograr un LÍMITE DE ERROR (B) 
# [cite_start]específico con un nivel de confianza dado [cite: 768-772].

# ---
### 2.3.1 Tamaño de Muestra para Estimar la Media (mu)
# ---
# Fórmula: n >= ( (z_alfa/2 * sigma) / B )^2
#
# * Problema: Necesitas una estimación de sigma (la desviación 
#   estándar poblacional) *antes* de muestrear.
# * Soluciones: Usar s de un estudio previo o estimar sigma ~ Rango / 4.

# ---
# [cite_start]Ejemplo en R (Producción Química [cite: 777-781]):
# Contexto: Se desea estimar la producción media mu con un 
# Límite de Error (B) de 4 toneladas. Se usará una confianza 
# del 95% (z_alfa/2 = 1.96). Un estudio previo sugiere s = 21 toneladas.
# Pregunta: ¿Qué tamaño de muestra n se necesita?
# ---

# 1. Datos
B_media <- 4 # Límite en el error de estimación
confianza_prod <- 0.95
sigma_estimada <- 21 # Basado en s de estudio previo

# 2. Calcular z_critico
alfa_prod <- 1 - confianza_prod
z_critico_prod <- qnorm(1 - alfa_prod / 2) # 1.96

# 3. Calcular n
n_media <- ( (z_critico_prod * sigma_estimada) / B_media )^2
print(paste("n calculado:", n_media)) # 105.88

# Siempre se redondea hacia ARRIBA
n_media_final <- ceiling(n_media)
print(paste("Tamaño de muestra requerido (n):", n_media_final)) # 106

# ---
### 2.3.2 Tamaño de Muestra para Estimar la Proporción (p)
# ---
# Fórmula: n >= (z_alfa/2 / B)^2 * p * q
#
# * Problema: Necesitas p y q, ¡pero eso es lo que quieres estimar!
# * Soluciones:
#   1. Usar una estimación de un estudio previo.
#   2. Caso más conservador (seguro): Usar p = 0.5 y q = 0.5. 
#      Esto da el n más grande posible.

# ---
# [cite_start]Ejemplo en R (Tubos de PVC [cite: 807-809]):
# Contexto: Se desea estimar la proporción p que planea aumentar compras.
# Requisitos: Límite de Error B = 0.04. Confianza del 90% ((1-alfa)=0.90).
# Pregunta: ¿Qué tamaño muestral n se requiere? 
# (No hay info previa, se usa p=0.5).
# ---

# 1. Datos
B_prop <- 0.04 # Límite en el error
confianza_pvc <- 0.90

# 2. Usar p = 0.5 (caso más conservador)
p_estimado <- 0.5
q_estimado <- 1 - p_estimado

# 3. Calcular z_critico
alfa_pvc <- 1 - confianza_pvc
z_critico_pvc <- qnorm(1 - alfa_pvc / 2) # 1.645

# 4. Calcular n
# n >= (z^2 * p * q) / B^2
n_prop_calc <- ( (z_critico_pvc^2) * (p_estimado * q_estimado) ) / (B_prop^2)
print(paste("n calculado:", n_prop_calc)) # 422.7

# Siempre se redondea hacia ARRIBA
n_prop_final <- ceiling(n_prop_calc)
print(paste("Tamaño de muestra requerido (n):", n_prop_final)) # 423


# ===================================================================
# Tema 3: Muestreo Estratificado (PDF: EST4-U02-021)
# ===================================================================
# Cuándo se usa: Se usa cuando la población se puede dividir en 
# subgrupos (estratos) que son HOMOGÉNEOS POR DENTRO pero 
# DIFERENTES ENTRE SÍ. En lugar de un solo SRS, tomas un 
# SRS de *cada* estrato. Esto aumenta la precisión.
#
# La pregunta principal es: si necesitas una muestra total de n, 
# ¿cuántos elementos sacas de cada estrato (n_1, n_2, ... n_k)?

# ---
## 3.1 Afijación (Asignación) Proporcional
# ---
# Cuándo se usa: Es el método más común. Asigna el tamaño de 
# muestra n_i a cada estrato de forma que sea PROPORCIONAL 
# AL TAMAÑO del estrato (N_i) en la población.
#
# Fórmula: n_i = n * (N_i / N)
# * n = tamaño total de la muestra deseada
# * N_i = tamaño del estrato i en la población
# * N = tamaño total de la población (N = sum(N_i))

# ---
# [cite_start]Ejemplo en R (Pastillas para dormir [cite: 36-44]):
# Contexto: Población (mayores de 40) N = 50,000. 
# Muestra deseada n = 750.
# Estratos (por edad):
# * Estrato 1 (40-55 años): N_1 = 25,000
# * Estrato 2 (56-70 años): N_2 = 18,000
# * Estrato 3 (> 70 años): N_3 = 7,000
# Pregunta: ¿Cuántas personas muestrear de cada estrato (n_1, n_2, n_3)?
# ---

# 1. Datos
n_total_est <- 750
N_total_est <- 50000

# Tamaños de los estratos en la población (vector con nombres)
N_estratos <- c(N1_40_55 = 25000, N2_56_70 = 18000, N3_mas_70 = 7000)

# 2. Calcular la proporción de cada estrato
proporciones_estratos <- N_estratos / N_total_est
print("Proporciones de cada estrato:")
print(proporciones_estratos)

# 3. Calcular n_i para cada estrato
n_i_proporcional <- n_total_est * proporciones_estratos
print("Tamaño de muestra por estrato (n_i):")
print(n_i_proporcional)

# Verificación
# n1 = 750 * (25000 / 50000) = 375
# n2 = 750 * (18000 / 50000) = 270
# n3 = 750 * (7000 / 50000) = 105
# sum(n_i_proporcional) == n_total_est # TRUE


# ---
## 3.2 Afijación Óptima (de Neyman)
# ---
# Cuándo se usa: Cuando quieres la MAYOR PRECISIÓN POSIBLE 
# (menor varianza) para un n total fijo. Este método asigna 
# *más* muestras a los estratos que son más grandes (N_h) y 
# que tienen MAYOR VARIABILIDAD INTERNA (mayor desviación estándar, S_h).
#
# Fórmula: n_h = n * ( (N_h * S_h) / sum(N_h * S_h) )

# ---
# Ejemplo en R (Hipotético, basado en la fórmula):
# Contexto: n = 1000. Queremos muestrear estudiantes de 3 
# carreras (Estratos).
# Datos:
# * Carrera A: N_A = 5000, S_A = 10 (poca variabilidad en notas)
# * Carrera B: N_B = 3000, S_B = 20 (alta variabilidad en notas)
# * Carrera C: N_C = 2000, S_C = 15 (variabilidad media)
# ---

# 1. Datos
n_total_opt <- 1000
N_h <- c(A = 5000, B = 3000, C = 2000)
S_h <- c(A = 10, B = 20, C = 15)

# 2. Calcular el numerador para cada estrato (Nh * Sh)
Nh_x_Sh <- N_h * S_h
print("Numerador (Nh * Sh) para cada estrato:")
print(Nh_x_Sh)
# A: 5000 * 10 = 50000
# B: 3000 * 20 = 60000
# C: 2000 * 15 = 30000

# 3. Calcular el denominador (la suma total)
denominador_optimo <- sum(Nh_x_Sh)
print(paste("Denominador (Suma de Nh * Sh):", denominador_optimo)) # 140000

# 4. Calcular n_h para cada estrato
n_h_optimo <- n_total_opt * (Nh_x_Sh / denominador_optimo)

print("Tamaño de muestra óptimo por estrato (n_h):")
print(round(n_h_optimo, 0)) # Redondeamos al entero más cercano

# Nota: La Carrera B, aunque no es la más grande, recibe una gran
# parte de la muestra (43%) debido a su alta variabilidad.


# ---
## 3.3 Afijación Óptima con Costos Variables
# ---
# Cuándo se usa: Es la más avanzada. Se usa cuando el COSTO DE 
# MUESTREAR (C_h) es DIFERENTE en cada estrato (ej. estrato "rural" 
# es más caro de muestrear que "urbano").
#
# Busca optimizar la relación costo-beneficio. Asigna más muestra 
# a estratos grandes (N_h), con alta variabilidad (S_h) y BAJO COSTO (C_h).
#
# Fórmula: n_h = n * ( (N_h * S_h / sqrt(C_h)) / sum(N_h * S_h / sqrt(C_h)) )

# ---
# Ejemplo en R (Hipotético, basado en la fórmula):
# Contexto: Mismos datos que el ejemplo anterior (n=1000), 
# pero ahora hay costos.
# Datos de Costo:
# * Carrera A (urbana): C_A = 4 (barato)
# * Carrera B (rural): C_B = 25 (caro)
# * Carrera C (suburbana): C_C = 9 (medio)
# ---

# 1. Datos
n_total_costo <- 1000
N_h_costo <- c(A = 5000, B = 3000, C = 2000)
S_h_costo <- c(A = 10, B = 20, C = 15)
C_h_costo <- c(A = 4, B = 25, C = 9)

# 2. Calcular el numerador para cada estrato (Nh * Sh / sqrt(Ch))
numerador_costo <- (N_h_costo * S_h_costo) / sqrt(C_h_costo)
print("Numerador (Nh * Sh / sqrt(Ch)) para cada estrato:")
print(numerador_costo)
# A: 50000 / sqrt(4) = 25000
# B: 60000 / sqrt(25) = 12000
# C: 30000 / sqrt(9) = 10000

# 3. Calcular el denominador (la suma total)
denominador_costo <- sum(numerador_costo)
print(paste("Denominador (Suma de los numeradores):", round(denominador_costo, 0))) # 47000

# 4. Calcular n_h para cada estrato
n_h_costo <- n_total_costo * (numerador_costo / denominador_costo)

print("Tamaño de muestra óptimo con costos por estrato (n_h):")
print(round(n_h_costo, 0)) # Redondeamos al entero más cercano

# Nota: Ahora la Carrera A (barata) recibe la mayoría de la muestra (53%),
# mientras que la Carrera B (cara) recibe mucho menos (26%),
# a pesar de su alta variabilidad, debido a su alto costo.