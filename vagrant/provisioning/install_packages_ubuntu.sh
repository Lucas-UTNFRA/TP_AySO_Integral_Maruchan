#!/bin/bash

# Instala los paquetes necesarios para el entorno de desarrollo

sudo apt update
sudo apt install -y \
    git \
    curl \
    tree \
    vim \
    lvm2 \
    ansible \
    openssh-server \
    sshpass
    
