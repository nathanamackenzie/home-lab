variable "vpc_name" {
  description = "Name of VPC"
  type = string
}

variable "vpc_cidr_block" {
  description = "VPC cidr block range"
  type = string
}

variable "public_subnets" {
  type = list(list(string))
  description = "Provide a list of subnets including the cidr, AZ, and name."
}

variable "private_subnets" {
  type = list(list(string))
  description = "Provide a list of subnets including the cidr, AZ, and name."
}


