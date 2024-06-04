FROM wordpress:cli

# Establecer el usuario root para configurar el entorno
USER root

# Usar apk para instalar sudo, si es necesario, y ajustar permisos
RUN apk update && apk add sudo

# Asegurar los permisos adecuados
RUN mkdir -p /var/www/html/wp-content/languages
RUN chown -R www-data:www-data /var/www/html

# Cambiar al usuario por defecto si necesario
#USER www-data
