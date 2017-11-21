
# Transformación de DataFrames
# David López
# @5h4n6

# Un DataFrame es una estructura de datos "rectangular"
# En muchas ocasiones, es necesario reorganizar los datos para  poder utilizarlos
# Y la estructura se debe "alargar" o "ensanchar", es decir, un caso de transposición parcial del dataset.
# Alargar: Transformar algunas columnas en registros
# Ensanchar: Transformar registros en columnas
# Se verán ejemplos con dos paquetes: reshape2 y tidyr


# Datos de ejemplo
ej.cars <- data.frame(nombre=row.names(mtcars),cilindros=mtcars$cyl,mpg=mtcars$mpg)
#Tenemos 32 registros X 3 columnas
head(ej.cars)
dim(ej.cars)


# Reshape2 tiene las funciones Cast y Melt
library(reshape2)

# Podemos "ensanchar" los datos:
ej.cars.cilindros <- dcast(ej.cars,nombre ~ cilindros,fill = 0)
# CAST ensancha los datos, de modo que deja una columna de "pivote" (nombre, en este caso),
# Y haciendo que cilindros sea las columnas, tomando de mpg los valores para cada columna
# Por tanto, las categorías de cilindros "ensanchan" el DataFrame
# Cast tiene algunas variantes, dependiendo del tipo de objeto de salida. Dcast es para data.frames
head(ej.cars.cilindros)
dim(ej.cars.cilindros)
# NOTA: Podemos usar fill=0 para rellenar los valores que salen como MISSING, o NA.
# Esto a veces no es correcto, depende de los datos que manejemos.
# Tal vez lo mejor sea descartar esos datos, o bien llenarlos con otro valor.

# Ahora, podemos alargar los datos:
# Con MELT, usamos id.vars como las variables pivote (las que quedan fijas);
# n.cilindros, el nombre de la columna para las variables (columnas) que serán transformadas a renglones;
# MPG: el nombre de la columna que tendrá los valores que anteriormente se encontraban en las  columnas no-pivote
ej.cars.alargados <- melt(ej.cars.cilindros,id.vars=c('nombre'),variable.name = 'n.cilindros',value.name = 'MPG')
head(ej.cars.alargados)
dim(ej.cars.alargados)
# Noten el aumento de los datos debido a que también se transponen las columnas con 0.


# Tidyr tiene las funciones Gather y Spread
library(tidyr)
# En mi muy humilde opinión, mucho más sencillas e igual de efectivas
# SPREAD "ensancha" el dataset. Puede llevar lo mismo que Cast, incluyendo 'fill'
ej.cars.spread <- spread(ej.cars,key=cilindros,value=mpg)
head(ej.cars.spread)

# GATHER "alarga" el dataset
# Parámetros: 
# - data.frame, 
# - columna donde se almacenará el nombre de variables, 
# - columna que tendrá los nuevos valores,
# - columnas a contraer
ej.cars.gather <- gather(ej.cars.spread,"Num.Cilindros","millasXgalon",2:4)
head(ej.cars.gather)


