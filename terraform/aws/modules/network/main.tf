
##### VPC ######
resource "aws_vpc" "vpc-k8s" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "vpc-k8s"
  }
}

resource "aws_internet_gateway" "internet-gateway-vpc-k8s" {
  vpc_id = aws_vpc.vpc-k8s.id

  tags = {
    Name = "internet-gateway-vpc-k8s"
  }
}

resource "aws_eip" "bastion_nat_gateway_eip" {
  domain   = "vpc"
  tags = {
    Name = "bastion-nat-gateway-eip"
  }
}

resource "aws_nat_gateway" "bastion_nat_gateway" {
  allocation_id = aws_eip.bastion_nat_gateway_eip.id
  subnet_id     = aws_subnet.bastion-subnet.id

  tags = {
    Name = "bastion-nat-gateway"
  }
  # To ensure proper ordering, it is recommended to add an explicit dependency
  # on the Internet Gateway for the VPC.
  depends_on = [aws_internet_gateway.internet-gateway-vpc-k8s]
}


resource "aws_route_table" "route-table-bastion" {
  vpc_id = aws_vpc.vpc-k8s.id

  route {
    cidr_block = aws_vpc.vpc-k8s.cidr_block
    gateway_id = "local"
  }

  route {
    # route for connecting intertnet
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.internet-gateway-vpc-k8s.id
  }
  tags = {
    Name = "route-table-bastion"
  }
}


resource "aws_route_table" "route-table-cluster-node" {
  vpc_id = aws_vpc.vpc-k8s.id

  route {
    cidr_block = aws_vpc.vpc-k8s.cidr_block
    gateway_id = "local"
  }
  route {
    # route for connecting intertnet via nat gateway
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.bastion_nat_gateway.id
  }

  tags = {
    Name = "route-table-cluster-node"
  }
}

##### Sunbnet ######
resource "aws_subnet" "bastion-subnet" {
  vpc_id     = aws_vpc.vpc-k8s.id
  cidr_block = "10.0.1.0/24"

  tags = {
    Name = "bastion"
  }
}

resource "aws_subnet" "cluster-node-subnet" {
  vpc_id     = aws_vpc.vpc-k8s.id
  cidr_block = "10.0.2.0/24"

  tags = {
    Name = "cluster-node"
  }
}

resource "aws_route_table_association" "bastion-rt-associate" {
  subnet_id      = aws_subnet.bastion-subnet.id
  route_table_id = aws_route_table.route-table-bastion.id
}

resource "aws_route_table_association" "cluster-node-rt-associate" {
  subnet_id      = aws_subnet.cluster-node-subnet.id
  route_table_id = aws_route_table.route-table-cluster-node.id
}



##### Security Group #####
resource "aws_security_group" "bastion-sg" {
  name        = "bastion sg"
  description = "Allow trafic to bastion instance which maangement for k8s cluster."
  vpc_id      = aws_vpc.vpc-k8s.id

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [aws_vpc.vpc-k8s.cidr_block]
  }

  tags = {
    Name = "bastion-sg"
  }
}

resource "aws_security_group" "cluster-node-sg" {
  name        = "cluster node sg"
  description = "Allow trafic to k8s cluster instance."
  vpc_id      = aws_vpc.vpc-k8s.id

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
  # allow all internal trafic.
  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [aws_vpc.vpc-k8s.cidr_block]
  }

  # allow http trafic.
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  # allow https trafic
  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # allow trafic to node port services.
  ingress {
    from_port   = 30000
    to_port     = 32767
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "cluster-node-sg"
  }
}
