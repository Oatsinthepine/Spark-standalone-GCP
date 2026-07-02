resource "google_compute_network" "spark_vpc" {
  name                    = var.network_name
  auto_create_subnetworks = false
  routing_mode            = "REGIONAL"
}

// 这里不使用默认 VPC。我们显式创建：
# spark-vpc
#   └── spark-subnet
#     └── 10.10.0.0/24

resource "google_compute_subnetwork" "spark_subnet" {
  name          = "spark-subnet"
  region        = var.region
  network       = google_compute_network.spark_vpc.id
  ip_cidr_range = var.subnet_cidr
  // private_ip_google_access = true 可以让没有公网 IP 的 VM 通过内部路径访问部分 Google API；
  // 不过我们的第一版仍会暂时给三台 VM 配置 ephemeral external IP，方便 SSH 和下载依赖。
  private_ip_google_access = true
}