#!/bin/bash

# Nombre o ID del contenedor de Docker donde se ejecuta WordPress
CONTAINER_NAME="wordpress-docker-compose-wp-1"

# Comprobar si el contenedor está ejecutando
if ! docker ps | grep -q "$CONTAINER_NAME"; then
    echo "El contenedor $CONTAINER_NAME no está en ejecución."
    exit 1
fi

# Instalar y activar WooCommerce
echo "Instalando y activando WooCommerce..."
docker exec $CONTAINER_NAME wp plugin install woocommerce --activate --allow-root

# Configurar opciones específicas para Chile
echo "Configurando opciones de WooCommerce para Chile..."
docker exec $CONTAINER_NAME wp option update woocommerce_store_address "Calle Ficticia 123" --allow-root
docker exec $CONTAINER_NAME wp option update woocommerce_store_city "Santiago" --allow-root
docker exec $CONTAINER_NAME wp option update woocommerce_default_country "CL:RM" --allow-root
docker exec $CONTAINER_NAME wp option update woocommerce_currency "CLP" --allow-root
docker exec $CONTAINER_NAME wp option update woocommerce_product_type "both" --allow-root
docker exec $CONTAINER_NAME wp option update woocommerce_allow_tracking "no" --allow-root

# Crear páginas esenciales de WooCommerce
echo "Creando páginas esenciales de WooCommerce..."
docker exec $CONTAINER_NAME wp wc tool run install_pages --user=admin --allow-root

# Configurar IVA (19% en Chile)
echo "Configurando IVA para Chile..."
docker exec $CONTAINER_NAME wp wc tax_rate create --country CL --state 'RM' --postcode '' --city '' --rate '19.00' --name 'IVA' --priority 1 --compound false --shipping true --order 1 --class standard --user=admin --allow-root

echo "Instalación y configuración completadas."
