resource "google_compute_network" "vpc" {
  project                 = var.project
  name                    = "vpc"
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "mgmt_subnet" {
  region                   = var.region
  project                  = var.project
  name                     = "mgmt-subnet"
  ip_cidr_range            = "10.127.0.0/20"
  network                  = google_compute_network.vpc.self_link
  private_ip_google_access = true
}

resource "google_compute_subnetwork" "app_subnet" {
  region                   = var.region
  project                  = var.project
  name                     = "app-subnet"
  ip_cidr_range            = "10.70.24.0/24"
  network                  = google_compute_network.vpc.self_link
}