variable "region" {
  type = string
  description = "Region"
  default = "asia-east1"
}

variable "zone" {
  type = string
  description = "Zone"
  default = "asia-east1-a"
}

variable "project" {
  type = string
  description = "Project name"
}

variable "bucket" {
  type = string
  description = "The name of Google Storage Bucket to create"
}