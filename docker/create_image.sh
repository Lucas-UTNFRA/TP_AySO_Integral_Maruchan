#!/bin/bash

# Script para crear una imagen Docker

IMAGE_NAME="tp-div_313_grupo_maruchan"
TAG="latest"
DOCKERFILE_PATH="."

# Construir la imagen Docker
echo "Construyendo la imagen Docker: $IMAGE_NAME:$TAG..."
docker build -t "$IMAGE_NAME:$TAG" "$DOCKERFILE_PATH"

if [ $? -ne 0 ]; then
    echo "Error al construir la imagen Docker. Verifica el Dockerfile y vuelve a intentarlo."
    exit 1
fi

echo "Imagen Docker $IMAGE_NAME:$TAG creada correctamente."

