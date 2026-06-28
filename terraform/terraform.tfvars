aws_region = "eu-central-1"

project_name = "skywatch"

environment = "dev"

cluster_name = "skywatch-eks"

vpc_cidr = "10.0.0.0/16"


availability_zones = [
  "eu-central-1a",
  "eu-central-1b"
]


public_subnets = [
  "10.0.1.0/24",
  "10.0.2.0/24"
]


private_subnets = [
  "10.0.101.0/24",
  "10.0.102.0/24"
]