provider "equinix" {
  client_id     = var.equinix_client_id
  client_secret = var.equinix_client_secret
}

module "csr1000v" {
  source               = "equinix/csr1000v/equinix"
  version              = "1.1.0"
  name                 = "tf-csr1000v"
  metro_code           = var.metro_code_primary
  platform             = "medium"
  software_package     = "IPBASE"
  term_length          = 1
  notifications        = ["test@test.com"]
  throughput           = 1
  throughput_unit      = "Gbps"
  hostname             = "csr-pri"
  additional_bandwidth = 50
  acl_template_id      = equinix_network_acl_template.csr1000v-pri.id
  secondary = {
    enabled              = true
    metro_code           = var.metro_code_secondary
    hostname             = "csr-sec"
    additional_bandwidth = 50
    acl_template_id      = equinix_network_acl_template.csr1000v-sec.id
  }
}

resource "equinix_network_ssh_user" "john" {
  username = "john"
  password = "qwerty123"
  device_ids = [
    module.csr1000v.id,
    module.csr1000v.secondary.id
  ]
}

resource "equinix_network_acl_template" "csr1000v-pri" {
  name        = "tf-csf1000v-pri"
  description = "Primary CSR1000V ACL template"
  metro_code  = var.metro_code_primary
  inbound_rule {
    subnets  = ["193.39.0.0/16", "12.16.103.0/24"]
    protocol = "TCP"
    src_port = "any"
    dst_port = "22"
  }
}

resource "equinix_network_acl_template" "csr1000v-sec" {
  name        = "tf-csf1000v-sec"
  description = "Secondary CSR1000V ACL template"
  metro_code  = var.metro_code_secondary
  inbound_rule {
    subnets  = ["193.39.0.0/16", "12.16.103.0/24"]
    protocol = "TCP"
    src_port = "any"
    dst_port = "22"
  }
}
