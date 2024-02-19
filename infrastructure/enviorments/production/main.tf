terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  alias = "us-east-1"
  region = "us-east-1"
}

provider "aws" {
  alias = "us-east-2"
  region = "us-east-2"
}

module "dev-use1-vpc1" {
  source         = "../../modules/vpc"
  vpc_name       = "prod-use1-vpc1"
  providers = {
    aws = aws.us-east-1
  }
  
  vpc_cidr_block = "192.168.0.0/21"
  public_subnets = [
    ["192.168.0.0/24", "us-east-1a", "pub-web-1a"],
    ["192.168.4.0/24", "us-east-1b", "pub-web-1b"]]

  private_subnets = [
    ["192.168.1.0/24", "us-east-1a", "pvt-app-1a"],
    ["192.168.2.0/24", "us-east-1a", "pvt-db-1a"],
    ["192.168.3.0/24", "us-east-1a", "pvt-res-1a"],
    ["192.168.5.0/24", "us-east-1b", "pvt-app-1b"],
    ["192.168.6.0/24", "us-east-1b", "pvt-db-1b"],
    ["192.168.7.0/24", "us-east-1b", "pvt-res-1b"]]
}

module "dev-use2-vpc1" {
  source         = "../../modules/vpc"
  vpc_name       = "prod-use2-vpc1"
  providers = {
    aws = aws.us-east-2
  }
  
  vpc_cidr_block = "192.168.8.0/21"
  public_subnets = [
    ["192.168.8.0/24", "us-east-2a", "pub-web-2a"],
    ["192.168.12.0/24", "us-east-2b", "pub-web-2b"]]

  private_subnets = [
    ["192.168.9.0/24", "us-east-2a", "pvt-app-2a"],
    ["192.168.10.0/24", "us-east-2a", "pvt-db-2a"],
    ["192.168.11.0/24", "us-east-2a", "pvt-res-2a"],
    ["192.168.13.0/24", "us-east-2b", "pvt-app-2b"],
    ["192.168.14.0/24", "us-east-2b", "pvt-db-2b"],
    ["192.168.15.0/24", "us-east-2b", "pvt-res-2b"]]
}