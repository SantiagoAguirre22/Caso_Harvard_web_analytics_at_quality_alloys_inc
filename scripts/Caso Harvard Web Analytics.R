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
# ---------------------------------------------------------
# Lectura de datos
# ---------------------------------------------------------

data_financials <- read_excel("Web_Analytics.xls", sheet = "Financials", skip = 4)
data_weekly_visits <- read_excel("Web_Analytics.xls", sheet = "Weekly Visits", skip = 4)
data_lbs <- read_excel("Web_Analytics.xls", sheet = "Lbs. Sold", skip = 4)
data_daily_visits <- read_excel("Web_Analytics.xls", sheet = "Daily Visits", skip = 4)

# Eliminar columna vacía de financials si existe
data_financials <- data_financials %>%
  select(where(~ !all(is.na(.))))

# Unir bases para trabajar puntos 1, 2, 3, 5, 6 y 7
data_combined <- left_join(
  data_financials,
  data_weekly_visits,
  by = "Week (2008-2009)"
)

# Crear orden de semanas
orden_semanas <- data_combined$Week (2008-2009)

data_combined <- data_combined %>%
  mutate(Week (2008-2009) = factor(Week (2008-2009), levels = orden_semanas))

# Crear periodos
data_combined <- data_combined %>%
  mutate(period = case_when(
    Week (2008-2009) %in% orden_semanas[1:14] ~ "Initial",
    Week (2008-2009) %in% orden_semanas[15:34] ~ "Pre-promotion",
    Week (2008-2009) %in% orden_semanas[35:50] ~ "Promotion",
    Week (2008-2009) %in% orden_semanas[51:length(orden_semanas)] ~ "Post-promotion",
    TRUE ~ NA_character_
  ))

data_combined$period <- factor(
  data_combined$period,
  levels = c("Initial", "Pre-promotion", "Promotion", "Post-promotion")
)
