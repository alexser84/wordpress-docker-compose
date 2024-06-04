#!/bin/bash

# Ajustar los permisos para asegurar que www-data pueda acceder y escribir
chown -R www-data:www-data /var/www/html

# Ejecutar cualquier comando pasado al entrypoint (por ejemplo, `docker-compose up`)
exec "$@"
