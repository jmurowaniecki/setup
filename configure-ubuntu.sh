#!/usr/bin/env bash

for     each in ~/.ssh/id_rsa{,.pub}
do cp "$each" "~/.ssh/${each}_$(date +'%Y%m%d-%H%M%S-%s')"
done

ssh-keygen -t rsa -P "" \
  -b 4096 -C "${EMAIL}" \
  -f    ~/.ssh/id_rsa
eval    "$(ssh-agent -s)"
ssh-add ~/.ssh/id_rsa
cat     ~/.ssh/id_rsa.pub
