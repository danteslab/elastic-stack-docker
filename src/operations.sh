# Crear un documento en el indice "posts"
POST posts/_doc
{
  "name": "Dante",
  "lastName": "Calderon",
  "age": 23,
  "ciudad": "Lima",
  "estadoCivil": "Viudo"
}

# Obtener el mapping de un indice
GET posts/_mapping

# Obtener un documento
GET posts/_doc/C-xCgXUBbQQPY1luuCWe

# Obtener solo el source de un documento
GET posts/_source/C-xCgXUBbQQPY1luuCWe


# Actualizacion total de un documento
PUT posts/_doc/C-xCgXUBbQQPY1luuCWe
{
  "age": 18
}

# Actualizacion parcial de un documento
POST posts/_update/C-xCgXUBbQQPY1luuCWe
{
  "doc": {
    "name": "Dante",
    "lastName": "Calderon",
    "ciudad": "Lima",
    "estadoCivil": "Viudo"
  }
}


# Eliminar un documento
DELETE posts/_doc/C-xCgXUBbQQPY1luuCWe

# Eliminar un indice
DELETE posts

# Bulk operations
POST _bulk?pretty
{ "delete" : { "_index" : "users", "_id" : 1 } }