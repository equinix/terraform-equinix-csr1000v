terraform {
  required_version = ">= 0.13"

  required_providers {
    equinix = {
      //source = "equinix/equinix"
      //version = ">= 1.1"
      source  = "developer.equinix.com/terraform/equinix"
      version = ">= 9.0.0"
    }
  }
}
