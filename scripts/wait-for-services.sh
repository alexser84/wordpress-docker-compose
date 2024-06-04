#!/bin/bash

# Espera a MariaDB
while ! mysqladmin ping -h"db" --silent; do
    echo 'Esperando a la base de datos...'
    sleep 1
done

# Espera a WordPress
until $(curl --output /dev/null --silent --head --fail http://wp:80); do
    printf '.'
    sleep 1
done

echo "Ambos servicios están listos."
exec "$@"
