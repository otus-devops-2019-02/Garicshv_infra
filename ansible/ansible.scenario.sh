#! /bin/bash
source ansible.lib.sh

function usage(){
	echo "Usage:"
	echo "$0 init - "
	echo "$0 ping_host <appserver> - "
	echo "$0 command <ansible-server or group> <your-command in quotas>"
	echo "$0 store_ssh_password path-to-private-file"
	exit 1
}

case $1 in
	init)
	init
	;;
	ping_host)
	if [ -z "$2" ]
	then
		usage
	fi
	ping_host $2
	;;
	command)
	if [ -z "$2" ] || [ -z "$3" ]
        then
                usage
        fi
	command $2 "$3"
	;;
	store_ssh_password)
	store_ssh_password ~/.ssh/appuser
	;;
	*)
	usage
	;;
esac

