variable "table_name" {
  description = "Name of DynamoDB table"
  type = string
}

variable "hash_key_name" {
  description = "Partion key name"
  type = string
}

variable "range_key_name" {
  description = "Sort key name"
  type = string
}

variable "range_key_type" {
  description = "Sort key data type"
  type = string
}

variable "hash_key_type" {
  description = "Partion key type (S, B, N)"
  default = "S"
  type = string
}