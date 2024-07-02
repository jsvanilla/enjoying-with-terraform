variable "aws_region" {
  description = "The AWS region where resources will be created"
  type        = string
  default     = "us-west-2"
}

variable "ecr_repository" {
  description = "The name of the ECR repository"
  type        = string
  default     = "my-repository"
}

variable "cluster_name" {
  description = "The name of the EKS cluster"
  type        = string
}

variable "alarm_action" {
  description = "The action to take when the alarm is triggered"
  type        = string
}