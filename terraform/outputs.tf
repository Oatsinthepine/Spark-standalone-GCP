
output "spark_master_name" {
  description = "Name of the spark master node"
  value       = google_compute_instance.spark_node["spark-master"].name
}

output "spark_master_internal_ip" {
  description = "Internal IP of the spark master node"
  value       = google_compute_instance.spark_node["spark-master"].network_interface[0].network_ip
}

output "spark_master_external_ip" {
  description = "External IP of the spark master node"
  value       = google_compute_instance.spark_node["spark-master"].network_interface[0].access_config[0].nat_ip
}

output "spark_worker_names" {
  description = "Names of the spark worker nodes"
  value       = [for name, node in google_compute_instance.spark_node : node.name if node.metadata["role"] == "worker"]
}

output "spark_worker_internal_ips" {
  description = "Internal IPs of the Spark worker nodes"
  value       = [for name, node in google_compute_instance.spark_node : node.network_interface[0].network_ip if node.metadata["role"] == "worker"]
}

output "spark-worker_external_ips" {
  description = "External IPs of the Spark worker nodes"
  value = {
    spark-worker-1 = google_compute_instance.spark_node["spark-worker-1"].network_interface[0].access_config[0].nat_ip
    spark-worker-2 = google_compute_instance.spark_node["spark-worker-2"].network_interface[0].access_config[0].nat_ip
  }
}