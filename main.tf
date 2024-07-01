provider "aws" {
  region = "us-west-2"
}

module "vpc" {
  source = "./modules/vpc"
}

module "eks" {
  source           = "./modules/eks"
  vpc_id           = module.vpc.vpc_id
  subnet_ids       = module.vpc.subnet_ids
  cluster_name     = "my-cluster"
  node_instance_type = "t3.medium"
}

module "rds" {
  source      = "./modules/rds"
  vpc_id      = module.vpc.vpc_id
  subnet_ids  = module.vpc.subnet_ids
  db_name     = "mydatabase"
  db_username = "admin"
  db_password = "password"
}

module "dynamodb" {
  source = "./modules/dynamodb"
  table_name = "syllables"
}

module "sqs" {
  source = "./modules/sqs"
  queue_names = ["nodejs_to_go", "go_to_python"]
}

module "secretsmanager" {
  source = "./modules/secretsmanager"
  secret_name = "db_credentials"
  secret_value = jsonencode({
    username = "admin",
    password = "password"
  })
}

module "cloudwatch" {
  source = "./modules/cloudwatch"
}

module "security_groups" {
  source      = "./modules/security_groups"
  vpc_id      = module.vpc.vpc_id
}