terraform {
  required_providers {
    oci = {
      source = "oracle/oci"
      version = "5.28.0"
    }
  }
}

provider "oci" {
  region = "ap-osaka-1"
}
