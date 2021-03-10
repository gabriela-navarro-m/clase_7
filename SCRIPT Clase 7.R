#Bucle o loop es proceso que se puede iterar para aplicar a objetos
#tipos: for (for each de stata), while y repeat
#for es meter vector, si esta en vector sigue el proceso, cuando no hay elemento entonces lo saca del loop
#while es que si cumple condicion entonces lo cmbia pero si no pues lo saca del loop
#repeat es que aplica la funcion y después entra la condición, si cumple la saca de loop o si no volverlo a iterar 

#for (elemento que va a cambiar en cada iteracion -puede ser cualquier letra in vector que puede ser caracteres o numeros) {
# i=i+i lo sobreescribe en cada iteracion-- el cuerpo del loop o sentencia 
# print(i) para pintarlo sobre la consola - cada accion se debe poner en lineas diferentes o separarlo con ;
#}
vector= 1:5
for (i in vector) {
  i=i*i
  print(i)
}

i=2; i=i*i ; print(i)

#while (condicion para elemento que se tiene que crear antes) {
# print(j*j) 
# j=j+1 cambios que le va a hacer si cumple esa condicion
#}
j=1
while (j<5){
  print(j*j)
  j=j+1
}

#repeat {
# algun vector o columna o variable
# condicion respecto a ese vector 
# if (condicion cuando se quiere que pare) {
#   break  para que ya rompa el loop
#}
#}
repeat {
  m= rnorm(n=1, mean=10, sd=2)
  print(m)
  if (m<8) {
    break
  }
}


#controles de flujo para que si encuentra algun problema o condicion se de una instruccion: if, else, break
#sin else si no cumple la condicion lo salta y pasa al siguiente elemento- el if define tal condicion y el %in% mira cada elemento y se peude aplicar a una matriz pero no dataframe

number= seq(from=1, to=7, by=1)
pares= seq(from=2, to=6, by=2)
for(j in number) {
  if (j %in% pares){
    print(paste0(j, "- es un # par"))
  }
}

#el else es si no cumple la primera condicion
for(j in number) {
  if (j %in% pares){
    print(paste0(j, "- es un # par"))
  }
  else { 
      print(paste0(j, "- NO es un # par"))}
}

#se pueden poner varios if pero solo un else por cada if
for(j in number) {
  if (j>5) {
    break
  }
  if (j %in% pares){
    print(paste0(j, "- es un # par"))
  }
  else { 
    next}
}
#el else responde es al if anterior, porque se asume que si se pasa al siguiente if entonces es porque cumple ese if

#Familia apply
#tapply + las otras- son como loop pero mas sencillo
#apply (matriz o data frame que se va a aplicar funcion, dimension 1: filas y 2: columnas, funcion que se quiere meter)
#lapply es para listas 
summary(odc)
lapply(odc, summary)