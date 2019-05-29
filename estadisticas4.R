##PRÁCTICA DE SCRAPING

##INSTALO LA LIBREÍA
##install.packages("rvest")

##CARGO LA LIBRERÍA
library(rvest)

##LE DOY UN NOMBRE A LA PÁGINA
url.leboro <- "http://www.leboro.es/estadisticas.aspx"

##COMVIERTO LA URL EN UN OBJETO LLAMADO tpm
tmp <- read_html(url.leboro)

##EL PAQUETE rvest TIENE ESTA FUNCIÓN PARA DETECTAR LOS MÓDULOS DE TABLA EN LA WEB
tmp <- html_nodes(tmp, "table")


## MIRO CUANTAS TABLAS HAY EN LA PÁGINA
length(tmp)
## [1] 5

## VEO LA CLASE DE LOS OBJETOS tpm
sapply(tmp, class)
## [1] "xml_node" "xml_node" "xml_node" "xml_node" "xml_node"

##CON ESTA FUNCIÓN PUEDO IR VISUALIZANDO LO QUE TIENEN LAS DIFERENTES TABLAS. LA QUE ME INTERSA ES LA 5
html_table (tmp[[1]])

## Para evitar tener que examinar las tablas una a una se puede hacer
##sapply(tmp, function(x) dim(html_table(x, fill = TRUE)))
## Nos indica que la quinta tabla tiene 35 filas, un indicio sólido de que es la que va a contener las cotizaciones de las 35 empresas del IBEX.

##Podemos entonces transformar este último nodo en una tabla de R:
mediasequipo <- html_table(tmp[[1]])
totalesequipo <- html_table(tmp[[2]])

## Si quisiera renombrar las columnas
mediasequipo3<-mediasequipo[2:19,]

## Y pongo nombre a las columnas
names(mediasequipo3) <- c("Equipo", "Partidos", "Minutos", "Puntos", "T2", "T3", "TC", "TL", "Rebotes totales", "Rebotes defensivos", "Rebotes ofensivos", "Asistencias", "Balones robados", "Balones perdidos", "Tapones a favor", "Tapones en contra", "Mates", "Faltas cometidas", "Faltas recibidas", "Valoracion")

## Le quito el %
mediasequipo3$T2 <- strsplit(as.character(mediasequipo3$T2),'%')
mediasequipo3$T3 <- strsplit(as.character(mediasequipo3$T3),'%')
mediasequipo3$TC <- strsplit(as.character(mediasequipo3$TC),'%')
mediasequipo3$TL <- strsplit(as.character(mediasequipo3$TL),'%')

##Para ver la clase de cada columna
##glimpse(mediasequipo2)

## Paso las columnas de character a numeric
mediasequipo3$Partidos<-as.numeric(mediasequipo3$Partidos)
mediasequipo3$Minutos<-as.numeric(mediasequipo3$Minutos)
mediasequipo3$Puntos<-as.numeric(mediasequipo3$Puntos)
mediasequipo3$T2<-as.numeric(mediasequipo3$T2)
mediasequipo3$T3<-as.numeric(mediasequipo3$T3)
mediasequipo3$TC<-as.numeric(mediasequipo3$TC)
mediasequipo3$TL<-as.numeric(mediasequipo3$TL)
mediasequipo3$`Rebotes totales`<-as.numeric(mediasequipo3$`Rebotes totales`)
mediasequipo3$`Rebotes defensivos`<-as.numeric(mediasequipo3$`Rebotes defensivos`)
mediasequipo3$`Rebotes ofensivos`<-as.numeric(mediasequipo3$`Rebotes ofensivos`)
mediasequipo3$Asistencias<-as.numeric(mediasequipo3$Asistencias)
mediasequipo3$`Balones robados`<-as.numeric(mediasequipo3$`Balones robados`)
mediasequipo3$`Balones perdidos`<-as.numeric(mediasequipo3$`Balones perdidos`)
mediasequipo3$`Tapones a favor`<-as.numeric(mediasequipo3$`Tapones a favor`)
mediasequipo3$`Tapones en contra`<-as.numeric(mediasequipo3$`Tapones en contra`)
mediasequipo3$Mates<-as.numeric(mediasequipo3$Mates)
mediasequipo3$`Faltas cometidas`<-as.numeric(mediasequipo3$`Faltas cometidas`)
mediasequipo3$`Faltas recibidas`<-as.numeric(mediasequipo3$`Faltas recibidas`)
mediasequipo3$Valoracion<-as.numeric(mediasequipo3$Valoracion)

##Divido las columnas con porcentajes por 100
mediasequipo3$T2<-(mediasequipo3$T2/100)
mediasequipo3$T3<-(mediasequipo3$T3/100)
mediasequipo3$TC<-(mediasequipo3$TC/100)
mediasequipo3$TL<-(mediasequipo3$TL/100)




totalesequipo3<-totalesequipo[2:19,]
names(totalesequipo3) <- c("Equipo", "Partidos", "Minutos", "Puntos", "T2", "T3", "TC", "TL", "Rebotes totales", "Rebotes defensivos", "Rebotes ofensivos", "Asistencias", "Balones robados", "Balones perdidos", "Tapones a favor", "Tapones en contra", "Mates", "Faltas cometidas", "Faltas recibidas", "Valoracion")

##Para ver una columna mediasequipo2$Puntos

##INSTALO PAQUETES DE LIMPIEZA DE DATOS
##install.packages("dplyr")
##install.packages("tidyr") 
##install.packages("readxl")

library(dplyr)
library(tidyr) 
library(readxl)


## VOY A GUARDAR LOS DATOS EN UN EXCEL
## INSTALO Y CARGO LA LIBRERÍA
##install.packages("xlsx")
library(xlsx)

## LE PASO A LA FUNCIÓN EL NOMBRE DEL ARCHIVO Y LA CARPETA DONDE LO QUIERO GUARDAR (IMPORTANTE CAMBIAR LA INCLINACIÓN DE LAS BARRAS)
write.xlsx(mediasequipo3, "C:/Users/viriv/Documents/Datos RStudio/Baloncesto/estadisticas3.xlsx", sheetName = "mediasequipo3", row.names = FALSE)

write.xlsx(totalesequipo3, "C:/Users/viriv/Documents/Datos RStudio/Baloncesto/estadisticas3.xlsx", sheetName = "totalesequipo3", row.names = FALSE ,append = TRUE)




