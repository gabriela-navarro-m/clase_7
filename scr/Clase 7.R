#==============================================================================#
# Autor(es): Eduard Martinez
# Colaboradores: 
# Fecha creacion: 10/08/2019
# Fecha modificacion: 10/03/2021
# Version de R: 4.0.3.
#==============================================================================#

# intial configuration
rm(list = ls()) # limpia el entorno de R
pacman::p_load(tidyverse,data.table) # cargar y/o instalar paquetes a usar

#------------------------#
# 1. for, while, repeat  #
#------------------------#

#### 1.0.1 Podemos obtener ayuda adiccional aqui
browseURL(url = "https://www.datacamp.com/community/tutorials/tutorial-on-loops-in-r", browser = getOption("browser")) # Datacamp


#### 1.0.2 Cargar la base de datos
browseURL(url = "http://www.odc.gov.co/SIDCO", browser = getOption("browser")) # Fuente
odc = readRDS("data/input/odc.rds") %>% subset(year>2010 & year <2019)
panel = read.csv(file = "data/input/Panel municipios.csv")


#### 1.1 Usando for (Imprimamos los numeros de 1 a 5)
vector =  1:5
for (i in vector){
     i = i*i  # Sobreescribe i como el resultado de i*i
     print(i) # Pinta el resultado sobre la consola
}


# imprimamos las descritivas de la base de datos odc
for(i in colnames(odc)){
      print(i)
      summary(odc[,i]) %>% print()
}


#### 1.2 Usando while (imprimamos solo los numeros menores a 6)
j = 1
while (j <= 6) { # condición
       print(j*j) # pintar sobre la consola el producto de j*j
       j = j+1 # sobreescribir j como j + 1
}


#### 1.3 Usando repeat (generando numeros aleatorios mayores a 8)
repeat{
       m = rnorm(n=1 , mean=10 , sd=2) # generar un número aleatorio (media 10 , sd 2) 
       print(m) # pintar el número sobre la consola
       if (m <= 8){ # condicionar a que ese número sea menor o igual a 8
           break # detener el loop si m es menor o igual a 8 
       } 
}


#-------------------------------------------------#
# 2. Controles de flujo (if, else, next, breack)  #
#-------------------------------------------------#
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
sapply(c('tidyverse','data.table','caneca')  , require , character.only = TRUE) # De ahora en adelante usaremos esto para llamar las funciones

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
