

output "bastion_subnet_id" {
  description = "subnet id for battion intance."
  value       = aws_subnet.bastion-subnet.id
}

output "baston_sg_id" {
  description = "security group for bastion instance."
  value       = aws_security_group.bastion-sg.id
}


output "cluster_node_subnet_id" {
  description = "subnet id for cluster node instance."
  value       = aws_subnet.cluster-node-subnet.id
}

output "cluster_node_sg_id" {
  description = "security group for k8s cluster instance."
  value       = aws_security_group.cluster-node-sg.id
}


