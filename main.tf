###### PROVIDER BLOCK ########## 


provider "google" {
  version     = "3.0.0"
  project     = "terraform-basics-365011"
  credentials = file("terraform-basics-Vm_1.json")
  region      = var.gcp_region
}

#### Data Block #########

data "google_compute_zones" "zoneavailable" {
}

##### RESOURCE BLOCK ########## 




resource "google_compute_subnetwork" "VPC_subnetwork" {

  name          = var.gcp_vpc_subnetwork
  depends_on    = [google_compute_network.VPC_network]
  ip_cidr_range = "10.2.0.0/27"
  region        = var.gcp_region
  network       = google_compute_network.VPC_network.name


}

resource "google_compute_network" "VPC_network" {
  name                    = var.gcp_vpc_network
  auto_create_subnetworks = false
  // if it is set as true then subnetworks would be created for all regions.
}

resource "google_compute_firewall" "ssh-rule" {
  name = "demo-ssh"
  depends_on = [
    google_compute_network.VPC_network
  ]
  network = google_compute_network.VPC_network.name
  allow {
    protocol = "tcp"
    ports    = ["22"]
  }
  target_tags   = [var.gcp_vpc_targettags]
  source_ranges = ["0.0.0.0/0"]
}

resource "google_compute_firewall" "http-rule" {
  name = "demo-http"
  depends_on = [
    google_compute_network.VPC_network
  ]
  network = google_compute_network.VPC_network.name
  allow {
    protocol = "tcp"
    ports    = ["80","90"]
  }
  target_tags   = [var.gcp_vpc_targettags]
  source_ranges = ["0.0.0.0/0"]
}




