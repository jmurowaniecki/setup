#!/usr/bin/env bash

DISTRO=$(cat /etc/issue | cut -f1 -d' ')
DOCKER="install-docker-${DISTRO,,}.sh"
CUSTOM="install-custom-${DISTRO,,}.sh"

for VAR in DOCKER CUSTOM
do wget -O- "https://gist.githubusercontent.com/jmurowaniecki/3f7bcf1b3d723343d63d621e8590c3f6/raw/${$VAR}?$(date)" \
        -q > "${$VAR}" && \
    chmod +x "${$VAR}" && \
           ./"${$VAR}" && \
      rm -Rf "${$VAR}"
done