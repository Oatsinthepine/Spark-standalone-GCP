locals {
  spark_nodes = {
    spark-master = {
      role        = "master"
      internal_ip = "10.10.0.10"
    }
    spark-worker-1 = {
      role        = "worker"
      internal_ip = "10.10.0.11"
    }
    spark-worker-2 = {
      role        = "worker"
      internal_ip = "10.10.0.12"
    }
  }

  spark_master_ip = local.spark_nodes["spark-master"].internal_ip
}

resource "google_compute_address" "spark_external_ip" {
  for_each = local.spark_nodes

  name   = "${each.key}-external-ip"
  region = var.region
}

resource "google_compute_instance" "spark_node" {
  for_each     = local.spark_nodes
  name         = each.key
  machine_type = var.machine_type
  zone         = var.zone

  //tags = ["spark-node", each.value.role]
  tags = compact(["spark-node", each.value.role == "master" ? "spark-master" : "spark-worker"])

  boot_disk {
    initialize_params {
      image = var.image
      size  = var.boot_disk_size
      type  = "pd-balanced"
    }
  }

  network_interface {
    subnetwork = google_compute_subnetwork.spark_subnet.id
    network_ip = each.value.internal_ip
    access_config {
      nat_ip       = google_compute_address.spark_external_ip[each.key].address
      network_tier = "PREMIUM"
    }
  }

  metadata = { enable-oslogin = "TRUE",
    user-data = file("${path.module}/cloud-init/common.yaml"),
    role      = each.value.role,
    master-ip = local.spark_master_ip
  }

  labels = {
    project     = "spark-standalone-lab"
    environment = "learning"
    role        = each.value.role
  }

  allow_stopping_for_update = true
}
