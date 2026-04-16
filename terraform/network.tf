resource "google_compute_network" "vpc" {
  name                    = "${var.name_prefix}-vpc"
  auto_create_subnetworks = false # Вимикаємо автоматичне створення підмереж
}

resource "google_compute_subnetwork" "subnet" {
  name          = "${var.name_prefix}-subnet"
  ip_cidr_range = "10.10.10.0/24"
  region        = var.region
  network       = google_compute_network.vpc.id
}

# Вхідні (inbound) підключення
resource "google_compute_firewall" "firewall_ingress" {
  name    = "${var.name_prefix}-firewall"
  network = google_compute_network.vpc.name

  allow {
    protocol = "tcp"
    ports    = ["22", "80", "443", "8000", "8001", "8002", "8003"]
  }

  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["k8s-node"]
}


resource "google_compute_firewall" "firewall_egress" {
  name      = "${var.name_prefix}-firewall-egress"
  network   = google_compute_network.vpc.name
  direction = "EGRESS"

  allow {
    protocol = "tcp"
    ports    = ["1-65535"]
  }
  allow {
    protocol = "udp"
    ports    = ["1-65535"]
  }

  destination_ranges = ["0.0.0.0/0"]
  target_tags        = ["k8s-node"]
}