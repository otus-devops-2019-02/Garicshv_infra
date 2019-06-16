# Правило firewall для доступа по ssh
resource "google_compute_firewall" "firewall_ssh" {
        name = "allow-ssh"
        network = "default"
        allow {
                protocol = "tcp"
                ports 	 = ["22"]
        }
	
	# правило применяется к ресурсам с задаваемым нами тегом
        target_tags = ["reddit-app","reddit-db"]
	source_ranges = "${var.source_ranges}"
}

resource "google_compute_firewall" "firewall_puma" {
        name = "allow-puma-default"
        network = "default"
        allow {
                protocol = "tcp"
		ports	 = ["9292"]
        }
        source_ranges 	 = ["0.0.0.0/0"]
        target_tags 	 = ["reddit-app"]
}

# Правило firewall
resource "google_compute_firewall" "firewall_mongo" {
        name = "allow-mongo-default"
        network = "default"
        allow {
                protocol = "tcp"
                ports 	 = ["27017"]
        }
        target_tags 	 = ["reddit-db"]
        source_tags 	 = ["reddit-app"]
}

resource "google_compute_project_metadata" "ssh_keys" {
  metadata {
    ssh-keys = "appuser1:${file(var.public_key_path)}\nappuser2:${file(var.public_key_path)}"
  }
}



