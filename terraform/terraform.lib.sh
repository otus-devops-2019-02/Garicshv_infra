#! /bin/bash

function init(){
	# Downloading providers
	terraform init
}

function plan(){
	# Check planned changes (before applying them)
	terraform plan
}

function apply(){
	# Apply changes and start VM
	terraform apply -auto-approve=true
}

function get_ip(){
	# get ip address
	cat terraform.tfstate | egrep "nat_ip|network_ip"
}

function refresh(){
	# Update the state file of your infrastructure with metadata that matches the physical resources they are tracking
	terraform refresh
}

function output(){
	# Values of output variables
	terraform output
}

function project_info(){
	gcloud compute project-info describe
}

function taint(){
	terraform taint google_compute_instance.$1
}
#terraform taint google_compute_instance.app

function destroy(){
	# Delete all created resources
	terraform destroy
}

function format(){
	terraform fmt
}

function get(){
	# Загрузить модули из источника (локальная файловая система)
	terraform get
}


