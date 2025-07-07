#!/bin/bash

# Instala los paquetes necesarios para el entorno de desarrollo

sudo dnf update
sudo dnf install -y \
    git \
    curl \
    tree \
    vim \
    lvm2 \
    ansible \
    openssh-server \
    sshpass
    
