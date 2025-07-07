#!/bin/bash

# Script para iniciar un servicio web usando docker compose

# Inicializar el servicio web con Docker Compose
echo "Iniciando el servicio web con Docker Compose..."
docker-compose up -d

if [ $? -ne 0 ]; then
    echo "Error inicializando el servicio web. Asegúrate de que Docker y Docker Compose están instalados correctamente."
    exit 1
fi

echo "Servicio web iniciado correctamente."
echo "Puedes acceder al servicio en http://localhost:8081"
echo "Para detener el servicio, usar 'docker compose down'"
