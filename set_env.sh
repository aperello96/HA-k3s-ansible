#!/bin/bash

# Ruta de la carpeta ansible_config_files
SOURCE_FOLDER="$HOME/HA-k3s-ansible/ansible_config_files"

# Ruta de la carpeta home del usuario
HOME_FOLDER="$HOME"

# Verificar si la carpeta de origen existe
if [ ! -d "$SOURCE_FOLDER" ]; then
  echo "La carpeta de origen no existe: $SOURCE_FOLDER"
  exit 1
fi

# Copiar cada archivo de la carpeta de origen a la carpeta home
for FILE in "$SOURCE_FOLDER"/*; do
  if [ -f "$FILE" ]; then
    cp "$FILE" "$HOME_FOLDER"
    echo "Archivo copiado: $FILE -> $HOME_FOLDER"
  else
    echo "Saltando (no es un archivo): $FILE"
  fi
done