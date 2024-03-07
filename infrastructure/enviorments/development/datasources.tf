data "aws_iam_policy_document" "apigw_dynamo_premissions" {
  depends_on = [ module.visit_db.dynamodb_table ]

  statement {
    sid = "dynamodbtablepolicy"

    actions = [ 
        "dynamodb:BatchGetItem",
        "dynamodb:BatchWriteItem",
        "dynamodb:ConditionCheckItem",
        "dynamodb:PutItem",
        "dynamodb:DescribeTable",
        "dynamodb:DeleteItem",
        "dynamodb:GetItem",
        "dynamodb:Scan",
        "dynamodb:Query",
        "dynamodb:UpdateItem",
        "dynamodb:GetShardIterator",
        "dynamodb:DescribeStream",
        "dynamodb:GetRecords",
        "dynamodb:ListStreams"
     ]

     resources = [
        module.visit_db.dynamodb_table_arn
     ]

  }
}