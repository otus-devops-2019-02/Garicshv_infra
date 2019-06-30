#! /bin/sh
packer validate -var-file packer/variables.json packer/app.js && \
packer build -var-file packer/variables.json packer/app.js

packer validate -var-file packer/variables.json packer/db.js && \
packer build -var-file packer/variables.json packer/db.js

