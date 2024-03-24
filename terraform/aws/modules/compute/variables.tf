
variable "bastion_subnet_id" {
  description = "subnet id for battion intance."
  type        = string
}

variable "baston_sg_id" {
  description = "security group for bastion instance."
  type        = string
}

variable "cluster_node_subnet_id" {
  description = "subnet id for cluster node instance."
  type        = string
}

variable "cluster_node_sg_id" {
  description = "security group for k8s cluster instance."
  type        = string
}

variable "ubuntu_arm_ami_name" {
  description = "the ami name of ubuntu arm instance."
  type        = string
  default     = "ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-arm64-server-*"
}

variable "ubuntu_x86_ami_name" {
  description = "the ami name of ubuntu amd instance."
  type        = string
  default     = "ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"
}

variable "ssh_public_key_path" {
  type        = string
  description = "SSH public key for remote access to deployed instances."
}
