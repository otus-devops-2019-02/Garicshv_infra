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
	echo "$0 ssh_db"
	echo "$0 ssh_app"
	echo "$0 check_ansible_syntax"
        echo "$0 encrypt_credentials [prod|stage]"
	echo "$0 decrypt_credentials [prod|stage]"
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

function encrypt_credentials(){
	encryption_path=environments/$1/credentials.yml
	echo "Encripting credentilas path [$encryption_path]"
	ansible-vault encrypt $encryption_path
}

function decrypt_credentials(){
	dencryption_path=environments/$1/credentials.yml
	echo "Decripting credentilas path [$dencryption_path]"
        ansible-vault decrypt $dencryption_path

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

	ssh_app)
	ssh 35.246.76.254
	#ssh 35.246.76.254
	;;

	ssh_db)
	ssh 35.197.203.47
	#ssh 35.246.5.237
	;;
	check_ansible_syntax)
	check_ansible_syntax
	;;
	
	init_galaxy)
	ansible-galaxy init app && \
	ansible-galaxy init db
	;;

	encrypt_credentials)
	if [ "$2" != "prod" ] && [ "$2" != "stage" ]
	then
		usage
	fi
	encrypt_credentials $2
	;;
	
	decrypt_credentials)
	if [ "$2" != "prod" ] && [ "$2" != "stage" ]
        then
                usage
        fi

	decrypt_credentials $2
	*)
	usage
	;;
esac

# ansible-galaxy install -r environments/stage/requirements.yml
# ansible-vault edit <file>

