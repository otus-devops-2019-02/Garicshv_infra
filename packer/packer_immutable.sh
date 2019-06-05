#! /bin/sh
packer validate ./immutable.json && \
sudo -E env "PATH=$PATH" packer build immutable.json

