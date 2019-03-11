resource "google_dns_managed_zone" "prod" {
  name     = "prod-zone"
  dns_name = "aether-axxonet.com."
}

resource "helm_release" "external-dns" {
  name      = "external-dns"
  chart     = "stable/external-dns"
  namespace = "kube-system"
  version   = "1.3.3"
  keyring   = ""
  values    = [
    #"${data.template_file.values.rendered}"
  ]
}

resource "kubernetes_secret" "secret" {
  metadata {
    name = "basic-auth"
	namespace = "kube-system"
  }

  data {
    username = "admin"
    password = "postgres"
  }

  type = "kubernetes.io/basic-auth"
}
