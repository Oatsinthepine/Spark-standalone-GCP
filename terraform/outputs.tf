
output "bootstrap_test_name" {
  description = "Name of the bootstrap test VM"
  value       = google_compute_instance.bootstrap_test.name
}

output "bootstrap_test_internal_ip" {
  description = "Internal IP of the bootstrap test VM"
  value       = google_compute_instance.bootstrap_test.network_interface[0].network_ip
}

output "bootstrap_test_external_ip" {
  description = "External IP of the bootstrap test VM"
  value       = google_compute_instance.bootstrap_test.network_interface[0].access_config[0].nat_ip
}