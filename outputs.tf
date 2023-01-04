/*
output "Internal_ip_VM1" {
  value = google_compute_instance.vm_instance1.network_interface.0.network_ip
}


output "external_ip_VM1" {
  value = google_compute_instance.vm_instance1.network_interface.0.access_config.0.nat_ip

}

output "Internal_ip_VM2" {
  value = google_compute_instance.vm_instance2.network_interface.0.network_ip
}


output "external_ip_VM2" {
  value = google_compute_instance.vm_instance2.network_interface.0.access_config.0.nat_ip

}

*/