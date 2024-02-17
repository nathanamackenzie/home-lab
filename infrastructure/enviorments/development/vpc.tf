## Development USE1 VPC ##
resource "aws_vpc" "dev_vpc" {
  cidr_block           = "192.168.24.0/21"
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name = "dev"
  }
}

# AZ A Subnet Definitions
resource "aws_subnet" "dev_web_1a_subnet" {
  vpc_id                  = aws_vpc.dev_vpc.id
  cidr_block              = "192.168.24.0/24"
  map_public_ip_on_launch = true
  availability_zone       = "us-east-1a"

  tags = {
    Name = "dev-web-1a-vpc"
  }
}

resource "aws_subnet" "dev_app_1a_subnet" {
  vpc_id                  = aws_vpc.dev_vpc.id
  cidr_block              = "192.168.25.0/24"
  map_public_ip_on_launch = true
  availability_zone       = "us-east-1a"

  tags = {
    Name = "dev-app-1a-vpc"
  }
}

resource "aws_subnet" "dev_db_1a_subnet" {
  vpc_id                  = aws_vpc.dev_vpc.id
  cidr_block              = "192.168.26.0/24"
  map_public_ip_on_launch = true
  availability_zone       = "us-east-1a"

  tags = {
    Name = "dev-db-1a-vpc"
  }
}

resource "aws_subnet" "dev_res_1a_subnet" {
  vpc_id                  = aws_vpc.dev_vpc.id
  cidr_block              = "192.168.27.0/24"
  map_public_ip_on_launch = true
  availability_zone       = "us-east-1a"

  tags = {
    Name = "dev-res-1a-vpc"
  }
}

# AZ B Subnet Definitions
resource "aws_subnet" "dev_web_1b_subnet" {
  vpc_id                  = aws_vpc.dev_vpc.id
  cidr_block              = "192.168.28.0/24"
  map_public_ip_on_launch = true
  availability_zone       = "us-east-1b"

  tags = {
    Name = "dev-web-1b-vpc"
  }
}

resource "aws_subnet" "dev_app_1b_subnet" {
  vpc_id                  = aws_vpc.dev_vpc.id
  cidr_block              = "192.168.29.0/24"
  map_public_ip_on_launch = true
  availability_zone       = "us-east-1b"

  tags = {
    Name = "dev-app-1b-vpc"
  }
}

resource "aws_subnet" "dev_db_1absubnet" {
  vpc_id                  = aws_vpc.dev_vpc.id
  cidr_block              = "192.168.30.0/24"
  map_public_ip_on_launch = true
  availability_zone       = "us-east-1b"

  tags = {
    Name = "dev-db-1b-vpc"
  }
}

resource "aws_subnet" "dev_res_1b_subnet" {
  vpc_id                  = aws_vpc.dev_vpc.id
  cidr_block              = "192.168.31.0/24"
  map_public_ip_on_launch = true
  availability_zone       = "us-east-1b"

  tags = {
    Name = "dev-res-1b-vpc"
  }
}

# Routing
resource "aws_internet_gateway" "dev-igw" {
  vpc_id = aws_vpc.dev_vpc.id

  tags = {
    Name = "dev-igw"
  }
}

resource "aws_route_table" "dev-pub-rt" {
  vpc_id = aws_vpc.dev_vpc.id

  tags = {
    Name = "dev-pub-rt"
  }
}

resource "aws_route" "default_route" {
  route_table_id = aws_route_table.dev-pub-rt.id

  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.dev-igw.id
}

resource "aws_route_table_association" "dev-pub-1a-assoc" {
  subnet_id = aws_subnet.dev_web_1a_subnet.id

  route_table_id = aws_route_table.dev-pub-rt.id
}

resource "aws_route_table_association" "dev-pub-1b-assoc" {
  subnet_id = aws_subnet.dev_web_1b_subnet.id

  route_table_id = aws_route_table.dev-pub-rt.id
}