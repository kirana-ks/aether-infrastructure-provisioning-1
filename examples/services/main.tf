resource "kubernetes_namespace" "namespace" {
  metadata {
    annotations {
      name = "${var.namespace}"
    }
    name = "${var.namespace}"
  }
}

# Helm modules
module "system_modules" {
  source = "../../modules/helm/system-modules"
  google_project = "${var.google_project}"
  google_zone = "${var.google_zone}"
  cluster_name = "${var.cluster_name}"
  domain = "${var.domain}"
}

# Secrets
module "postgres_secrets" {
  source = "../../modules/secrets"
  namespace = "${var.namespace}"
  postgres_root_username = "${var.postgres_root_username}"
  postgres_root_password = "${var.postgres_root_password}"
  service_account_private_key = "${var.service_account_private_key}"
  bucket_credentials = "${var.bucket_credentials}"
}

# Aether
module "aether_kernel" {
  source = "../../modules/helm/service"
  chart_name = "${var.kernel_chart_name}"
  chart_version = "${var.kernel_chart_version}"
  namespace = "${var.namespace}"
  project = "${var.project}"
  domain = "${var.domain}"
  dns_provider = "${var.dns_provider}"
  database_instance_name = "${var.database_instance_name}"
  gcs_bucket_name = "aether-kernel-example"
  gcs_bucket_credentials = "${var.namespace}-bucket-credentials"
}

module "aether_odk" {
  source = "../../modules/helm/service"
  chart_name = "${var.odk_chart_name}"
  chart_version = "${var.odk_chart_version}"
  namespace = "${var.namespace}"
  project = "${var.project}"
  domain = "${var.domain}"
  dns_provider = "${var.dns_provider}"
  database_instance_name = "${var.database_instance_name}"
  gcs_bucket_name = "aether-kernel-example"
  gcs_bucket_credentials = "${var.namespace}-bucket-credentials"
}

module "gather" {
  source = "../../modules/helm/service"
  chart_name = "${var.gather_chart_name}"
  chart_version = "${var.gather_chart_version}"
  namespace = "${var.namespace}"
  project = "${var.project}"
  domain = "${var.domain}"
  dns_provider = "${var.dns_provider}"
  database_instance_name = "${var.database_instance_name}"
}
