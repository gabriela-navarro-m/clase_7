# Elaborado por: Eduard F. Martinez Gonzalez
# Fecha: 23 de septiembre de 2020
# Nota: No se usan acentos ni caracteres especiales para evitar conflictos entre los diferentes sistemas operativos.

#--------------------------#
# 0. Configuración inicial #
#--------------------------#

#### 0.0 Hoy veremos...
rstudioapi::viewer(url = "Intro-clase-7.html")

#### 0.1 Limpiar la consola, el entorno y fijar directorio de trabajo
cat("\f")
rm(list=ls())
options("scipen"=100, "digits"=4) # Forzar a R a no usar e+
setwd("~/Dropbox/teaching/Taller de R/GitHub/Clases/Clase 7") # Cambiar este directorio
getwd()

#### 0.2 Instalar las librerias que vamos a usar en la clase de hoy
for ( paquete in c("tidyverse",'data.table') ){
        if (length(grep(paquete,installed.packages()[,1])) == 0 ){ install.packages(paquete) ; print(paste0("La libreria ", "'", paquete ,"'", " ha sido instalada."))}
        else { print(paste0("La libreria ", "'", paquete ,"'", " ya está instalada."))}
        rm(paquete)
}

#### 0.3 Llamar las librerias
library('tidyverse') ; library('data.table') 

#------------------------#
# 1. for, while, repeat  #
#------------------------#

#### 1.0. Veamos la intuicion primero
rstudioapi::viewer(url = "help/loops-lapply.html")

#### 1.0.1 Podemos obtener ayuda adiccional aqui
browseURL(url = "https://www.datacamp.com/community/tutorials/tutorial-on-loops-in-r", browser = getOption("browser")) # Datacamp

#### 1.0.2 Cargar la base de datos
browseURL(url = "http://www.odc.gov.co/SIDCO", browser = getOption("browser")) # Fuente
odc = readRDS("data/original/odc.rds") %>% 
        subset(year>2010 & year <2019)
panel = read.csv(file = "data/original/Panel municipios.csv")

#### 1.1 Usando for
"Imprimamos los numeros de 1 a 10"
for (elemento in 2:10){
     print(elemento)      
}

for(i in colnames(odc)){
      print(i)
      summary(odc[,i]) %>% print()
}

#### 1.2 Usando while 
"Imprimamos solo los numeros menores a 6"
i <- 1
while (i <= 6) {
        print(i*i)
        i = i+1
}

#### 1.3 Usando repeat
"Generando numeros aleatorios mayores a 8"
repeat{
        i <- rnorm(n = 1,mean = 10,sd = 2) %>% round(.)
        print(i)
        if (i <= 8){
                break
        } 
}

#-------------------------------------------#
# 2. Controles de flujo (if, else, next, breack)  #
#-------------------------------------------#
?Control 

### 2.1. if y else
abc <- letters
vocal <- c("a","e","i","o","u")

"Usando solo if"
for (j in abc) {
        print(j)
        if (j %in% vocal){
                print(paste0(j," - es una vocal"))
        }
}

"Usando if y else"
for (letra in abc) {
        if (letra %in% vocal){
                print(paste(letra," - es una vocal"))
        }
        else {
                print(paste(letra," - NO es una vocal")) 
        } 
}

### 2.2. Next
for ( i in colnames(panel)){
        if (is.numeric(panel[,i]) == TRUE){
                paste0(i,' es una variable numerica') %>% print()
                mean(panel[,i]) %>% print()
        } 
        if (is.factor(panel[,i]) == TRUE){
                paste0(i,' es una variable logical') %>% print()
        } 
}

### 2.3. breack
for ( i in 1:ncol(panel)){
        if (is.numeric(panel[,i]) == TRUE){
                paste0(colnames(panel)[i],' es una variable numerica') %>% print()
                mean(panel[,i]) %>% print()
        } 
        else {
                paste0(colnames(panel)[i],' NO es una variable numerica') %>% print()
                break
        }  
}


#-------------------#
# 3. Familia apply  #
#-------------------#

### 3.0. podemos obtener ayuda adicional aqui  
browseURL(url = "https://www.guru99.com/r-apply-sapply-tapply.html", browser = getOption("browser")) 
browseURL(url = "http://adv-r.had.co.nz/Functionals.html", browser = getOption("browser")) 
browseURL(url = "https://www.datacamp.com/community/tutorials/r-tutorial-apply-family", browser = getOption("browser"))

### 3.1. apply()

### 3.1.1. Operaciones por columnas
apply(X = panel,MARGIN = 2, FUN = mean)
apply(X = panel,MARGIN = 2, function(variable) is.character(variable) %>% table())
apply(X = panel,MARGIN = 2, function(papa) table(papa))

### 3.1.2. Operaciones por filas
apply(X = data,MARGIN = 1, function(x) is.na(x) %>% table())

### 3.2. sapply()
package_list = c('tidyverse','data.table','caneca') 
sapply(package_list , require , character.only = TRUE) # De ahora en adelante usaremos esto para llamar las funciones

### 3.3. lapply()

### 3.3.1. sobre un dataframe

lapply(panel, function(x) is.na(x) %>% table()) # Contar los NA de cada columna del dataframe

lapply(odc, function(x) summary(x)) # Descriptivas de cada columna

list_panel = lapply(panel, function(yuca) as.numeric(yuca)) # Fijense que pasa con las coumnas del data.frame

new_odc = list_panel %>% data.frame() # Convertir en dataframe nuevamente

### 3.3.2. sobre un vector
lapply(1:10, function(x) x^2)

list_numeros = lapply(1:10, function(x) x^2)

list_numeros[[2]]




