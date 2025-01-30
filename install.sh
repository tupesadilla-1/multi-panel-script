#!/bin/bash

# Colores para el instalador
RED="\e[31m"
GREEN="\e[32m"
CYAN="\e[36m"
RESET="\e[0m"
BOLD="\e[1m"

clear
echo -e "${CYAN}${BOLD}==========================================${RESET}"
echo -e "${GREEN}${BOLD}      MULTI-PANEL INSTALLER SCRIPT        ${RESET}"
echo -e "${CYAN}${BOLD}==========================================${RESET}"

echo -e "${CYAN}Actualizando paquetes y configuraciones...${RESET}"
apt update && apt upgrade -y

echo -e "${CYAN}Instalando dependencias necesarias...${RESET}"
apt install -y git curl

echo -e "${CYAN}Clonando el proyecto desde GitHub...${RESET}"
git clone https://github.com/tuusuario/multi-panel-script.git || { echo -e "${RED}Error al clonar el repositorio${RESET}"; exit 1; }

cd multi-panel-script

echo -e "${CYAN}Dando permisos de ejecución...${RESET}"
chmod +x multi-panel.sh

echo -e "${CYAN}Iniciando el Multi-Panel...${RESET}"
./multi-panel.sh
