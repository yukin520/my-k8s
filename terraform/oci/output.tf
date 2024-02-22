
output "client_node_public_ip" {
    description = "Public IP for client node"
    value = module.compute.client_node_public_ip
}

output "controle_plane_public_ip" {
    description = "Public IP for k8s cluster controle plane node 01."
    value = module.compute.controle_plane_public_ip
}

output "data_plane_01_public_ip" {
    description = "Public IP for k8s cluster data plane node 01."
    value = module.compute.data_plane_01_public_ip
}

output "data_plane_02_public_ip" {
    description = "Public IP for k8s cluster data plane node 02."
    value = module.compute.data_plane_02_public_ip
}
