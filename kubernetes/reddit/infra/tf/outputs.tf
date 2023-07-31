output "external_ip_address_master" {
  description = "External IP for master node"
  value       = yandex_compute_instance.master.network_interface.0.nat_ip_address
}
output "external_ip_address_worker" {
  description = "External IP for worker node"
  value       = yandex_compute_instance.worker.network_interface.0.nat_ip_address
}
