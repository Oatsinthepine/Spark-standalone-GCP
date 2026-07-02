resource "google_compute_instance" "bootstrap_test" {
  name         = "spark-bootstrap-test"
  machine_type = var.machine_type
  zone         = var.zone

  tags = ["spark-node", "spark-master"]

  boot_disk {
    initialize_params {
      image = var.image
      size  = var.boot_disk_size
      type  = "pd-balanced"
    }
  }

  network_interface {
    subnetwork = google_compute_subnetwork.spark_subnet.id
    access_config { network_tier = "PREMIUM" }
  }

  metadata = { enable-oslogin = "TRUE", user-data = file("${path.module}/cloud-init/common.yaml") }

  labels = {
    project     = var.project_id
    environment = "learning"
    role        = "spark-bootstrap-test"
  }
}
