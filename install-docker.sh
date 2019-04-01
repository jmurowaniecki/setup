#!/usr/bin/env bash

VERSION=$(cat /etc/issue | cut -f1 -d' ')
INSTALL="install-docker-${VERSION,,}.sh"
[ ! -e   "${INSTALL}" ] && wget -O- "https://gist.githubusercontent.com/jmurowaniecki/3f7bcf1b3d723343d63d621e8590c3f6/raw/${INSTALL}?$(date)" \
    -q > "${INSTALL}" && \
chmod +x "${INSTALL}"
       ./"${INSTALL}"
# rm -Rf "${INSTALL}"

cat > ~/.docker/config.json <<< "{
    \"auths\": {
        \"https://index.docker.io/v1/\": {}
    },
    \"HttpHeaders\": {
        \"User-Agent\": \"Docker-Client/18.09.1 (linux)\"
    },
     \"credsStore\": \"pass\"
}
"

gpg-agent --daemon --use-standard-socket --pinentry-program /usr/bin/pinentry-curses
sudo rngd -r /dev/urandom
gpg2 --gen-key
pass init "Developer Doc.Space"
pass show docker-credential-helpers/docker-pass-initialized-check

VERSION=$(curl --silent https://api.github.com/repos/docker/compose/releases/latest | jq .name -r)
DESTINATION="/usr/local/bin/docker-compose"
curl -L "https://github.com/docker/compose/releases/download/${VERSION}/docker-compose-$(uname -s)-$(uname -m)" \
     -o  "$DESTINATION"
chmod +x "$DESTINATION"


for each in FILES=$(/curl -silent https://api.github.com/repos/docker/docker-credential-helpers/releases/latest
    | jq .assets[].browser_download_url
    | grep -E '\-(pass|secretservice)\-')
do
    wget
https://github.com/docker/docker-credential-helpers/releases/download/v0.6.0/docker-credential-pass-v0.6.0-amd64.tar.gz
