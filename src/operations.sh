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


# Crear mappings para un indice
PUT platos
{
  "mappings": {
    "properties": {
      "nombre": {
        "type": "text"
      },
      "description": {
        "type": "text"
      },
      "pedidosUltimaHora": {
        "type": "integer"
      },
      "ultimaModificacion": {
        "properties": {
          "usuario": {
            "type": "text"
          },
          "fecha": {
            "type": "date"
          }
        }
      }
    }
  }
}

# Actualizar parcial los mappings
PUT platos/_mapping
{
  "properties": {
    "estado": {
      "type": "keyword"
    }
  }
}


# Busquedas de texto
GET platos/_search
{
  "query": {
    "simple_query_string": {
      "query": "nachos con queso"
    }
  }
}

GET platos/_search
{
  "query": {
    "simple_query_string": {
      "query": "bowl pollo saludable"
    }
  }
}

## Con score
GET platos/_search
{
  "query": {
    "simple_query_string": {
      "query": "guacamole picante",
      "fields": ["nombre^2", "descripcion"]
    }
  }
}


# Busqueda booleana
GET platos/_search
{
  "query": {
    "bool": {
      "must": {
        "match": {
          "descripcion": "picante"
        }
      },
      "filter": {
        "term": {
          "estado": "activo"
        }
      },
      "must_not": {
        "term": { "pedidosUltimaHora": 0}
      },
      "should": [
        {
          "match": {
            "descripcion": "aguacate"
          }
        },
        {
          "match": {
            "descripcion": "guacamole"
          }
        }
      ],
      "minimum_should_match": 1
    }
  }
}

## Aca el estado si influye en el puntaje y deben cumplir 2 shoulds
GET platos/_search
{
  "query": {
    "bool": {
      "must": [
        {
          "match": {
            "descripcion": "picante"
          }
        },
        {
          "term": {
            "estado": "activo"
          }
        }
      ],
      "must_not": {
        "term": {
          "pedidosUltimaHora": 0
        }
      },
      "should": [
        {
          "match": {
            "descripcion": "aguacate"
          }
        },
        {
          "match": {
            "descripcion": "guacamole"
          }
        },
        {
          "match": {
            "descripcion": "pico de gallo"
          }
        }
      ],
      "minimum_should_match": 2
    }
  }
}

# Consulta compuesta
GET platos/_search
{
  "query": {
    "bool": {
      "must": [
        {
          "bool": {
            "should": [
              {
                "term": {
                  "estado": "activo"
                }
              },
              {
                "term": {
                  "estado": "pendiente"
                }
              }
            ]
          }
        },
        {
          "bool": {
            "should": [
              {
                "match": {
                  "ultimaModificacion.usuario": "mail.com"
                }
              },
              {
                "match": {
                  "ultimaModificacion.usuario": "vendor.com"
                }
              }
            ]
          }
        },
        {
          "term": {
            "pedidosUltimaHora": 0
          }
        }
      ]
    }
  }
}





### PLATOS

GET platos/_mapping

PUT platos/_doc/1
{
  "nombre": "Bowl Picante",
  "descripcion": "Pollo, salsa picante, frijoles, platano y aguacate",
  "estado": "activo",
  "pedidosUltimaHora": 42,
  "ultimaModificacion": {
    "usuario": "rick@mail.com",
    "fecha": "2020-02-19"
  }
}

PUT platos/_doc/2
{
  "nombre": "Ensaladisima",
  "descripcion": "Aceitunas, cebolla, queso, tomate, aguacate(saludable)",
  "estado": "activo",
  "pedidosUltimaHora": 0,
  "ultimaModificacion": {
    "usuario": "rick@mail.com",
    "fecha": "2020-01-22"
  }
}


PUT platos/_doc/3
{
  "nombre": "Nachos XL",
  "descripcion": "Nachos de carne, guacamelo, pico de gallo, salsa picante y queso",
  "estado": "activo",
  "pedidosUltimaHora": 11,
  "ultimaModificacion": {
    "usuario": "jerry@mail.com",
    "fecha": "2020-03-01"
  }
}


### RESTAURANTES
PUT restaurantes/_doc/1
{
  "mappings": {
    "properties": {
      "nombre": {
        "type": "text"
      },
      "categorias": {
        "type": "nested",
        "properties": {
          "nombre": {
            "type": "keyword"
          },
          "principal": {
            "type": "boolean"
          }
        }
      }
    }
  }
}



PUT /restaurantes/_doc/1
{
  "nombre": "McDonalds",
  "categorias": [
    { "nombre": "Comida Rápida", "principal": true },
    { "nombre": "Desayunos", "principal": false },
    { "nombre": "Hamburguesas", "principal": false }
  ]
}

PUT restaurantes/_doc/2
{
  "nombre": "Burger King",
  "categorias": [
    { "nombre": "Comida Rápida", "principal": false },
    { "nombre": "Hamburguesas", "principal": true }
  ]
}

PUT restaurantes/_doc/3
{
  "nombre": "Subway",
  "categorias": [
    { "nombre": "Comida Saludable", "principal": false },
    { "nombre": "Sándwiches", "principal": true }
  ]
}


# Nested search
GET restaurantes/_search
{
  "query": {
    "nested": {
      "path": "categorias",
      "query": {
        "bool": {
          "must": {
            "term": { "categorias.nombre": "Comida Saludable" }
          }
        }
      }
    }
  }
}

# Búsqueda No. 2 - Ultima modificación desde la segunda mitad de Enero hasta finales de Febrero
GET restaurantes/_search
{
  "_source": ["nombre", "ultimaModificacion.fecha"],
  "query": {
    "range": {
      "ultimaModificacion.fecha": {
        "gte": "2020-01-15",
        "lt": "2020-03-01"
      }
    }
  }
}


# Agregaciones
# Obtenemos métricas de los restaurantes actuales
GET restaurantes/_search
{
    "aggs" : {
        "calificacionPromedio": { "avg" : { "field" : "calificacion" } },
        "calificacionMaxima": { "max" : { "field" : "calificacion" } },
        "calificacionMinima": { "min" : { "field" : "calificacion" } }
    }
}

# Indicamos que para los restaurantes sin calificación, por defecto es 3.0 (SUBWAY)
GET restaurantes/_search
{
    "aggs" : {
        "calificacionPromedio" : {
            "avg" : {
                "field" : "calificacion",
                "missing": 3.0
            } 
        }
    }
}





# Paso 1 - Vemos todos los datos en nuestro directorio de restaurantes
# GET /restaurantes/_search
# Contamos con todos los campos necesarios
# Platos y Categorías son objetos anidados de un Restaurante
# Tenemos los datos básicos del restaurante
# Guardamos la información del Usuario que modificó por última vez al restaurante
# Paso 2 - Filtrar el directorio usando datos de Restaurantes y Platos a la vez
# Obtener todos los restaurantes que:
# Estén ubicados en el Barrio Centro o en el Barrio Occidental
# Que sean de comida rápida ó que vendan nachos
GET /restaurantes/_search
{
  "query": {
    "bool": {
      "must": [
        {
          "bool": {
            "should": [
              {
                "match": {
                  "direccion": "centro"
                }
              },
              {
                "match": {
                  "direccion": "occidental"
                }
              }
            ]
          }
        },
        {
          "bool": {
            "should": [
              {
                "nested": {
                  "path": "categorias",
                  "query": {
                    "bool": {
                      "must": {
                        "term": {
                          "categorias.nombre": "Comida Rápida"
                        }
                      }
                    }
                  }
                }
              },
              {
                "nested": {
                  "path": "platos",
                  "query": {
                    "bool": {
                      "must": {
                        "match": {
                          "platos.descripcion": "nachos"
                        }
                      }
                    }
                  }
                }
              }
            ]
          }
        }
      ]
    }
  }
}