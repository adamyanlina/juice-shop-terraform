resource "google_compute_instance" "juice_shop" {
  count = 2
  name = "juice-shop"
  zone = "asia-east2"
  machine_type = "f1-micro"

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-9"
    }
  }

  network_interface {
    network = "vpc"
  }

  // Apply the firewall rule to allow external IPs to access this instance
  tags = ["https-server"]
}

module "iap_bastion" {
  source = "terraform-google-modules/bastion-host/google"

  project = var.project
  zone = var.zone
  network = google_compute_network.network.id
  subnet = "mgmt-subnet"
  members = [
    "adamyanlina97@gmail.com",
  ]
}

resource "google_compute_network" "network" {
  project                 = var.project
  name                    = "vpc"
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "mgmt_subnet" {
  project                  = var.project
  region                   = "asia-east1"
  name                     = "mgmt-subnet"
  ip_cidr_range            = "10.127.0.0/20"
  network                  = google_compute_network.network.self_link
  private_ip_google_access = true
}

resource "google_compute_subnetwork" "app_subnet" {
  project                  = var.project
  region                   = "asia-east2"
  name                     = "app-subnet"
  ip_cidr_range            = "10.70.24.0/24"
  network                  = google_compute_network.network.self_link
}

resource "google_compute_firewall" "allow_access_from_bastion" {
  project = var.project
  name    = "allow-bastion-ssh"
  network = google_compute_network.network.self_link

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  # Allow SSH only from IAP Bastion
  source_service_accounts = [module.iap_bastion.service_account]
}

resource "google_compute_firewall" "https-server" {
  name    = "default-allow-https"
  network = google_compute_network.network.self_link

  allow {
    protocol = "tcp"
    ports    = ["443"]
  }

  // Allow traffic from everywhere to instances with an https-server tag
  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["https-server"]
}