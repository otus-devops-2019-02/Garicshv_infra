terraform {
  # Версия terraform
  # required_version = "0.11.11"
}

provider "google" {
	  # Версия провайдера
	  #version = "2.0.0"
	   version ="1.19.1"
	  # ID проекта
	  project = "${var.project}"
	  region  = "${var.region}"
}

resource "google_compute_project_metadata" "ssh_keys" {
  metadata {
    ssh-keys = "appuser1:${file(var.public_key_path)}\nappuser2:${file(var.public_key_path)}"
  }
}
