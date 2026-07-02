variable "project_id" {
  description = "GCP project id"
  type        = string
  default     = "jacky-workspace"
}

variable "region" {
  description = "GCP instance region"
  type        = string
  default     = "us-central1"
}

variable "zone" {
  description = "GCP instance zone"
  type        = string
  default     = "us-central1-a"
}

variable "network_name" {
  description = "network name for spark VPC"
  type        = string
  default     = "spark-vpc"
}

variable "subnet_cidr" {
  description = "subnet CIDR for spark VPC"
  type        = string
  default     = "10.10.0.0/24"
}
variable "machine_type" {
  description = "GCP instance machine type for spark nodes"
  type        = string
  default     = "e2-medium"
}

variable "image" {
  description = "GCP instances (VM) image using terraform for spark."
  type        = string
  default     = "ubuntu-os-cloud/ubuntu-2404-lts-amd64"
}

variable "boot_disk_size" {
  description = "GCP instance boot disk size in GB"
  type        = number
  default     = 30
}
