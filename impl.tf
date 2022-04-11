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
  region                   = var.region
  project                  = var.project
  name                     = "mgmt-subnet"
  ip_cidr_range            = "10.127.0.0/20"
  network                  = google_compute_network.network.self_link
  private_ip_google_access = true
}

resource "google_compute_subnetwork" "app_subnet" {
  region                   = var.region
  project                  = var.project
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