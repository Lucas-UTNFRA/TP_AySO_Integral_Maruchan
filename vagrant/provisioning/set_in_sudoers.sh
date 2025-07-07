#!/bin/bash

VAGRANT="vagrant"

# Crea el archivo de sudoers para el usuario vagrant
echo "Agregando al usuario $VAGRANT al archivo de sudoers..."

echo "$VAGRANT ALL=(ALL) NOPASSWD: ALL" | tee /etc/sudoers.d/vagrant
chmod 440 /etc/sudoers.d/vagrant

echo "El usuario $VAGRANT ha sido agregado al archivo de sudoers con permisos sin contraseña."
