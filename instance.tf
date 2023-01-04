#### Instance 1 #######

resource "google_compute_instance" "vm_instance1" {

  name         = var.gcp_CE_VM1
  machine_type = var.gcp_CE_Machine_Type
  tags         = ["terraform"]
  depends_on   = [google_compute_subnetwork.VPC_subnetwork]
  zone         = data.google_compute_zones.zoneavailable.names[0]

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11"
    }
  }

  network_interface {
    network    = var.gcp_vpc_network
    subnetwork = var.gcp_vpc_subnetwork

    access_config {
      // Ephemeral public IP
    }
  }

  metadata = {
    startup-script = file("${path.module}/startupscript.sh")
  }
}

/*######## Instance 2 #########

resource "google_compute_instance" "vm_instance2" {

  name         = var.gcp_CE_VM2
  machine_type = var.gcp_CE_Machine_Type
  tags         = ["terraform"]
  depends_on   = [google_compute_subnetwork.VPC_subnetwork]
  zone         = data.google_compute_zones.zoneavailable.names[1]


  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11"
    }
  }

  network_interface {
    network    = var.gcp_vpc_network
    subnetwork = var.gcp_vpc_subnetwork

    access_config {
      // Ephemeral public IP
    }
  }
  metadata = {
    startup-script = file("${path.module}/startupscript.sh")
  }
}*/

######### Instance template ########

resource "google_compute_instance_template" "terraform_demo_template" {
  name        = var.gcp_vm_instanceTemplate
  description = "This template is used to create Virtual server instances."

  labels = {
    environment = var.gcp_it_environment_label
  }

  instance_description = "description assigned to instances"
  machine_type         = var.gcp_CE_Machine_Type

  # in Instance tempalte we should use disk rather than bootdisk
  disk {
    source_image = "debian-cloud/debian-11"
  }

  network_interface {

    network    = var.gcp_vpc_network
    subnetwork = var.gcp_vpc_subnetwork

    access_config {
      // Ephemeral public IP
    }

  }
  # these tages are network tags.
  tags = [var.gcp_vpc_targettags]
  metadata = {
    startup-script = file("${path.module}/startupscript.sh")
  }
}

resource "google_compute_region_instance_group_manager" "mig" {
  name               = "terraform-mig"
  base_instance_name = "mig-instance"
  version {
    instance_template = google_compute_instance_template.terraform_demo_template.self_link
  }
  region             = var.gcp_region
  target_size        = 3
  wait_for_instances = true

  timeouts {
    create = "5m"
    update = "5m"
  }
}





