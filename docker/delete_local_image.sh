#!/bin/bash

# Script para eliminar una imagen Docker local

IMAGE_NAME="tp-div_313_grupo_maruchan"
TAG="latest"

# Eliminar la imagen Docker local
echo "Eliminando la imagen Docker: $IMAGE_NAME:$TAG..."
docker rmi "$IMAGE_NAME:$TAG"

echo "Imagen $IMAGE_NAME:$TAG eliminada correctamente."