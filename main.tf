terraform {
  required_version = "~> 1.1.4"

  backend "gcs" {
    bucket = var.BUCKET
    prefix = "terraform/state"
  }
}

provider "google" {
  project = var.project
  region = var.region
  zone = var.zone
}