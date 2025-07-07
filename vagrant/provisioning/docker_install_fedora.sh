#!/bin/bash

##############################################
#   Script para instalar docker en fedora*   #
#                                            #
#            *según doc. oficial*            #
##############################################

VAGRANT_USER="vagrant"


# Desinstalar los paquetes preinstalados

echo "Desinstalando paquetes antiguos... ⏳"

sudo dnf remove -y docker \
                  docker-client \
                  docker-client-latest \
                  docker-common \
                  docker-latest \
                  docker-latest-logrotate \
                  docker-logrotate \
                  docker-selinux \
                  docker-engine-selinux \
                  docker-engine

echo "Paquetes desinstalados correctamente ✅"


# Añadir el repositorio a fuentes APT:

echo "Añadiendo repositorio a apt source-list... ⏳"

sudo dnf -y install dnf-plugins-core
sudo dnf-3 config-manager --add-repo https://download.docker.com/linux/fedora/docker-ce.repo

echo "Repositorio añadido correctamente ✅"


# Instalar docker

echo "Instalando docker... ⏳"

sudo dnf install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

echo "Docker instalado correctamente ✅"


# Crear grupo docker en caso que no exista aún

if ! getent group docker > /dev/null; then
    echo "Creando grupo docker..."
    sudo groupadd docker
fi


# Eliminación de configuración anterior, en caso de existir

rm -rf ~/.docker

# Añadir usuario actual a grupo docker

echo "Añadiendo usuario $VAGRANT_USER al grupo docker..."

sudo usermod -aG docker "$VAGRANT_USER"
echo "---Usuario '$VAGRANT_USER' añadido al grupo 'docker'. ✅---"


# Reiniciar servicio de docker, por las dudas

sudo systemctl enable --now docker


# Testear que corra la imagen hello-world para comprobar instalación

echo "⏳ Verificando la instalación de docker. Esto puede tomar unos segundos..."

sleep 5

sudo docker run hello-world


# Mostrar mensajes de finalización correcta de script

echo "   Verificación completada. Si viste el mensaje 'Hello from Docker!', la instalación fue exitosa."

echo "----------"
echo "¡Instalación de Docker finalizada!"
echo "Recuerda cerrar sesión y volver a iniciarla (o reiniciar tu terminal) para poder usar Docker sin 'sudo'."
echo "----------"
echo ""

echo "Estado del servicio:"
sudo systemctl status docker | cat | head -n 12 
echo ""  

