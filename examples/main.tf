# Google GKE Cluster and Node Pool
module "gke_cluster" {
  source = "../modules/gke_cluster"
  google_zone = "${var.google_zone}"
  google_project = "${var.google_project}"
  cluster_name = "axxonet" # UPDATE ME
  initial_node_count = 1
  additional_zones = "${var.google_zone}-c"
  admin_user = "${var.admin_user}"
  admin_password = "${var.admin_password}" # UPDATE ME
}

module "gke_node_pool" {
  source = "../modules/gke_node_pool"
  cluster_name = "${module.gke_cluster.cluster_name}"
  google_zone = "${var.google_zone}"
  pool_name = "app-pool"
  node_count = 1
  cluster_node_type = "n1-standard-1"
  google_project = "${var.google_project}"
  cluster_node_disk_size = 20
  node_pool_role = "app"
}

module "postgres" {
  source = "../modules/postgres"
  google_project = "${var.google_project}"
  google_region = "${var.google_region}"
  postgres_password = "axxonet" # UPDATE ME
}

# Helm modules
module "system_modules" {
  source = "../modules/helm/system-modules"
  domain = "aether-axxonet.com" # UPDATE ME
  google_project = "${var.google_project}"
  google_zone = "${var.google_zone}"
  cluster_name = "${module.gke_cluster.cluster_name}"
  admin_user = "${var.admin_user}"
  admin_password = "${var.admin_password}" # UPDATE ME
}

# Aether
module "aether_kernel" {
  source = "../modules/helm/aether"
  chart_name = "aether-kernel"
  chart_version = "1.2.0"
  namespace = "axxonet" 
}

module "aether_odk" {
  source = "../modules/helm/aether"
  chart_name = "aether-odk"
  chart_version = "1.2.0"
  namespace = "axxonet" 
}

module "gather" {
  source = "../modules/helm/aether"
  chart_name = "gather"
  chart_version = "3.1.0"
  namespace = "axxonet" 
}

module "aether-ui" {
  source = "../modules/helm/aether"
  chart_name = "aether-ui"
  chart_version = "1.2.0"
  namespace = "axxonet" 
}

module "aether-producer" {
  source = "../modules/helm/aether"
  chart_name = "aether-producer"
  chart_version = "1.2.0"
  namespace = "axxonet" 
}