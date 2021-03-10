rm(list=ls())
pacman::p_load(tidyverse, data, table)
df= readRDS("data/input/odc.rds")

table(df$year) #tabla de frecuencias: para el primer año se tiene tales obs y asi para cada uno

#tabla de frecuencia de las variables year, cultivos, erradicacion y asercion
vars=c("year", "cultivos", "erradicacion", "aspercion")
vars2=colnames(df) [2:5]
vars3= 2:ncol(df)
for (i in vars) {
  print(table(df[,i]))
}
for (i in vars) {
  print(i)
  df[,i] %>% table () %>% print()
}

#tambien se puede
for (i in 2:ncol(df)) {
  print(table(df[,i]))
}
#para poner mas de una variable se pone el vector
data= df[, c("year", "cultivos")]