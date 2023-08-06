output "external_v4_endpoint" {
    value = yandex_kubernetes_cluster.k8s-zonal.master[0].external_v4_endpoint
}

output "disk_id" {
  value = yandex_compute_disk.pv.id
}