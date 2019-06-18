#! /bin/bash

function usage(){
	echo "Usage:"
	echo "init - "
	echo "ping_host <appserver> - "
	exit 1
}

function init(){
	pip install -r requirements.txt
	ansible --version
}

function ping_host(){
	ansible $1 -i ./inventory -m ping
}
case $1 in
	init)
	init
	;;
	ping_host)
	if [ -z $2 ]
	then
		usage
	fi
	ping_host $2
	;;
	*)
	usage
	;;
esac

