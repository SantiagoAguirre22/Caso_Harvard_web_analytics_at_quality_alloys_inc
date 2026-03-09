# Instalar paquetes necesarios
if(!require(readxl)) install.packages("readxl")
if(!require(dplyr)) install.packages("dplyr")
if(!require(ggplot2)) install.packages("ggplot2")
if(!require(moments)) install.packages("moments")
if(!require(gt)) install.packages("gt")
if(!require(htmlwidgets)) install.packages("htmlwidgets")
if(!require(scales)) install.packages("scales")
if(!require(openxlsx)) install.packages("openxlsx")

# Llamar librerías
library(readxl)
library(dplyr)
library(ggplot2)
library(moments)
library(gt)
library(htmlwidgets)
library(scales)
library(openxlsx)

# Definir carpeta de trabajo
setwd("C:/Users/Usuario/Documents")
getwd()

# Crear formato de gráficas
formato_grafica <- theme_gray() +
  theme(
    plot.title = element_text(hjust = 0.5, face = "bold", size = 14),
    axis.title = element_text(size = 11),
    axis.text = element_text(size = 10)
  )