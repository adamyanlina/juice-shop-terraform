terraform {
  required_version = "~> 1.1.4"
}


provider "google" {
  project = local.project_id
  region = var.region
  zone = var.zone
}