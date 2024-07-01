output "rds_endpoint" {
  value = aws_db_instance.default.endpoint
}

output "rds_username" {
  value = aws_db_instance.default.username
}