variable "vpc_id" {
  description = "The VPC id where the RDS instance will be created"
}

variable "subnet_ids" {
  description = "The subnet ids where the RDS instance will be created"
  type        = list(string)
}

variable "db_name" {
  description = "The name of the RDS database"
}

variable "db_username" {
  description = "The username for the RDS database"
}

variable "db_password" {
  description = "The password for the RDS database"
}