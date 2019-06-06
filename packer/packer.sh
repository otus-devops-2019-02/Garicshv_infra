#! /bin/sh
packer validate ./ubuntu16.json && \
sudo -E env "PATH=$PATH" packer build -var-file=variables.json ubuntu16.json

