#!/bin/bash
echo "Installation des pré-requis docker..."
apt-get update && sudo apt-get -y install apt-transport-https python3-pip ca-certificates curl software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -
add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
apt-get update
echo "Installation de docker-ce..."
apt-get install docker-ce
echo "Installation docker-compose..."
pip3 install docker-compose
echo "Création de l'utilisateur docker..."
useradd -m dockeruser
passwd dockeruser
usermod -aG dockeruser sudo docker
cd /home/dockeruser
su dockeruser
echo "Création du certificat SSL..."
mkdir -p ssl
openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout ssl/nginx.key -out ssl/nginx.crt
echo "Creation du conteneur..."
sudo docker run -p 6081:443 -e HTTP_PASSWORD=YourPassword2019 -e SSL_PORT=443 -v ${PWD}/ssl:/etc/nginx/ssl dorowu/ubuntu-desktop-lxde-vnc
