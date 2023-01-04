

# forwarding rule
resource "google_compute_forwarding_rule" "google_compute_forwarding_rule" {
  name                  = "l4-ilb-forwarding-rule"
  backend_service       = google_compute_region_backend_service.ins_backend.id
  provider              = google
  region                = var.gcp_region
  ip_protocol           = "TCP"
  load_balancing_scheme = "INTERNAL"
  all_ports             = true
  allow_global_access   = true
  network               = var.gcp_vpc_network
  subnetwork            = var.gcp_vpc_subnetwork
}

/*resource "google_compute_global_forwarding_rule" "tcploadbalancer" {
  name       = "tcp-loadbalancer"
  ip_address = "${google_compute_global_address.externalip.address}"
  port_range = "80"
  backend_service       = google_compute_region_backend_service.ins_backend.id
}
*/

# backend service
resource "google_compute_region_backend_service" "ins_backend" {
  name                  = "l4-ilb-backend-subnet"
  provider              = google
  region                = var.gcp_region
  protocol              = "TCP"
  load_balancing_scheme = "INTERNAL"
  health_checks         = [google_compute_region_health_check.hc.id]
  backend {
    group          = google_compute_region_instance_group_manager.mig.instance_group
    balancing_mode = "CONNECTION"
  }
}

# health check
resource "google_compute_region_health_check" "hc" {
  name     = "l4-ilb-hc"
  provider = google
  region   = var.gcp_region
  http_health_check {
    port = "80"
  }
}