terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

resource "aws_api_gateway_rest_api" "apigw" {
  name = "apigw"

  endpoint_configuration {
    types = ["REGIONAL"]
  }
}

resource "aws_api_gateway_resource" "api_resource" {
  rest_api_id = aws_api_gateway_rest_api.apigw.id
  parent_id = aws_api_gateway_rest_api.apigw.root_resource_id
  path_part = "visit"
}

resource "aws_api_gateway_method" "api_method" {
  rest_api_id = aws_api_gateway_rest_api.apigw.id
  resource_id = aws_api_gateway_resource.api_resource.id
  http_method = var.http_method
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "api_integration" {
  rest_api_id = aws_api_gateway_rest_api.apigw.id
  resource_id = aws_api_gateway_resource.api_resource.id
  http_method = aws_api_gateway_method.api_method.http_method
  type = "AWS"
  integration_http_method = var.http_method
  uri                     = "arn:aws:apigateway:us-east-1:dynamodb:action/PutItem"
  credentials = var.iam_role_arn
}

resource "aws_api_gateway_method_response" "api_method_response" {
  rest_api_id = aws_api_gateway_rest_api.apigw.id
  resource_id = aws_api_gateway_resource.api_resource.id
  http_method = aws_api_gateway_method.api_method.http_method
  status_code = "200"
}

resource "aws_api_gateway_integration_response" "api_integration_response" {
  depends_on = [ aws_api_gateway_integration.api_integration ]
  rest_api_id = aws_api_gateway_rest_api.apigw.id
  resource_id = aws_api_gateway_resource.api_resource.id
  http_method = aws_api_gateway_method.api_method.http_method
  status_code = aws_api_gateway_method_response.api_method_response.status_code
}