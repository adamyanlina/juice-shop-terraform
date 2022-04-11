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
  default = "tidy-etching-334517"
}

variable "bucket" {
  type = string
  description = "The name of Google Storage Bucket to create"
  default = "test_bucket-1122f"
}