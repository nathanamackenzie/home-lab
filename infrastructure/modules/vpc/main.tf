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
