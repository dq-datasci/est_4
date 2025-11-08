# Unidad 2: Aplicaciones Shiny

Este directorio contiene el trabajo para la Unidad 2 de Estadística 4,
incluyendo dos aplicaciones Shiny: `21_shiny` y `22_shiny`.

## 🚀 Entorno Reproducible (Codespaces)

Este proyecto está configurado para usarse con `renv` y Dev Containers (Codespaces).

* **Versión de R:** `4.4.1`
* **Paquetes:** Ver `renv.lock`

El entorno de Codespaces se carga con R, pero debes **inicializar la unidad** en la que quieres trabajar.

1.  Abre la Paleta de Comandos: `Ctrl + Shift + P`
2.  Escribe `Run Task` (o `Ejecutar Tarea`) y presiona Enter.
3.  Selecciona **"Restaurar Entorno: Unidad 2"** en el menú.
4.  Espera a que la terminal termine de instalar todos los paquetes de `renv`.

---

## 👨‍🏫 Cómo Desplegar (Para el Profesor)

Una vez que el entorno de la Unidad 2 esté restaurado, puedes desplegar las aplicaciones en tu propia cuenta de `shinyapps.io`.

**Nota:** Todos los comandos se ejecutan desde la terminal en la raíz del proyecto.

1.  **Copiar el archivo de entorno:**
    ```bash
    cp unidad_2/.env.example unidad_2/.env
    ```

2.  **Editar credenciales:**
    En el explorador de archivos, ve a `unidad_2/` y abre el nuevo archivo `.env`. Reemplaza los valores de `SHINYAPPS_NAME`, `SHINYAPPS_TOKEN`, y `SHINYAPPS_SECRET` con tus propias credenciales.

3.  **Ejecutar el script:**
    En la terminal, ejecuta el script de R para desplegar la app que desees:

    ```bash
    # Para desplegar la app 21
    R -e "source('unidad_2/21_deploy.R')"
    ```
    
    ```bash
    # Para desplegar la app 22
    R -e "source('unidad_2/22_deploy.R')"
    ```
