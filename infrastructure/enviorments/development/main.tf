terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

module "vpc" {
  source         = "../../modules/vpc"
  vpc_name       = "dev-use1-vpc1"
  vpc_cidr_block = "192.168.16.0/21"
  public_subnets = [
    ["192.168.16.0/24", "us-east-1a", "pub-web-1a"],
    ["192.168.20.0/24", "us-east-1b", "pub-web-1b"]]

  private_subnets = [
    ["192.168.17.0/24", "us-east-1a", "pvt-app-1a"], 
    ["192.168.18.0/24", "us-east-1a", "pvt-db-1a"],
    ["192.168.19.0/24", "us-east-1a", "pvt-res-1a"],
    ["192.168.21.0/24", "us-east-1b", "pvt-app-1b"],
    ["192.168.22.0/24", "us-east-1b", "pvt-db-1b"],
    ["192.168.23.0/24", "us-east-1b", "pvt-res-1b"]]
}