terraform {
  # Версия terraform  # required_version = "0.11.11"
}

provider "google" {
  version = "2.0.0"
  project = "${var.project}"
  region  = "${var.region}"
}

module "app" {
  source          = "../modules/app"
  public_key_path = "${var.public_key_path}"
  zone            = "${var.zone}"
  app_disk_image  = "${var.app_disk_image}"
}

module "db" {
  source          = "../modules/db"
  public_key_path = "${var.public_key_path}"
  zone            = "${var.zone}"
  db_disk_image   = "${var.db_disk_image}"
}

module "vpc" {
  source          = "../modules/vpc"
  public_key_path = "${var.public_key_path}"
  source_ranges   = ["${var.ssh_source_range}"]
}

#resource "google_compute_project_metadata" "ssh_keys" {
#  metadata {
#    ssh-keys = "appuser1:${file(var.public_key_path)}\nappuser2:${file(var.public_key_path)}"
#  }
#}

