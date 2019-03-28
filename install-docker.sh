#!/usr/bin/env bash

VERSION=$(cat /etc/issue | cut -f1 -d' ')
INSTALL="install-docker-${VERSION,,}.sh"
wget  -O- "https://gist.githubusercontent.com/jmurowaniecki/3f7bcf1b3d723343d63d621e8590c3f6/raw/${INSTALL}?$(date)" \
    -q > "${INSTALL}" && \
chmod +x "${INSTALL}" && \
       ./"${INSTALL}" && \
  rm -Rf "${INSTALL}"
