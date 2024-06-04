@echo off
setlocal

REM Nombre del contenedor de Docker para WordPress
set CONTAINER_NAME=wordpress-docker-compose-wp-1

REM Comprobar si el contenedor está en ejecución
docker ps | findstr /C:"%CONTAINER_NAME%" >nul
if errorlevel 1 (
    echo El contenedor %CONTAINER_NAME% no está en ejecución.
    exit /b 1
)

REM Cambiar el idioma del sitio a español de Chile
echo Cambiando el idioma del sitio a español de Chile...
docker exec %CONTAINER_NAME% wp site switch-language es_CL --allow-root

REM Actualizar la zona horaria del sitio
echo Actualizando la zona horaria a 'America/Santiago'...
docker exec --user www-data %CONTAINER_NAME% wp option update timezone_string "America/Santiago"

REM Actualizar el formato de fecha
echo Actualizando el formato de fecha a 'd-m-Y'...
docker exec --user www-data %CONTAINER_NAME% wp option update date_format "d-m-Y"

REM Actualizar el formato de hora
echo Actualizando el formato de hora a 'H:i'...
docker exec --user www-data %CONTAINER_NAME% wp option update time_format "H:i"

echo Configuración completada.
endlocal
