#!/bin/bash

##############################################
#   Script para instalar docker en ubuntu*   #
#                                            #
#	           *según doc. oficial*            #
##############################################

VAGRANT_USER="vagrant"

# Definición de paquetes

PACKAGES=docker.io docker-doc docker-compose docker-compose-v2 podman-docker containerd runc


# Iteración para desinstalar los paquetes previamente definidos

echo "Desinstalando paquetes antiguos... ⏳"

for pkg in $PACKAGES; do 
	sudo apt-get remove -y "$pkg"; 
done

sudo apt-get autoremove -y

echo "Paquetes desinstalados correctamente ✅"


# Añadir key GPG oficial de Docker:

echo "Añadiendo clave GPG oficial de docker... ⏳"

sudo apt-get update
sudo apt-get install -y ca-certificates curl
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc

echo "Clave añadida correctamente ✅"


# Añadir el repositorio a fuentes APT:

echo "Añadiendo repositorio a apt source-list... ⏳"

echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "${UBUNTU_CODENAME:-$VERSION_CODENAME}") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update

echo "Repositorio añadido correctamente ✅"


# Instalar docker

echo "Instalando docker... ⏳"

sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

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

sudo systemctl restart docker


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

