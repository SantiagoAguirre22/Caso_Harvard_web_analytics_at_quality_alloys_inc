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
# ---------------------------------------------------------
# Punto 1
# ---------------------------------------------------------

# Gráfica de Unique Visits
grafico_unique_visits <- ggplot(data_combined, aes(x = Week (2008-2009), y = Unique Visits)) +
  geom_col(fill = "steelblue") +
  labs(
    title = "Unique Visits",
    x = "Week",
    y = "Unique Visits"
  ) +
  theme_minimal() +
  theme(
    axis.text.x = element_text(angle = 90, size = 8, vjust = 0.5),
    plot.title = element_text(size = 16, face = "bold"),
    axis.title = element_text(size = 12)
  )

print(grafico_unique_visits)
ggsave("unique_visits.png", plot = grafico_unique_visits, width = 18, height = 8, dpi = 300)

# Gráfica de Revenue
grafico_revenue <- ggplot(data_combined, aes(x = Week (2008-2009), y = Revenue)) +
  geom_col(fill = "steelblue") +
  labs(
    title = "Revenue",
    x = "Week",
    y = "Revenue"
  ) +
  scale_y_continuous(labels = label_dollar(prefix = "$", big.mark = ".", decimal.mark = ",")) +
  theme_minimal() +
  theme(
    axis.text.x = element_text(angle = 90, size = 8, vjust = 0.5),
    plot.title = element_text(size = 16, face = "bold"),
    axis.title = element_text(size = 12)
  )

print(grafico_revenue)
ggsave("revenue_plot.png", plot = grafico_revenue, width = 18, height = 8, dpi = 300)

# Gráfica de Profit
grafico_profit <- ggplot(data_combined, aes(x = Week (2008-2009), y = Profit)) +
  geom_col(fill = "steelblue") +
  labs(
    title = "Profit",
    x = "Week",
    y = "Profit"
  ) +
  scale_y_continuous(labels = label_dollar(prefix = "$", big.mark = ".", decimal.mark = ",")) +
  theme_minimal() +
  theme(
    axis.text.x = element_text(angle = 90, size = 8, vjust = 0.5),
    plot.title = element_text(size = 16, face = "bold"),
    axis.title = element_text(size = 12)
  )

print(grafico_profit)
ggsave("profit_plot.png", plot = grafico_profit, width = 18, height = 8, dpi = 300)

# Gráfica de Pounds Sold
grafico_pounds_sold <- ggplot(data_combined, aes(x = Week (2008-2009), y = Lbs. Sold)) +
  geom_col(fill = "steelblue") +
  labs(
    title = "Pounds Sold",
    x = "Week",
    y = "Pounds Sold"
  ) +
  theme_minimal() +
  theme(
    axis.text.x = element_text(angle = 90, size = 8, vjust = 0.5),
    plot.title = element_text(size = 16, face = "bold"),
    axis.title = element_text(size = 12)
  )

print(grafico_pounds_sold)
ggsave("pounds_sold_plot.png", plot = grafico_pounds_sold, width = 18, height = 8, dpi = 300)
