resource "google_compute_instance" "node" {
  name         = "${var.name_prefix}-node"
  machine_type = "e2-medium" 
  zone         = var.zone

  tags = ["k8s-node"] 

  boot_disk {
    initialize_params {
      image = "ubuntu-os-cloud/ubuntu-2404-lts-amd64"
      size  = 30 
    }
  }

  network_interface {
    network    = google_compute_network.vpc.name
    subnetwork = google_compute_subnetwork.subnet.name
    

    access_config {}
  }
}