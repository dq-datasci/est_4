# Entregables de la Unidad 1
* **Alumno:** dq-datasci

---

## 👨‍🏫 Notas para el Profesor

¡Bienvenido! En esta carpeta encontrará los reportes de la unidad.

He reestructurado el proyecto para seguir un formato profesional:
* `/data/`: Contiene los datos crudos.
* `/notebooks/`: Contiene los reportes y exploraciones (`.Rmd`, `.md`, `.html`).
* `/src/`: Contiene el script de análisis final (`.R`).

Para facilitar la corrección, los archivos de reporte (`.Rmd`) generan dos versiones:

* **`.md` (Vista Rápida):** Puedes hacer clic en los archivos `.md` en la carpeta `/notebooks/` para ver una vista previa simple en GitHub. Es ideal para checar el texto y los gráficos estáticos.
* **`.html` (Reporte Completo):** Esta es la versión final. Contiene los estilos, tablas dinámicas y gráficos interactivos (`plotly`, `DT`, etc.) que se pierden en el `.md`.

---

## 🖥️ Cómo Ver los Reportes

GitHub no muestra los `.html` directamente (solo enseña el código). Para ver los reportes interactivos, por favor **use la Opción A**. Para ejecutar el código usted mismo, **use la Opción B**.

### Opción A: Enlaces Directos (Recomendado para Vista Rápida)

Simplemente haga clic en estos enlaces para ver el reporte `.html` completo en su navegador (usando `htmlpreview.github.io`).

* **Reporte 1:** **[Ver `01_intento_duplicados.html`] (https://htmlpreview.github.io/?https://github.com/dq-datasci/est_4/blob/main/unidad_1/notebooks/01_intento_duplicados.html)**
* **Reporte 2:** **[Ver `02_intento_duplicados_v2.html`] (https://htmlpreview.github.io/?https://github.com/dq-datasci/est_4/blob/main/unidad_1/notebooks/02_intento_duplicados_v2.html)**
* **Reporte 3:** **[Ver `03_exploracion_base.html`] (https://htmlpreview.github.io/?https://github.com/dq-datasci/est_4/blob/main/unidad_1/notebooks/03_exploracion_base.html)**

*(Nota: Estos enlaces asumen que el repositorio se llama `est_4` y la rama es `main`).*

### Opción B: Abrir en Codespaces (Recomendado para Ejecutar)

Este método le permite ejecutar todo el análisis usted mismo en un entorno de R idéntico al mío.

1.  Haz clic en el botón verde **`<> Code`** en la página principal del repositorio.
2.  Ve a la pestaña **`Codespaces`** y haz clic en **`Create codespace on main`**.
3.  Espera a que el contenedor se construya (instalará R y `renv` automáticamente).
4.  Una vez cargado, abre la Paleta de Comandos: `Ctrl + Shift + P`.
5.  Escribe `Run Task` (o `Ejecutar Tarea`) y presiona Enter.
6.  Selecciona **"Restaurar Entorno: Unidad 1"** en el menú.
7.  Espera a que la terminal termine de instalar todos los paquetes de `renv`.

¡Listo! El entorno está preparado. Ahora puedes abrir los archivos en `notebooks/` o `src/` y ejecutarlos.

### Opción C: Método Manual (Solo vista previa)

Si los enlaces de la Opción A no funcionan:

1.  Navega a la carpeta `/notebooks/` y haz clic en el archivo `.html` que deseas ver (ej. `03_exploracion_base.html`).
2.  Copia la URL de tu navegador (la dirección en la barra superior).
3.  Abre una nueva pestaña y vaya a: **[https://htmlpreview.github.io/](https://htmlpreview.github.io/)**
4.  Pegue la URL que copió en el cuadro de texto y haga clic en "Preview".
