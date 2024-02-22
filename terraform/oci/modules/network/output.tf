

output "mng_subnet_id" {
  value       = oci_core_subnet.mng_subnet.id
  description = "Subnet id for mangement instances."
}

output "k8s_cluster_subnet_id" {
  value       = oci_core_subnet.k8s_cluster_node_subnet.id
  description = "Subnet id for kubernetes cluster instances."
}
