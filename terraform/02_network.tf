# Production VPC
resource "aws_vpc" "eks-vpc" {
  cidr_block           = var.vpc_cidr_block
  enable_dns_support   = true
  enable_dns_hostnames = true
}

# Public subnets
resource "aws_subnet" "public-subnet-1" {
  cidr_block        = var.public_subnet_1_cidr
  vpc_id            = aws_vpc.eks-vpc.id
  availability_zone = var.availability_zones[0]
  map_public_ip_on_launch = true
}

resource "aws_subnet" "public-subnet-2" {
  cidr_block        = var.public_subnet_2_cidr
  vpc_id            = aws_vpc.eks-vpc.id
  availability_zone = var.availability_zones[1]
  map_public_ip_on_launch = true
}

# Route tables for the subnets
resource "aws_route_table" "public-route-table" {
  vpc_id = aws_vpc.eks-vpc.id

  tags = {
    Name = "public-route-table"
  }
}


# Associate the newly created route tables to the subnets
resource "aws_route_table_association" "public-route-1-association" {
  route_table_id = aws_route_table.public-route-table.id
  subnet_id      = aws_subnet.public-subnet-1.id
}

resource "aws_route_table_association" "public-route-2-association" {
  route_table_id = aws_route_table.public-route-table.id
  subnet_id      = aws_subnet.public-subnet-2.id
}


# Internet Gateway for the public subnet
resource "aws_internet_gateway" "eks-igw" {
  vpc_id = aws_vpc.eks-vpc.id
}

# Route the public subnet traffic through the Internet Gateway
resource "aws_route" "public-internet-igw-route" {
  route_table_id         = aws_route_table.public-route-table.id
  gateway_id             = aws_internet_gateway.eks-igw.id
  destination_cidr_block = "0.0.0.0/0"
}
