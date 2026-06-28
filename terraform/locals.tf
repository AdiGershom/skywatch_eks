locals {

  project_name = var.project_name

  environment = var.environment


  cluster_name = var.cluster_name


  common_tags = {
    Project     = local.project_name
    Environment = local.environment
    ManagedBy   = "Terraform"
  }

}