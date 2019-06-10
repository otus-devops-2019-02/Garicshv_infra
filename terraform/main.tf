terraform {
  # Версия terraform
  required_version = "0.11.11"
}

provider "google" {
	  # Версия провайдера
	  version = "2.0.0"
	
	  # ID проекта
	  project = "${var.project}"
	  region  = "${var.region}"
}

resource "google_compute_project_metadata" "ssh_keys" {
  metadata {
    ssh-keys = "appuser1:${file(var.public_key_path)}\nappuser2:${file(var.public_key_path)}"
  }
}

resource "google_compute_instance" "app" {
  #count = "${var.node_count}"
  #name         = "reddit-app-${var.node_count}"
  name         = "reddit-app"
  machine_type = "g1-small"

  #zone = "europe-west1-b"
  zone = "${var.zone}"
  tags = ["reddit-app"]

  # определение загрузочного диска
  boot_disk {
    initialize_params {
      # image = "reddit-base-1559710950"
      image = "${var.disk_image}"
    }
  }

  # определение сетевого интерфейса
  network_interface {
    # сеть, к которой присоединить данный интерфейс
    network = "default"

    # использовать ephemeral IP для доступа из Интернет
    access_config {}
  }

  metadata {
    # путь до публичного ключа
    #ssh-keys = "appuser:${file("/home/appuser/.ssh/id_rsa.pub")}" 
    ssh-keys = "appuser:${file("${var.public_key_path}")}"
  }

  # определение параметров подключения провижионеров к VM
  connection {
    type  = "ssh"
    user  = "appuser"
    agent = false

    # путь до приватного ключа
    #private_key = "${file("~/.ssh/id_rsa.insecure")}"
    private_key = "${file("${var.private_key_path}")}"
  }

  # копируем файл сервиса
  provisioner "file" {
    source      = "files/puma.service"
    destination = "/tmp/puma.service"
  }

  # запускаем выполнение скрипта деплоя сразу после предыдущего провижионера
  provisioner "remote-exec" {
    script = "files/deploy.sh"
  }
}

resource "google_compute_firewall" "firewall_puma" {
  name = "allow-puma-default"

  # Название сети, в которой действует правило
  network = "default"

  # Какой доступ разрешить
  allow {
    protocol = "tcp"
    ports    = ["9292"]
  }

  # Каким адресам разрешаем доступ
  source_ranges = ["0.0.0.0/0"]

  # Правило применимо для инстансов с перечисленными тэгами
  target_tags = ["reddit-app"]
}


resource "google_compute_instance" "app2" {
  #count = "${var.node_count}"
  #name         = "reddit-app-${var.node_count}"
  name         = "reddit-app2"
  machine_type = "g1-small"

  #zone = "europe-west1-b"
  zone = "${var.zone}"
  tags = ["reddit-app"]

  # определение загрузочного диска
  boot_disk {
    initialize_params {
      # image = "reddit-base-1559710950"
      image = "${var.disk_image}"
    }
  }

  # определение сетевого интерфейса
  network_interface {
    # сеть, к которой присоединить данный интерфейс
    network = "default"

    # использовать ephemeral IP для доступа из Интернет
    access_config {}
  }

  metadata {
    # путь до публичного ключа
    #ssh-keys = "appuser:${file("/home/appuser/.ssh/id_rsa.pub")}"
    ssh-keys = "appuser:${file("${var.public_key_path}")}"
  }

  # определение параметров подключения провижионеров к VM
  connection {
    type  = "ssh"
    user  = "appuser"
    agent = false

    # путь до приватного ключа
 #private_key = "${file("~/.ssh/id_rsa.insecure")}"
    private_key = "${file("${var.private_key_path}")}"
  }

  # копируем файл сервиса
  provisioner "file" {
    source      = "files/puma.service"
    destination = "/tmp/puma.service"
  }

  # запускаем выполнение скрипта деплоя сразу после предыдущего провижионера
  provisioner "remote-exec" {
    script = "files/deploy.sh"
  }
}

