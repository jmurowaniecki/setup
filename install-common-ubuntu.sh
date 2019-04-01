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
    vim make nmap \
    net-utils git \
    pass

snap install atom   --classic
snap install vscode --classic
nap install postman

wget -q -O- https://github.com/docker/docker-credential-helpers/releases/download/v0.6.0/docker-credential-pass-v0.6.0-amd64.tar.gz \
    | tar -x                   &&                    mv docker-credential-pass  /usr/bin/docker-credential-pass
