variable "apigw_name" {
  description = "Name of API Gateway"
  type = string
}

variable "http_method" {
  description = "HTTP Method type (POST, GET, ect...)"
  type = string
}

variable "iam_role_arn" {
  description = "AWS iam role arn for apigw to dynamodb"
  type = string
}