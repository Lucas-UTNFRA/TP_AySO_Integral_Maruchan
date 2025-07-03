#!/bin/bash
clear

###############################
#
# Parametros:
#  - Lista de Usuarios a creiar
#  - Usuario del cual se obtendra la clave
#
#  Tareas:
#  - Crear los usuarios segun la lista recibida en los grupos descriptos
#  - Los usuarios deberan de tener la misma clave que la del usuario pasado por parametro
#
###############################

LISTA=$1
USUARIO_PARAMETRO=$2
CLAVE=$(sudo grep "$USUARIO_PARAMETRO" /etc/shadow | awk -F ':' '{print$2}')

ANT_IFS=$IFS
IFS=$'\n'

# Recorre la lista de usuarios
for LINEA in `cat $LISTA |  grep -v ^#`
do
        # Extrae el nombre de usuario.
        USUARIO=$(echo  $LINEA |awk -F ',' '{print $1}')
        # Extrae el grupo.
        GRUPO=$(echo  $LINEA |awk -F ',' '{print $2}')
        #Extrae el directorio HOME.
        DIRECTORIO_HOME=$(echo "$LINEA" | awk -F ',' '{print $3}')

        #Crea el grupo
        sudo groupadd "$GRUPO"

        #Crea el usuario.
        sudo useradd -m -s /bin/bash -g "$GRUPO" -d "$DIRECTORIO_HOME" -p "$CLAVE" "$USUARIO"

done
IFS=$ANT_IFS
