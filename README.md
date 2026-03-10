# Caso Harvard: Web Analytics at Quality Alloys, Inc.

Este repositorio contiene el desarrollo y la resolución del caso de Harvard **“Web Analytics at Quality Alloys, Inc.”**, realizado en el marco del curso **Analítica de los Negocios**.

Datos y archivos de réplica para el análisis del caso por:

**David Santiago Aguirre Polanco**  
**María Juanita Rojas Chacón**  
**Andrés Felipe Romero Rodríguez**

--------------------------------------------------

# **Resumen**

Quality Alloys, Inc. es una empresa dedicada a la distribución de aleaciones utilizadas en distintos procesos de manufactura industrial. Con el objetivo de ampliar su alcance comercial, la empresa desarrolló un sitio web corporativo que permite a potenciales clientes conocer sus productos y solicitar cotizaciones.

Debido a que el sitio web no permite realizar compras directamente en línea, resulta complejo determinar si el tráfico del sitio web tiene un impacto real sobre el desempeño comercial de la empresa. Por esta razón, el presente trabajo analiza diferentes métricas de analítica web junto con variables financieras con el fin de evaluar la efectividad del canal digital y de las iniciativas promocionales implementadas por la empresa.

El análisis incluye el estudio de variables como:

- Número de visitas al sitio web
- Unique Visits
- Revenue
- Profit
- Pounds Sold

A partir de estadísticas descriptivas, visualización de datos y análisis de correlaciones entre variables, se busca comprender si el tráfico web contribuye a explicar el desempeño financiero de la empresa y evaluar el impacto de las campañas promocionales en los resultados comerciales.

--------------------------------------------------

# **Estructura del repositorio**

El repositorio está organizado en las siguientes carpetas:

--------------------------------------------------

# **Carpeta Document**

Esta carpeta contiene los documentos finales relacionados con el análisis del caso.

**Archivos incluidos:**

- **Caso Harvard Web Analytics.pdf**

Documento principal donde se presenta el desarrollo completo del análisis del caso. Este documento incluye la exploración de los datos, el análisis estadístico realizado, la interpretación de los resultados y las conclusiones obtenidas a partir del estudio de las métricas de analítica web y las variables financieras.

- **Resumen Ejecutivo. Caso Harvard Web Analytics.pdf**

Documento que presenta una síntesis de los hallazgos más relevantes del análisis. En este resumen se destacan las conclusiones clave del estudio, incluyendo la relación entre el tráfico del sitio web, el rendimiento financiero de la empresa y el impacto de las campañas promocionales.

--------------------------------------------------

# **Carpeta Stores**

Esta carpeta contiene las bases de datos utilizadas para el análisis.

**Archivos incluidos:**

- **Web_Analytics.xls**

Este archivo contiene la información utilizada en el caso, incluyendo datos sobre:

- visitas al sitio web
- métricas de analítica web
- ingresos (Revenue)
- utilidades (Profit)
- libras de material vendidas (Pounds Sold)

Estos datos constituyen la base para el análisis estadístico y la generación de visualizaciones.

--------------------------------------------------

# **Carpeta Scripts**

Esta carpeta contiene el código utilizado para desarrollar el análisis de datos.

El análisis fue realizado utilizando el software **R**.

**Archivo incluido:**

- **Caso Harvard Web Analytics.R**

Este script incluye:

- preparación y limpieza de los datos
- cálculo de estadísticas descriptivas
- construcción de gráficos
- análisis de relaciones entre variables
- generación de tablas y visualizaciones utilizadas en el informe final

--------------------------------------------------

# **Carpeta Views**

La carpeta **Views** contiene todas las **figuras, tablas y gráficos generados durante el análisis**.

Entre las visualizaciones incluidas se encuentran:

- gráficos de comportamiento semanal de:
  - Unique Visits
  - Revenue
  - Profit
  - Pounds Sold

- gráficos de medias por período
- diagramas de dispersión entre variables
- tablas de estadísticas descriptivas

Estas ilustraciones permiten interpretar y comunicar de manera clara los resultados obtenidos en el análisis.

--------------------------------------------------

# **Notas**

Para ejecutar correctamente el análisis se recomienda utilizar **R o RStudio**.

Antes de ejecutar los scripts es recomendable:

1. Configurar el directorio de trabajo en la carpeta **Scripts** del repositorio.
2. Verificar que todos los paquetes necesarios estén previamente instalados.
3. Ejecutar los scripts siguiendo el orden indicado en el código.

La velocidad de ejecución puede variar dependiendo de las características del equipo en el que se ejecuten los scripts.
