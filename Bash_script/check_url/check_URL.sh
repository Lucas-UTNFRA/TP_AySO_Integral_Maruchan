#!/bin/bash
clear

###############################
#
# Parametros:
#  - Lista Dominios y URL
#
#  Tareas:
#  - Se debera generar la estructura de directorio pedida con 1 solo comando con las tecnicas enseñadas en clases
#  - Generar los archivos de logs requeridos.
#
###############################
LISTA=$1

sudo mkdir -p /tmp/head-check/{Error/{cliente,servidor},ok}

LOG_FILE="/var/log/status_url.log"

ANT_IFS=$IFS
IFS=$'\n'


for LINEA in `cat "$LISTA" | grep -v ^#`
do
  #Extraigo dominio y url
  DOM=$(echo "$LINEA" | awk '{print $1}')
  URL=$(echo "$LINEA" | awk '{print $2}')

  # Obtener el código de estado HTTP
  STATUS_CODE=$(curl -LI -o /dev/null -w '%{http_code}\n' -s "$URL")

  # Fecha y hora actual en formato yyyymmdd_hhmmss
  TIMESTAMP=$(date +"%Y%m%d_%H%M%S")

  if [ "$STATUS_CODE" -eq 200 ]; then
          DIR="/tmp/head-check/ok"
  elif [[ "$STATUS_CODE" -ge 400 && $STATUS_CODE -lt 500 ]]; then
          DIR="/tmp/head-check/Error/cliente"
  elif [[ "$STATUS_CODE" -ge 500 && $STATUS_CODE -lt 600 ]]; then
          DIR="/tmp/head-check/Error/servidor"
  fi

  # Registrar en el archivo /var/log/status_url.log
  echo "$TIMESTAMP - Code:$STATUS_CODE - URL:$URL" |sudo tee -a  "$LOG_FILE"
  # Clasificar y registrar en un archivo especifico para el dominio
  echo "$TIMESTAMP - Code:$STATUS_CODE - URL:$URL" |sudo tee -a "$DIR/$DOM.log"

done


#-------------------------#

IFS=$ANT_IFS
