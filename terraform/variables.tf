variable project {
  description = "Project ID"
}

variable region {
  description = "Region"

  # Значение по умолчанию
  default = "europe-west2"
}

variable public_key_path {
  # Описание переменной
  description = "Path to the public key used for ssh access"
}

variable disk_image {
  description = "Disk image"
}

variable private_key_path {
  description = "The path of private key location"
}

variable zone {
	# zone
  description = "Zone location"
  default = "europe-west22-b"
}

variable node_count{
	description="The count of compute instances"
	default = "1"
}

variable app_disk_image {
	description = "Disk image for reddit app"
	default = "reddit-app-base"
}

