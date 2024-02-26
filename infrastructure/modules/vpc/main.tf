terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
  }
}

resource "aws_vpc" "create_vpc" {
  cidr_block           = var.vpc_cidr_block
  enable_dns_hostnames = true
  enable_dns_support   = true
  

  tags = {
    Name = var.vpc_name
  }
}

resource "aws_subnet" "public" {
  count = length(var.public_subnets)
  vpc_id = aws_vpc.create_vpc.id
  availability_zone = element(element(var.public_subnets, count.index), 1)
  cidr_block = element(element(var.public_subnets, count.index), 0)
  tags = {
    Name = element(element(var.public_subnets, count.index), 2)
  }
}

resource "aws_subnet" "private" {
  count = length(var.private_subnets)
  vpc_id = aws_vpc.create_vpc.id
  availability_zone = element(element(var.private_subnets, count.index), 1)
  cidr_block = element(element(var.private_subnets, count.index), 0)
  tags = {
    Name = element(element(var.private_subnets, count.index), 2)
  }
}

resource "aws_internet_gateway" "vpc-igw" {
  vpc_id = aws_vpc.create_vpc.id

  tags = {
    Name = "${var.vpc_name}-igw"
  }
}

resource "aws_route_table" "default_rt" {
 vpc_id = aws_vpc.create_vpc.id
 
 route {
   cidr_block = "0.0.0.0/0"
   gateway_id = aws_internet_gateway.vpc-igw.id
 }
 
 tags = {
   Name = "Default Route"
 }
}

resource "aws_route_table_association" "public_subnet_assoc" {
  count = length(var.public_subnets)
  subnet_id = element(aws_subnet.public[*].id, count.index)
  route_table_id = aws_route_table.default_rt.id
}

