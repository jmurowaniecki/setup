#!/usr/bin/env bash

if [ "$USER" != "root" ]
then
    sudo $0 && \
    exit  0

    echo "Falhou em instalar e/ou configurar aplicativos." && \
    exit 1
fi

apt update  -y && \
apt upgrade -y && \
apt install -y    \
    curl opensshd \
    vim  git nmap

snap install atom   --classic
snap install vscode --classic
snap install postman