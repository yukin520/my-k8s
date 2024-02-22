

module "network" {
  source           = "./modules/network"
  compartment_ocid = var.compartment_ocid
  oci_region       = var.oci_region
}

module "compute" {
  source                = "./modules/compute"
  compartment_ocid      = var.compartment_ocid
  oci_region            = var.oci_region
  ssh_public_key_path   = var.ssh_public_key_path
  mng_subnet_id         = module.network.mng_subnet_id
  k8s_cluster_subnet_id = module.network.k8s_cluster_subnet_id
}
