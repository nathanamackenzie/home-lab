terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  alias  = "us-east-1"
  region = "us-east-1"
}

provider "aws" {
  alias  = "us-east-2"
  region = "us-east-2"
}

# VPC definitions

module "dev-use1-vpc1" {
  source   = "../../modules/vpc"
  vpc_name = "dev-use1-vpc1"
  providers = {
    aws = aws.us-east-1
  }

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

module "dev-use2-vpc1" {
  source   = "../../modules/vpc"
  vpc_name = "dev-use2-vpc1"
  providers = {
    aws = aws.us-east-2
  }

  vpc_cidr_block = "192.168.24.0/21"
  public_subnets = [
    ["192.168.24.0/24", "us-east-2a", "pub-web-2a"],
  ["192.168.28.0/24", "us-east-2b", "pub-web-2b"]]

  private_subnets = [
    ["192.168.25.0/24", "us-east-2a", "pvt-app-2a"],
    ["192.168.26.0/24", "us-east-2a", "pvt-db-2a"],
    ["192.168.27.0/24", "us-east-2a", "pvt-res-2a"],
    ["192.168.29.0/24", "us-east-2b", "pvt-app-2b"],
    ["192.168.30.0/24", "us-east-2b", "pvt-db-2b"],
  ["192.168.31.0/24", "us-east-2b", "pvt-res-2b"]]
}

# Static S3 website

resource "aws_s3_bucket" "personal-website" {
  bucket = "personal-website-345645"
}

resource "aws_s3_bucket_policy" "website-bucket-policy" {
  bucket = aws_s3_bucket.personal-website.id
  policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Sid" : "PublicReadGetObject",
        "Effect" : "Allow",
        "Principal" : "*",
        "Action" : [
          "s3:GetObject"
        ],
        "Resource" : [
          "arn:aws:s3:::${aws_s3_bucket.personal-website.id}/*"
        ]
      }
    ]
  })
}

resource "aws_s3_bucket_public_access_block" "allow-public" {
  bucket              = aws_s3_bucket.personal-website.id
  block_public_acls   = false
  block_public_policy = false
}

resource "aws_s3_bucket_website_configuration" "hosting" {
  bucket = aws_s3_bucket.personal-website.id

  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "error.html"
  }
}

# DynamoDB for website visitor activity

module "visit_db" {
  source = "../../modules/dynamodb"
  providers = {
    aws = aws.us-east-1
  }

  table_name     = "visit_log"
  hash_key_name  = "sessionID"
  hash_key_type  = "N"
  range_key_name = "date-time"
  range_key_type = "S"

}

# API Gateway for website visitor activity

module "apigw" {
  source = "../../modules/apigateway"
  providers = {
    aws = aws.us-east-1
  }

  apigw_name   = "visit_apigw"
  http_method  = "POST"
  iam_role_arn = aws_iam_role.apigw_dynodb_role.arn
}

resource "aws_iam_role" "apigw_dynodb_role" {
  name = "apigw_dynodb_role"

  assume_role_policy = <<-EOF
  {
    "Version": "2012-10-17",
    "Statement": [
      {
        "Action": "sts:AssumeRole",
        "Principal": {
          "Service": "apigateway.amazonaws.com"
        },
        "Effect": "Allow",
        "Sid": "iamroletrustpolicy"
      }
    ]
  }
  EOF

}

resource "aws_iam_role_policy" "apigw_dynodb_policy" {
  name   = "apigw_dynodb_policy"
  role   = aws_iam_role.apigw_dynodb_role.id
  policy = data.aws_iam_policy_document.apigw_dynamo_premissions.json
}
