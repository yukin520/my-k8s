
data "aws_ami" "ubuntu_arm_ami" {
  most_recent = true
  owners      = ["amazon"]
  filter {
    name   = "architecture"
    values = ["arm64"]
  }
  filter {
    name   = "name"
    values = [var.ubuntu_arm_ami_name]
  }
}

data "aws_ami" "ubuntu_x86_ami" {
  most_recent = true
  owners      = ["amazon"]
  filter {
    name   = "architecture"
    values = ["x86_64"]
  }
  filter {
    name   = "name"
    values = [var.ubuntu_x86_ami_name]
  }
}

resource "aws_key_pair" "k8s_cluster_node_key_pair" {
  key_name   = "k8s-cluster-node-key-pair"
  public_key = file(var.ssh_public_key_path)
}

#### instance #### 
resource "aws_instance" "bastion_instance" {
  ami                         = data.aws_ami.ubuntu_arm_ami.id
  associate_public_ip_address = true
  instance_type               = "t4g.nano"
  subnet_id                   = var.bastion_subnet_id
  security_groups             = [var.baston_sg_id]
  key_name                    = aws_key_pair.k8s_cluster_node_key_pair.key_name
  private_dns_name_options {
    hostname_type = "ip-name"
  }
  tags = {
    Name = "bastion-instance"
  }
}

resource "aws_instance" "k8s_cluster_controle_plane" {
  ami                         = data.aws_ami.ubuntu_arm_ami.id
  associate_public_ip_address = false
  instance_type               = "t4g.medium"
  subnet_id                   = var.cluster_node_subnet_id
  security_groups             = [var.cluster_node_sg_id]
  key_name                    = aws_key_pair.k8s_cluster_node_key_pair.key_name
  private_dns_name_options {
    hostname_type = "ip-name"
  }
  tags = {
    Name = "k8s-cluster-controle-plane"
  }
}

resource "aws_instance" "k8s_cluster_node01" {
  ami                         = data.aws_ami.ubuntu_arm_ami.id
  associate_public_ip_address = false
  instance_type               = "t4g.small"
  subnet_id                   = var.cluster_node_subnet_id
  security_groups             = [var.cluster_node_sg_id]
  key_name                    = aws_key_pair.k8s_cluster_node_key_pair.key_name
  private_dns_name_options {
    hostname_type = "ip-name"
  }
  tags = {
    Name = "k8s-cluster-node01"
  }
}

resource "aws_instance" "k8s_cluster_node02" {
  ami                         = data.aws_ami.ubuntu_arm_ami.id
  associate_public_ip_address = false
  instance_type               = "t4g.small"
  subnet_id                   = var.cluster_node_subnet_id
  security_groups             = [var.cluster_node_sg_id]
  key_name                    = aws_key_pair.k8s_cluster_node_key_pair.key_name
  private_dns_name_options {
    hostname_type = "ip-name"
  }
  tags = {
    Name = "k8s-cluster-node02"
  }
}