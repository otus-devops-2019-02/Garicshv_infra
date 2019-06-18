variable public_key_path {
  # Описание переменной
  description = "Path to the public key used for ssh access"
}

variable zone {
	# zone
  description = "Zone location"
  default = "europe-west22-b"
}

variable db_disk_image {
        description = "Disk image for reddit db"
        default = "ubuntu-1604-lts"
}

