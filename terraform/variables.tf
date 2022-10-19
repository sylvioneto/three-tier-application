data "google_project" "project" {}

locals {
  resource_labels = {
    terraform = "true"
    app       = var.application_name
    env       = "sandbox"
    repo      = "deploystack"
  }

  service_account = {
    email  = google_service_account.service_account.email
    scopes = ["https://www.googleapis.com/auth/cloud-platform"]
  }
}

variable "application_name" {
  description = "Application name"
}

variable "project_id" {
  description = "GCP Project ID"
}

variable "region" {
  type        = string
  description = "GCP region"
}

variable "subnet_cidr" {
  type        = string
  description = "Subnet CIDR"
  default     = "10.0.0.0/24"
}
