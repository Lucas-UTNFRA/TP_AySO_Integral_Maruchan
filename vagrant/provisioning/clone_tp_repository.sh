#!/bin/bash

GITHUB_REPO_URL="https://github.com/Lucas-UTNFRA/TP_AySO_Integral_Maruchan.git"

# Clona el repositorio del TP Integral en la máquina virtual
mkdir -p /home/vagrant/tp-integral
cd /home/vagrant/tp-integral
git clone "$GITHUB_REPO_URL" .