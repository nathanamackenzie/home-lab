terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
  }
}

resource "aws_dynamodb_table" "db_table" {
  name = var.table_name
  hash_key       = var.hash_key_name
  range_key = var.range_key_name
  billing_mode = "PROVISIONED"
  read_capacity = "20"
  write_capacity = "20"

  attribute {
    name = var.hash_key_name
    type = var.hash_key_type
  }

  attribute {
    name = var.range_key_name
    type = "N"
  }
}