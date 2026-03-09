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

# ---------------------------------------------------------
# Punto 2
# ---------------------------------------------------------

# Función de estadísticas descriptivas
desc_stats <- function(df) {
  data.frame(
    Measure = c("Mean", "Median", "Standard Deviation", "Minimum", "Maximum"),
    Visits = c(
      mean(df$Visits, na.rm = TRUE),
      median(df$Visits, na.rm = TRUE),
      sd(df$Visits, na.rm = TRUE),
      min(df$Visits, na.rm = TRUE),
      max(df$Visits, na.rm = TRUE)
    ),
    Unique Visits = c(
      mean(df$Unique Visits, na.rm = TRUE),
      median(df$Unique Visits, na.rm = TRUE),
      sd(df$Unique Visits, na.rm = TRUE),
      min(df$Unique Visits, na.rm = TRUE),
      max(df$Unique Visits, na.rm = TRUE)
    ),
    Revenue = c(
      mean(df$Revenue, na.rm = TRUE),
      median(df$Revenue, na.rm = TRUE),
      sd(df$Revenue, na.rm = TRUE),
      min(df$Revenue, na.rm = TRUE),
      max(df$Revenue, na.rm = TRUE)
    ),
    Profit = c(
      mean(df$Profit, na.rm = TRUE),
      median(df$Profit, na.rm = TRUE),
      sd(df$Profit, na.rm = TRUE),
      min(df$Profit, na.rm = TRUE),
      max(df$Profit, na.rm = TRUE)
    ),
    Lbs. Sold = c(
      mean(df$Lbs. Sold, na.rm = TRUE),
      median(df$Lbs. Sold, na.rm = TRUE),
      sd(df$Lbs. Sold, na.rm = TRUE),
      min(df$Lbs. Sold, na.rm = TRUE),
      max(df$Lbs. Sold, na.rm = TRUE)
    )
  )
}

tabla_initial <- data_combined %>%
  filter(period == "Initial") %>%
  desc_stats()

tabla_pre <- data_combined %>%
  filter(period == "Pre-promotion") %>%
  desc_stats()

tabla_promotion <- data_combined %>%
  filter(period == "Promotion") %>%
  desc_stats()

tabla_post <- data_combined %>%
  filter(period == "Post-promotion") %>%
  desc_stats()

tabla_initial[, 2:6] <- round(tabla_initial[, 2:6], 2)
tabla_pre[, 2:6] <- round(tabla_pre[, 2:6], 2)
tabla_promotion[, 2:6] <- round(tabla_promotion[, 2:6], 2)
tabla_post[, 2:6] <- round(tabla_post[, 2:6], 2)

cat("\nINITIAL PERIOD\n")
print(tabla_initial)

cat("\nPRE-PROMOTION PERIOD\n")
print(tabla_pre)

cat("\nPROMOTION PERIOD\n")
print(tabla_promotion)

cat("\nPOST-PROMOTION PERIOD\n")
print(tabla_post)

# Exportar tablas a Excel
wb <- createWorkbook()

addWorksheet(wb, "Initial")
addWorksheet(wb, "Pre-promotion")
addWorksheet(wb, "Promotion")
addWorksheet(wb, "Post-promotion")

writeData(wb, "Initial", tabla_initial)
writeData(wb, "Pre-promotion", tabla_pre)
writeData(wb, "Promotion", tabla_promotion)
writeData(wb, "Post-promotion", tabla_post)

saveWorkbook(wb, "descriptive_statistics.xlsx", overwrite = TRUE)

# ---------------------------------------------------------
# Punto 3
# ---------------------------------------------------------

means_by_period <- data_combined %>%
  group_by(period) %>%
  summarise(
    mean_visits = mean(Visits, na.rm = TRUE),
    mean_unique_visits = mean(Unique Visits, na.rm = TRUE),
    mean_revenue = mean(Revenue, na.rm = TRUE),
    mean_profit = mean(Profit, na.rm = TRUE),
    mean_pounds_sold = mean(Lbs. Sold, na.rm = TRUE)
  )

# Gráfica 1: Mean Visits
g1 <- ggplot(means_by_period, aes(x = period, y = mean_visits)) +
  geom_col(fill = "steelblue") +
  geom_text(aes(label = round(mean_visits, 2)), vjust = -0.3, size = 4) +
  labs(
    title = "Mean Visits by Period",
    x = "Period",
    y = "Mean Visits"
  ) +
  theme_minimal()

print(g1)

# Gráfica 2: Mean Unique Visits
g2 <- ggplot(means_by_period, aes(x = period, y = mean_unique_visits)) +
  geom_col(fill = "steelblue") +
  geom_text(aes(label = round(mean_unique_visits, 2)), vjust = -0.3, size = 4) +
  labs(
    title = "Mean Unique Visits by Period",
    x = "Period",
    y = "Mean Unique Visits"
  ) +
  theme_minimal()

print(g2)

# Gráfica 3: Mean Revenue
g3 <- ggplot(means_by_period, aes(x = period, y = mean_revenue)) +
  geom_col(fill = "steelblue") +
  geom_text(aes(label = dollar(mean_revenue, prefix = "$", big.mark = ".", decimal.mark = ",")),
            vjust = -0.3, size = 4) +
  labs(
    title = "Mean Revenue by Period",
    x = "Period",
    y = "Mean Revenue"
  ) +
  scale_y_continuous(labels = label_dollar(prefix = "$", big.mark = ".", decimal.mark = ",")) +
  theme_minimal()

print(g3)

# Gráfica 4: Mean Profit
g4 <- ggplot(means_by_period, aes(x = period, y = mean_profit)) +
  geom_col(fill = "steelblue") +
  geom_text(aes(label = dollar(mean_profit, prefix = "$", big.mark = ".", decimal.mark = ",")),
            vjust = -0.3, size = 4) +
  labs(
    title = "Mean Profit by Period",
    x = "Period",
    y = "Mean Profit"
  ) +
  scale_y_continuous(labels = label_dollar(prefix = "$", big.mark = ".", decimal.mark = ",")) +
  theme_minimal()

print(g4)

# Gráfica 5: Mean Pounds Sold
g5 <- ggplot(means_by_period, aes(x = period, y = mean_pounds_sold)) +
  geom_col(fill = "steelblue") +
  geom_text(aes(label = round(mean_pounds_sold, 2)), vjust = -0.3, size = 4) +
  labs(
    title = "Mean Pounds Sold by Period",
    x = "Period",
    y = "Mean Pounds Sold"
  ) +
  theme_minimal()

print(g5)

ggsave("mean_visits.png", plot = g1, width = 8, height = 5, dpi = 300)
ggsave("mean_unique_visits.png", plot = g2, width = 8, height = 5, dpi = 300)
ggsave("mean_revenue.png", plot = g3, width = 8, height = 5, dpi = 300)
ggsave("mean_profit.png", plot = g4, width = 8, height = 5, dpi = 300)
ggsave("mean_pounds_sold.png", plot = g5, width = 8, height = 5, dpi = 300)

# ---------------------------------------------------------
# Punto 5
# ---------------------------------------------------------

revenue <- data_combined$Revenue
pounds_sold <- data_combined$Lbs. Sold

grafico_p5 <- ggplot(data_combined, aes(x = Lbs. Sold, y = Revenue)) +
  geom_point(color = "steelblue", size = 2, alpha = 0.7) +
  labs(
    title = "Revenue vs Pounds Sold",
    subtitle = "Quality Alloys, Inc.",
    x = "Pounds Sold",
    y = "Revenue"
  ) +
  theme_minimal(base_size = 14) +
  theme(
    plot.title = element_text(face = "bold"),
    axis.title = element_text(face = "bold")
  )

print(grafico_p5)

correlation_p5 <- cor(revenue, pounds_sold, use = "complete.obs")
correlation_p5

# ---------------------------------------------------------
# Punto 6
# ---------------------------------------------------------

grafico_p6 <- ggplot(data_combined, aes(x = Visits, y = Revenue)) +
  geom_point(color = "steelblue", size = 2.5, alpha = 0.75) +
  labs(
    title = "Revenue vs Visits",
    subtitle = "Quality Alloys, Inc.",
    x = "Website Visits",
    y = "Revenue"
  ) +
  theme_minimal(base_size = 14) +
  theme(
    plot.title = element_text(face = "bold"),
    axis.title = element_text(face = "bold")
  )

print(grafico_p6)

correlation_p6 <- cor(data_combined$Revenue, data_combined$Visits, use = "complete.obs")
correlation_p6

# ---------------------------------------------------------
# Punto 7
# ---------------------------------------------------------

grafico_rev_inq <- ggplot(data_combined, aes(x = Inquiries, y = Revenue)) +
  geom_point(color = "steelblue", size = 2.5, alpha = 0.7) +
  labs(
    title = "Revenue vs Inquiries",
    subtitle = "Quality Alloys, Inc.",
    x = "Number of Inquiries",
    y = "Revenue"
  ) +
  theme_minimal(base_size = 14) +
  theme(
    plot.title = element_text(face = "bold"),
    axis.title = element_text(face = "bold")
  )

print(grafico_rev_inq)

correlation_rev_inq <- cor(data_combined$Revenue, data_combined$Inquiries, use = "complete.obs")
correlation_rev_inq

grafico_vis_inq <- ggplot(data_combined, aes(x = Visits, y = Inquiries)) +
  geom_point(color = "steelblue", size = 2.5, alpha = 0.7) +
  labs(
    title = "Visits vs Inquiries",
    subtitle = "Quality Alloys, Inc.",
    x = "Website Visits",
    y = "Number of Inquiries"
  ) +
  theme_minimal(base_size = 14) +
  theme(
    plot.title = element_text(face = "bold"),
    axis.title = element_text(face = "bold")
  )

print(grafico_vis_inq)

correlation_vis_inq <- cor(data_combined$Visits, data_combined$Inquiries, use = "complete.obs")
correlation_vis_inq

# ---------------------------------------------------------
# Punto 8
# ---------------------------------------------------------

# Revisar estructura de los datos
str(data_lbs)
head(data_lbs)

# Extraer la variable de libras vendidas
lbs_sold <- data_lbs$`Lbs. Sold`

# ---------------------------------------------------------
# Inciso (a)
# ---------------------------------------------------------

mean_lbs <- mean(lbs_sold, na.rm = TRUE)
median_lbs <- median(lbs_sold, na.rm = TRUE)
sd_lbs <- sd(lbs_sold, na.rm = TRUE)
min_lbs <- min(lbs_sold, na.rm = TRUE)
max_lbs <- max(lbs_sold, na.rm = TRUE)

tabla_resumen <- data.frame(
  Measure = c("Mean", "Median", "Standard Deviation", "Minimum", "Maximum"),
  Value = c(mean_lbs, median_lbs, sd_lbs, min_lbs, max_lbs)
)

tabla_resumen_gt <- tabla_resumen %>%
  gt() %>%
  tab_header(
    title = md("**Descriptive Statistics for Pounds Sold**")
  ) %>%
  fmt_number(
    columns = Value,
    decimals = 2
  ) %>%
  cols_align(
    align = "center",
    columns = everything()
  ) %>%
  tab_options(
    table.width = pct(80),
    heading.align = "center",
    table.font.size = px(13),
    data_row.padding = px(6)
  )

tabla_resumen_gt

# ---------------------------------------------------------
# Inciso (b)
# ---------------------------------------------------------

histograma_lbs <- ggplot(data_lbs, aes(x = `Lbs. Sold`)) +
  geom_histogram(bins = 20, fill = "steelblue", color = "black") +
  labs(
    title = "Pounds Sold per Week",
    x = "Pounds Sold",
    y = "Frequency"
  ) +
  formato_grafica

print(histograma_lbs)

ggsave("histograma_libras_vendidas.png", histograma_lbs, width = 8, height = 5, dpi = 300)
