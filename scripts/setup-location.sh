#!/bin/bash

# Nombre del contenedor de Docker para WordPress
CONTAINER_NAME="wordpress-docker-compose-wp-1"

# Comprobar si el contenedor está en ejecución
if ! docker ps | grep -q "$CONTAINER_NAME"; then
    echo "El contenedor $CONTAINER_NAME no está en ejecución."
    exit 1
fi

# Cambiar el idioma del sitio a español de Chile
echo "Cambiando el idioma del sitio a español de Chile..."
docker exec $CONTAINER_NAME wp site switch-language es_CL --allow-root

# Actualizar la zona horaria del sitio
echo "Actualizando la zona horaria a 'America/Santiago'..."
docker exec --user www-data $CONTAINER_NAME wp option update timezone_string "America/Santiago"

# Actualizar el formato de fecha
echo "Actualizando el formato de fecha a 'd-m-Y'..."
docker exec --user www-data $CONTAINER_NAME wp option update date_format "d-m-Y"

# Actualizar el formato de hora
echo "Actualizando el formato de hora a 'H:i'..."
docker exec --user www-data $CONTAINER_NAME wp option update time_format "H:i"

echo "Configuración completada."
