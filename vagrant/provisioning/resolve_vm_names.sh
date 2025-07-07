#!/bin/bash

# Definición de constantes de ip y nombre a agregar

# Testing
VM_TESTING_IP="192.168.56.10"
VM_TESTING_NAME="testing"

# Producción
VM_PRODUCCION_IP="192.168.56.11"
VM_PRODUCCION_NAME="produccion"

# Agregar las entradas al archivo /etc/hosts

echo "Agregando entradas al archivo /etc/hosts..."

cat <<EOF >> /etc/hosts
  # Resolución de nombres de máquinas virtuales
  $VM_TESTING_IP $VM_TESTING_NAME
  $VM_PRODUCCION_IP $VM_PRODUCCION_NAME
EOF
