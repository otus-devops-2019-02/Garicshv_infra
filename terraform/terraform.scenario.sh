#! /bin/bash
source terraform.lib.sh

function usage(){
	echo "Usage:"
	echo "init - "
	echo "plan - "
	echo "apply - "
	echo "get_ip - "
	echo "refresh - "
	echo "output - "
	echo "project_info - "
        echo "taint - "
        echo "destroy - "
        echo "restart1 - "
        echo "format - "	
        echo "get - " 
	exit 1
}
case $1 in
	init)
	echo "Downloading providers"
	init
	;;
	plan)
	echo "Check planned changes (before applying them)"
	plan
	;;
	apply)
	echo "Apply changes and start VM"
	apply
	echo "Get newly created ip address"
	get_ip
	;;
	get_ip)
	echo "Get ip address"
	get_ip
	;;
	refresh)
	echo "Refreshing of metadata"
	refresh
	;;
	output)
	echo "Values of output variables"
	output
	;;
	project_info)
	project_info
	;;
	taint)
	echo "Taint instance [$2]"
	taint $2
	;;
	restart1)
	taint app && plan && apply 
	;;
	destroy)
	echo "Delete all created resources"
	destroy
	;;
	format)
	echo "Formatting files ..."
	format
	;;
	get)
	echo "Loading local modules"
	get
	;;
	*)
	usage
	;;
esac
# Для решения данной проблемы:
# google_compute_instance.app: Failed to read key ...: password protected keys are
#not supported. Please decrypt the key prior to use.
# необходимо сделать следующее:
# openssl rsa -in ~/.ssh/_KEY_ -out ~/.ssh/_KEY_.insecure && chmod 0400 ~/.ssh/_KEY_.insecure




