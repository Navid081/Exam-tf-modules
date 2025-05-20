locals {
  region = var.region
}

#module "meta" {
  #source = "../meta"

  #source = "${path.module}/../meta"
  #source = "/home/n/Desktop/Development/modules/meta"       # Hardcoded due to Terragrunt cache structure
  #meta   = var.meta
#}

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "5.0.0"

  name = module.meta.name
  cidr = var.cidr

  azs                           = ["${local.region}a", "${local.region}b"]
  private_subnets               = var.private_subnets
  public_subnets                = var.public_subnets
  database_subnets              = var.database_subnets
  manage_default_network_acl    = false
  manage_default_route_table    = false
  manage_default_security_group = false
  map_public_ip_on_launch       = true

  enable_nat_gateway     = var.enable_nat_gateway
  single_nat_gateway     = var.single_nat_gateway
  one_nat_gateway_per_az = false

  create_database_subnet_route_table = true
  create_database_subnet_group       = false

  enable_flow_log                      = true
  create_flow_log_cloudwatch_log_group = true
  create_flow_log_cloudwatch_iam_role  = true
  flow_log_max_aggregation_interval    = 60
  vpc_flow_log_tags = {
    Name = "${module.meta.name}-all-traffic"
  }

  # required for service discovery
  enable_dns_hostnames = true
  enable_dns_support   = true

  # add tags to public subnet to auto discovery subnets for EKS AWS Load Balancer Controller
  # ref: https://docs.aws.amazon.com/eks/latest/userguide/aws-load-balancer-controller.html
  #public_subnet_tags = {
  #  "kubernetes.io/role/elb" : 1
  # }
}