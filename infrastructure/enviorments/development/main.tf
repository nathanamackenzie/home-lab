terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region                   = "us-east-1"
}

resource "aws_vpc" "dev_vpc" {
  cidr_block           = "192.168.24.0/21"
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name = "dev"
  }
}

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