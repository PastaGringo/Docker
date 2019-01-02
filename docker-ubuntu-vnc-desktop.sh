#!/bin/bash
echo "Création du certificat SSL..."
mkdir -p ssl
openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout ssl/nginx.key -out ssl/nginx.crt
echo "Creation du conteneur..."
docker run -p 6081:443 -e HTTP_PASSWORD=YourPassword2019 -e SSL_PORT=443 -v ${PWD}/ssl:/etc/nginx/ssl dorowu/ubuntu-desktop-lxde-vnc
