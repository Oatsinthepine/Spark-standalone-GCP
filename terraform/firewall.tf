resource "google_compute_firewall" "allow_internal" {
  name    = "spark-allow-internal"
  network = google_compute_network.spark_vpc.name

  direction     = "INGRESS"
  source_ranges = [var.subnet_cidr]

  allow {
    protocol = "tcp"
  }
  allow {
    protocol = "udp"
  }
  allow {
    protocol = "icmp"
  }
}


resource "google_compute_firewall" "allow_ssh" {
  name    = "spark-allow-ssh"
  network = google_compute_network.spark_vpc.name

  direction     = "INGRESS"
  source_ranges = ["0.0.0.0/0"]

  target_tags = ["spark-node"]

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }
}

resource "google_compute_firewall" "allow_spark_ui" {
  name    = "spark-allow-ui"
  network = google_compute_network.spark_vpc.name

  direction     = "INGRESS"
  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["spark-master"]
  allow {
    protocol = "tcp"
    ports    = ["8080", "4040", "18080"]
  }
}