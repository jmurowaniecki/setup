#!/usr/bin/env bash

username="${1:-$USER}"
homepath="/home/$username/.docker"

mkdir -p "${homepath}"

if [ "$USER" != "root" ]
then
    if sudo $0 $username
    then
        if [[ ! -z ${DOCKER_USER} ]] \
        && [[ ! -z ${DOCKER_PASS} ]]
        then docker login        \
             -u "${DOCKER_USER}" \
             -p "${DOCKER_PASS}"
        fi
        bash -c "docker run hello_world" && \
        exit 0
    fi

    echo "Falhou em instalar e/ou configurar Docker." && \
        exit 1
fi

apt-get remove  -y docker docker-engine docker.io containerd runc
apt-get update  -y
apt-get install -y gnupg-agent \
    apt-transport-https     jq \
    ca-certificates       curl \
    software-properties-common

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -

add-apt-repository \
    "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
    $(lsb_release -cs) \
    stable"

apt-get update  -y && \
apt-get install -y    \
        docker-ce     \
        docker-ce-cli \
        docker-compose

groupadd    docker
usermod -aG docker     "$username"
chown   -R "$username":"$username" "$homepath"
chmod   -R          g+rwx          "$homepath"

systemctl enable  docker && \
systemctl restart docker.service

VERSION=$(curl --silent https://api.github.com/repos/docker/compose/releases/latest | jq .name -r)
DESTINATION="/usr/local/bin/docker-compose"
curl -L "https://github.com/docker/compose/releases/download/${VERSION}/docker-compose-$(uname -s)-$(uname -m)" \
     -o  "$DESTINATION"
chmod +x "$DESTINATION"

service docker restart    && \
        docker-compose -v && \
        docker -v
