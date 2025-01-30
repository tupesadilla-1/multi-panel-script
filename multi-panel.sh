#!/bin/bash

# Colores para mejorar la apariencia
RED="\e[31m"
GREEN="\e[32m"
YELLOW="\e[33m"
BLUE="\e[34m"
CYAN="\e[36m"
RESET="\e[0m"
BOLD="\e[1m"

# Variables de idioma por defecto
LANGUAGE="es"  # es: español, en: inglés, qu: quechua

# Mensajes traducidos
declare -A MESSAGES_ES=(
  ["welcome"]="Bienvenido al Panel"
  ["select_option"]="Selecciona una opción"
  ["language_changed"]="Idioma cambiado correctamente"
  ["server_info"]="Información del servidor"
  ["traffic_info"]="Tráfico del servidor"
)

declare -A MESSAGES_EN=(
  ["welcome"]="Welcome to the Panel"
  ["select_option"]="Select an option"
  ["language_changed"]="Language successfully changed"
  ["server_info"]="Server Information"
  ["traffic_info"]="Server Traffic"
)

declare -A MESSAGES_QU=(
  ["welcome"]="Rimaykullayki Panelman"
  ["select_option"]="Munanayta akllay"
  ["language_changed"]="Simiqa tukuyta tukukusqa"
  ["server_info"]="Ruwanakuna yachaynin"
  ["traffic_info"]="Ruwanakuna pukllaynin"
)

# Función para mostrar mensajes según el idioma
function translate() {
  local key=$1
  case $LANGUAGE in
    es) echo -e "${MESSAGES_ES[$key]}" ;;
    en) echo -e "${MESSAGES_EN[$key]}" ;;
    qu) echo -e "${MESSAGES_QU[$key]}" ;;
  esac
}

# Función para cambiar el idioma
function cambiar_idioma() {
  echo -e "${CYAN}Selecciona un idioma:${RESET}"
  echo -e "1) Español"
  echo -e "2) Inglés"
  echo -e "3) Quechua"
  read -p "Opción: " lang_option
  case $lang_option in
    1) LANGUAGE="es" ;;
    2) LANGUAGE="en" ;;
    3) LANGUAGE="qu" ;;
    *) echo "Opción inválida. Se mantiene el idioma actual." ;;
  esac
  translate "language_changed"
  sleep 1
}

# Título y encabezado
function print_header() {
    clear
    echo -e "${RED}==========================================${RESET}"
    echo -e "${CYAN}${BOLD}         MULTIPORT WEBSOCKET PANEL         ${RESET}"
    echo -e "${RED}==========================================${RESET}"
    translate "welcome"
}

# Información del servidor
function info_server() {
    echo -e "${RED}INFO SERVER:${RESET}"
    echo -e "${CYAN}System Uptime  : ${RESET}$(uptime -p)"
    echo -e "${CYAN}Memory Usage   : ${RESET}$(free -h | awk '/Mem/ {print $3" / "$2}')"
    echo -e "${CYAN}VPN Core       : ${GREEN}XRAY-CORE${RESET}"
    echo -e "${CYAN}Domain         : ${RESET}example.com"
    echo -e "${CYAN}IP VPS         : ${RESET}$(curl -s ifconfig.me)"
    echo -e "${RED}------------------------------------------${RESET}"
}

# Tráfico del servidor
function traffic_server() {
    echo -e "${RED}TRAFFIC:${RESET}"
    echo -e "${CYAN}Today          : ${RESET}5.34 GB"
    echo -e "${CYAN}Yesterday      : ${RESET}4.12 GB"
    echo -e "${CYAN}Month          : ${RESET}123.45 GB"
    echo -e "${RED}------------------------------------------${RESET}"
}

# Menú principal
function menu_principal() {
    while true; do
        print_header
        echo -e "${YELLOW}[1]${RESET} Ver Información del Servidor"
        echo -e "${YELLOW}[2]${RESET} Ver Tráfico del Servidor"
        echo -e "${YELLOW}[3]${RESET} Cambiar Idioma"
        echo -e "${YELLOW}[4]${RESET} Salir"
        read -p "$(translate 'select_option'): " option

        case $option in
            1) info_server ;;
            2) traffic_server ;;
            3) cambiar_idioma ;;
            4) echo "Saliendo..."; exit 0 ;;
            *) echo -e "${RED}Opción inválida.${RESET}"; sleep 1 ;;
        esac
    done
}

# Ejecución del script
menu_principal
