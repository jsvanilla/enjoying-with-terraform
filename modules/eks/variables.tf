variable "vpc_id" {
  description = "The VPC id where the EKS cluster will be created"
}

variable "subnet_ids" {
  description = "The subnet ids where the EKS cluster will be created"
  type        = list(string)
}

variable "cluster_name" {
  description = "The name of the EKS cluster"
}

variable "node_instance_type" {
  description = "The instance type for the EKS nodes"
}