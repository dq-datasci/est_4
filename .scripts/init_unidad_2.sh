#!/bin/bash
echo "--- Restaurando entorno de Unidad 2 ---"
R -e "setwd('unidad_2'); renv::restore()"
echo "--- ¡Entorno de Unidad 2 listo! ---"
