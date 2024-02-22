

output "client_node_public_ip" {
    description = "Public IP for client node"
    value = oci_core_instance.client_instance.public_ip
}

output "controle_plane_public_ip" {
    description = "Public IP for k8s cluster controle plane node 01."
    value = oci_core_instance.cluster_controle_plane_01.public_ip
}

output "data_plane_01_public_ip" {
    description = "Public IP for k8s cluster data plane node 01."
    value = oci_core_instance.cluster_data_plane_01.public_ip
}

output "data_plane_02_public_ip" {
    description = "Public IP for k8s cluster data plane node 02."
    value = oci_core_instance.cluster_data_plane_02.public_ip
}

