

module "network" {
  source = "./modules/network"
}

module "compute" {
  source                 = "./modules/compute"
  bastion_subnet_id      = module.network.bastion_subnet_id
  baston_sg_id           = module.network.baston_sg_id
  cluster_node_subnet_id = module.network.cluster_node_subnet_id
  cluster_node_sg_id     = module.network.cluster_node_sg_id
  ssh_public_key_path    = var.ssh_public_key_path
}
