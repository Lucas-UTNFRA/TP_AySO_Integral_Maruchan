#!/bin/bash

VM_NAME=$1

# Generar clave si no existe
[ -f ~/.ssh/id_ed25519 ] || ssh-keygen -q -t ed25519 -N "" -f ~/.ssh/id_ed25519

# Agregar a authorized_keys locales (por si aún no está)
cat ~/.ssh/id_ed25519.pub >> ~/.ssh/authorized_keys

# Si la máquina virtual está accesible, copiar clave
ping -c 1 "$VM_NAME" &> /dev/null && sshpass -p "vagrant" ssh-copy-id -o StrictHostKeyChecking=no "$USER"@"$VM_NAME" || echo "No se pudo copiar la clave a "$VM_NAME" (aún no disponible)."
