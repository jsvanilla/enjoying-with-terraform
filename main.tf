provider "aws" {
  region = var.aws_region
}

resource "aws_ecr_repository" "main" {
  name = var.ecr_repository
}

resource "aws_iam_role" "ecs_task_execution_role" {
  name = "ecsTaskExecutionRole"
  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Principal = {
          Service = "ecs-tasks.amazonaws.com"
        },
        Action = "sts:AssumeRole"
      }
    ]
  })

  managed_policy_arns = [
    "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
  ]
}

output "ecr_repository_url" {
  value = aws_ecr_repository.main.repository_url
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

output "vpc_id" {
  value = module.vpc.vpc_id
}

output "subnet_ids" {
  value = module.vpc.subnet_ids
}

output "eks_cluster_endpoint" {
  value = module.eks.eks_cluster_endpoint
}

output "rds_endpoint" {
  value = module.rds.rds_endpoint
}