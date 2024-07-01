resource "aws_dynamodb_table" "default" {
  name           = var.table_name
  hash_key       = "id"
  billing_mode   = "PAY_PER_REQUEST"

  attribute {
    name = "id"
    type = "S"
  }

  attribute {
    name = "syllable"
    type = "S"
  }
}