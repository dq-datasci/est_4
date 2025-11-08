#!/bin/bash
echo "--- Restaurando entorno de Unidad 1 ---"
R -e "setwd('unidad_1'); renv::restore()"
echo "--- ¡Entorno de Unidad 1 listo! ---"
