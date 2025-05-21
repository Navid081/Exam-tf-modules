locals {                                      # Skapar lokal variabel "region" som  
  region = var.region
}

module "meta" {                               # Anropar separat modul "meta" sköter metadata (namnkonventioner tags etc)
                                              # jag använder "ownre, basename, environment"
  source = "git::https://github.com/Navid081/Exam-tf-modules.git//meta?ref=main"
  meta   = var.meta
}

module "vpc" {                                 # Anropar vpc modul från terraform-aws-modules"
                                               # Den bygger VPC:n automatiskt från inputs jag skickar in
  source  = "terraform-aws-modules/vpc/aws"
  version = "5.0.0"

  name = module.meta.name                      # namnet sätts baserat på meta-modulen.
  cidr = var.cidr                              # VPC:ns övergripande IP-nät

  azs                           = ["${local.region}a", "${local.region}b"]    # eu-north-1a och 1b
  private_subnets               = var.private_subnets                         # skapar tre subnät inom VPC
  public_subnets                = var.public_subnets
  database_subnets              = var.database_subnets
  manage_default_network_acl    = false                   # Rör ej standardresurser som AWS automatiskt skapar
  manage_default_route_table    = false
  manage_default_security_group = false
  map_public_ip_on_launch       = true                    # EC2-instancer får public subnät får IP automatiskt

  enable_nat_gateway     = var.enable_nat_gateway
  single_nat_gateway     = var.single_nat_gateway
  one_nat_gateway_per_az = false

  create_database_subnet_route_table = true
  create_database_subnet_group       = false

  enable_flow_log                      = true              # AWS loggar all trafik in/ut till CloudWatch
  create_flow_log_cloudwatch_log_group = true
  create_flow_log_cloudwatch_iam_role  = true
  flow_log_max_aggregation_interval    = 60                # Loggar varje 60 sek.
  vpc_flow_log_tags = {
    Name = "${module.meta.name}-all-traffic"
  }

  # required for service discovery                 # Intern DNS, resurser i VPC kan hitta varandra via DNS-namn
  enable_dns_hostnames = true
  enable_dns_support   = true

  # add tags to public subnet to auto discovery subnets for EKS AWS Load Balancer Controller
  # ref: https://docs.aws.amazon.com/eks/latest/userguide/aws-load-balancer-controller.html
  #public_subnet_tags = {
  #  "kubernetes.io/role/elb" : 1
  # }
}