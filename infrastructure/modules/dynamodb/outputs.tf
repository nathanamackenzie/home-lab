output "dynamodb_table" {
  value = aws_dynamodb_table.db_table
}

output "dynamodb_table_arn" {
  value = aws_dynamodb_table.db_table.arn
}