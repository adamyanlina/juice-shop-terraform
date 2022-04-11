terraform {
  required_version = "~> 1.1.4"
}

provider "google" {
  project = var.project
  region = var.region
  zone = var.zone
}