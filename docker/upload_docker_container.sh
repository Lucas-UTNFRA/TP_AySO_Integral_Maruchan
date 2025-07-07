#!/bin/bash

# Script para subir un contenedor Docker a un repositorio
# Requiere que Docker esté instalado y configurado

# Uso: ./upload_docker_container.sh <docker-hub_username>

if [ "$#" -ne 1 ]; then
    echo "Uso: $0 <docker-hub_username>"
    exit 1
fi

IMAGE_NAME="tp-div_313_grupo_maruchan"
DOCKER_HUB_USER=$1

# Iniciar sesión en Docker Hub
echo "Iniciando sesión en Docker Hub..."
echo "Por favor, ingresa tus credenciales de Docker Hub."
docker login

if [ $? -ne 0 ]; then
    echo "Error al iniciar sesión en Docker Hub. Verifica tus credenciales."
    exit 1
fi

REPOSITORY="$DOCKER_HUB_USER/$IMAGE_NAME"

# Subir la imagen al repositorio
echo "Subiendo la imagen $IMAGE_NAME al repositorio $REPOSITORY..."
docker push "$REPOSITORY"
if [ $? -ne 0 ]; then
    echo "Error al subir la imagen. Verifica que la imagen existe y que tienes permisos para subirla."
    exit 1
fi

echo "Imagen $IMAGE_NAME subida correctamente al repositorio $REPOSITORY."
