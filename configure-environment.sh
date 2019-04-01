#!/usr/bin/env bash

ssh-keygen -t rsa -P "" \
  -b 4096 -C "${EMAIL}" \
  -f    ~/.ssh/id_rsa
eval    "$(ssh-agent -s)"
ssh-add ~/.ssh/id_rsa
cat     ~/.ssh/id_rsa.pub

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
