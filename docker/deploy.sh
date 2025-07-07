#!/bin/bash

# Script maestro para automatizar el flujo completo de Docker
echo "--- INICIANDO DESPLIEGUE AUTOMATIZADO ---"

# Solicitar usuario de Docker Hub
read -p "Ingrese su usuario de Docker Hub: " DOCKER_HUB_USER

# 1. Crear la imagen
./create_image.sh || exit 1

# 2. Subir la imagen a Docker Hub
./upload_docker_container.sh "$DOCKER_HUB_USER" || exit 1

# 3. Eliminar la imagen local
./delete_local_image.sh || exit 1

# 4. Levantar el servicio web con Docker Compose
./compose_web_service.sh || exit 1

echo "--- DESPLIEGUE COMPLETO ---"
