#! /bin/bash

function init(){
        pip install -r requirements.txt
        ansible --version
}

function ping_host(){
        ansible $1 -i ./inventory -m ping
	#ansible $1 -i ./inventory.yml -m ping
}

function command(){
        echo ansible $1 -m command -a "$2"
        ansible $1 -m command -a "$2"
}

function store_ssh_password(){
	echo "Storing password for key [$1] path"
	eval "$(ssh-agent -s)" && ssh-add $1
}

