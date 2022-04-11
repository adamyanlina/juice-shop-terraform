module "network" {
  source = "./modules/network"
}

module "iap_bastion" {
  source = "terraform-google-modules/bastion-host/google"

  project = var.project
  zone = var.zone
  network = module.network.id
  subnet = "mgmt-subnet"
  members = [
    "adamyanlina97@gmail.com",
  ]
}

resource "google_compute_firewall" "allow_access_from_bastion" {
  project = var.project
  name    = "allow-bastion-ssh"
  network = [module.network]

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  # Allow SSH only from IAP Bastion
  source_service_accounts = [module.iap_bastion.service_account]
}