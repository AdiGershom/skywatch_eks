variable "aws_region" {
  description = "AWS Region"
  type        = string
}

variable "project_name" {
  description = "Project Name"
  type        = string
}

variable "environment" {
  description = "Environment"
  type        = string
}

variable "cluster_name" {
  description = "EKS Cluster Name"
  type        = string
}

variable "vpc_cidr" {
  description = "VPC CIDR Block"
  type        = string
}

variable "availability_zones" {
  description = "Availability Zones"

  type = list(string)
}

variable "public_subnets" {
  description = "Public Subnet CIDRs"

  type = list(string)
}

variable "private_subnets" {
  description = "Private Subnet CIDRs"

  type = list(string)
}