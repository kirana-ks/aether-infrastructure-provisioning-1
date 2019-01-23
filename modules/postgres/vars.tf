variable "database_version" {
  default = "POSTGRES_9_6"
}

variable "database_size" {
  default = "30"
}

variable "postgres_password" {}

variable "db_instance_type" {
  description = "In the form of custom-CPUS-MEM, number of CPUs and memory for custom machine. https://cloud.google.com/compute/docs/instances/creating-instance-with-custom-machine-type#specifications"
  default     = "db-custom-2-3840"
}

variable "google_project" {}
variable "google_region" {}
