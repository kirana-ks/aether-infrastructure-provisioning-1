provider "kubernetes" {
  host     = "35.200.230.87"
  username = "admin"
  password = "sdfsdfsdff3354435xdsfddgf"

  client_certificate     = "${var.client_certificate}"
  client_key             = "${var.client_key}"
  cluster_ca_certificate = "${var.cluster_ca_certificate}"
  load_config_file       = false
}

provider "helm" {
  install_tiller = true
  service_account = "tiller"
  kubernetes {
    host     = "35.200.230.87"
    username = "admin"
    password = "sdfsdfsdff3354435xdsfddgf"

    client_certificate     = "${var.client_certificate}"
    client_key             = "${var.client_key}"
    cluster_ca_certificate = "${var.cluster_ca_certificate}"
  }
}

provider "google" {
  project = "aether-dev-233810"
  region  = "asia-south1"
  zone    = "asia-south1-a"
}
