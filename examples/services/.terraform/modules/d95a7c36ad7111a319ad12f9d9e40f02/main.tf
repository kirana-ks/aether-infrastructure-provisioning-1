
# Dashboard
module "dashboard" {
  source = "../kubernetes-dashboard"
}

module "external-dns" {
  source = "../external-dns-aws"
  domain = "${var.domain}"
  cluster_name = "${var.cluster_name}"
}

# Nginx ingress controller
module "nginx" {
  source = "../nginx-ingress-controller"
}

module "cert-manager" {
  source = "../cert-manager"
  domain = "${var.domain}"
}
