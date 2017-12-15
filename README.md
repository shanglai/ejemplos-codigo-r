# Ejemplos de Código en R
Este repositorio almacenará todos los ejemplos de alguna funcionalidad en R

## Transformación de DataFrames
### Melt/Cast y Gather/Spread
- Un DataFrame es una estructura de datos "rectangular"
- En muchas ocasiones, es necesario reorganizar los datos para  poder utilizarlos
- Y la estructura se debe "alargar" o "ensanchar", es decir, un caso de transposición parcial del dataset.
- Alargar: Transformar algunas columnas en registros
- Ensanchar: Transformar registros en columnas
- Se ven ejemplos con melt/cast de Reshape2 y gather/spread de Tidyr

## Ejemplo Interactivo de Momentos Estadísticos
### Con Shiny
- Instalar Shiny, ShinyDashboard y Plotly
- install.packages(c('shiny','plotly','shinydashboard'))
- Abrir archivo app.R en sesión de R
- Run App
- Momentos:
1- Media
2- Varianza
3- Sesgo (Skewness)
4- Kurtosis

