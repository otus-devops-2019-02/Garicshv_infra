# Creation of a loadbalancer
# https://www.terraform.io/docs/providers/google/r/compute_forwarding_rule.html
resource "google_compute_forwarding_rule" "loadbalancer" {

  name       = "loadbalancer"
  target     = "${google_compute_target_pool.loadbalancer.self_link}"
  port_range = "9292"
}

resource "google_compute_target_pool" "loadbalancer" {
	name = "loadbalancer"
	instances = [
    		"europe-west1-b/reddit-app",
		 "europe-west1-b/reddit-app2",

  	]
	
  	health_checks = [
    		"${google_compute_http_health_check.default.name}",
  	]
}

resource "google_compute_http_health_check" "default" {
 	name               = "default"
#	request_path       = "/"
 	check_interval_sec = 1
	timeout_sec        = 1
	port = 9292
}


