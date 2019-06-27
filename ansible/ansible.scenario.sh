#! /bin/bash
source ansible.lib.sh

function usage(){
	echo "Usage:"
	echo "$0 init - "
	echo "$0 ping_host <appserver> - "
	echo "$0 command <ansible-server or group> <your-command in quotas>"
	echo "$0 store_ssh_password path-to-private-file"
	echo "$0 check_reddit_app"
	echo "$0 play_reddit_db"
	exit 1
}

function check_reddit_app(){
	ansible-playbook reddit_app.yml --check --limit app --tags app-tag
	#--limit - ограничиваем группу хостов, для которых применить плейбук
	#--check пробный прогон плейбука
}

function play_reddit_db(){
	ansible-playbook reddit_app.yml --limit app --tags app-tag 
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
	
	check)
	check_reddit_app
	;;
	
	play)
	play_reddit_db
	;;

	*)
	usage
	;;
esac

