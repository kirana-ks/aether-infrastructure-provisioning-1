variable "database_version" {
  default = "POSTGRES_9_6"
}

variable "database_size" {
  default = "10"
}

variable "db_instance_type" {
  description = "In the form of custom-CPUS-MEM, number of CPUs and memory for custom machine. https://cloud.google.com/compute/docs/instances/creating-instance-with-custom-machine-type#specifications"
  default = "db-custom-1-3840"
}

variable "google_project" {}
variable "google_region" {}
variable "database_instance_name" {}
variable "namespace" {}
variable "postgres_root_username" { default="postgres" }
variable "postgres_root_password" {}
variable "databases" { type="list" }
