#Google GKE Cluster and Node Pool
module "gke_cluster" {
  source = "../modules/gke_cluster"
  google_zone = "${var.google_zone}"
  google_region = "${var.google_region}"
  google_project = "${var.google_project}"
  cluster_name = "${var.cluster}"
  initial_node_count = "${var.initial_node_count}"
  additional_zones = "${var.additional_google_zone}"
  admin_user = "${var.admin_user}"
  admin_password = "${var.admin_password}"
}

module "gke_node_pool" {
  source = "../modules/gke_node_pool"
  cluster_name = "${module.gke_cluster.cluster_name}"
  google_zone = "${var.google_zone}"
  pool_name = "${var.pool_name}"
  node_count = "${var.node_count}"
  cluster_node_type = "${var.cluster_node_type}"
  google_project = "${var.google_project}"
  cluster_node_disk_size = "${var.cluster_node_disk_size}"
  node_pool_role = "${var.node_pool_role}"
}

module "postgres" {
  source = "../modules/postgres"
  google_project = "${var.google_project}"
  google_region = "${var.google_region}"
  postgres_root_password = "${var.postgres_root_password}"
  database_instance_name = "${var.google_project}"
  databases = ["${var.project}_odk","${var.project}_gather","${var.project}_kernel"]
  namespace = "${var.project}"
}

# Bucket storage
module "aether_odk_storage" {
  source = "../modules/gcs_bucket"
  gcs_bucket_name = "aether-odk"
  gcs_bucket_credentials = "${var.namespace}-bucket-credentials"
  namespace = "${var.namespace}"
}

module "aether_kernel_storage" {
  source = "../modules/gcs_bucket"
  gcs_bucket_name = "aether-kernel"
  gcs_bucket_credentials = "${var.namespace}-bucket-credentials"
  namespace = "${var.namespace}"
}

# DNS IAM auth
module "iam-dns-aws" {
  source = "../modules/iam-dns-aws"
  cluster_name = "${var.namespace}"
  domain = "${var.domain}"
}
