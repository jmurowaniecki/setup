#!/usr/bin/env bash

DISTRO=$(cat /etc/issue | cut -f1 -d' ')
COMMON="install-common-${DISTRO,,}.sh"
DOCKER="install-docker-${DISTRO,,}.sh"
CUSTOM="install-custom-${DISTRO,,}.sh"
CONFIG="configurations-${DISTRO,,}.sh"

for VAR in COMMON DOCKER CUSTOM CONFIG
do wget -O- "https://gist.githubusercontent.com/jmurowaniecki/3f7bcf1b3d723343d63d621e8590c3f6/raw/${$VAR}?$(date)" \
        -q > "${$VAR}" && \
    chmod +x "${$VAR}" && \
           ./"${$VAR}" && \
      rm -Rf "${$VAR}"
done
