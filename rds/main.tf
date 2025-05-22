module "meta" {   # anropar meta-modulen för att generera namn och taggar baserat på värden i var.meta
  source = "git::https://github.com/Navid081/Exam-tf-modules.git//meta?ref=main"
  meta   = var.meta
}

module "db" {
  source  = "terraform-aws-modules/rds/aws"           
  version = "~> 6.1.1"

  identifier = module.meta.name       # Tas från meta - emulate-rds-dev
                                                        # databasens parametrar
  engine                      = "postgres"                
  engine_version              = var.engine_version
  allow_major_version_upgrade = var.allow_major_version_upgrade
  instance_class              = var.instance_class
  allocated_storage           = var.allocated_storage
  storage_type                = var.storage_type
#  iops                       = var.iops                 --> not supported manually by gp2
#  storage_throughput         = var.storage_throughput   --> not supported by gp2
  db_name                     = var.db_name
  username                    = var.username
  manage_master_user_password = false
  password                    = random_password.master_password.result
  port                        = "5432"

  iam_database_authentication_enabled = true
  deletion_protection       = var.deletion_protection
  apply_immediately         = var.apply_immediately
  multi_az                  = var.multi_az
  vpc_security_group_ids    = [module.security_group.security_group_id]
  maintenance_window        = "Mon:00:00-Mon:03:00"
  backup_window             = "03:00-06:00"
  backup_retention_period   = 7
  create_db_subnet_group    = true
  subnet_ids                = var.subnet_ids
  family                    = var.family
  major_engine_verson       = var.major_engine_version
  parameters                = var.parameters
  options                   = var.options
}


module "security_group" {                                 # Säkerhetsgrupp/brandvägg skapas för RDS
  source  = "terraform-aws-modules/security-group/aws"    
  version = "~> 5.1.0"
  name        = module.meta.name                          
  description = "Security group for PostgreSQL"
  vpc_id      = var.vpc_id

                                                          # inobund rule
  ingress_with_cidr_blocks = [                            # Tillåter åtkost till port 5432 
    {                                                     # endast inom VPC
      from_port   = 5432
      to_port     = 5432
      protocol    = "tcp"                                 # endast med tcp
      description = "PostgreSQL access from within VPC"
      cidr_blocks = var.cidr_block
    }
  ]
}

resource "aws_kms_key" "db_key" {                                 # Skapar en ksm-key för krypering
  description             = "KMS key for AWS Secrets Manager"     # av lösen i sercrets manager
  deletion_window_in_days = 7
  # enable_key_rotation     = true                                    --> No rotation to handle error.
}

resource "aws_secretsmanager_secret" "password_secret" {    # skapar hemlighet i secretmanager (behållaren)
  name                    = var.secret_name == "" ? module.meta.name : var.secret_name
  recovery_window_in_days = 30
  kms_key_id              = aws_kms_key.db_key.id
}

resource "random_password" "master_password" {           # skapar ett random 16 tecken lösen
  length = 16
}

resource "aws_secretsmanager_secret_version" "password_secret_value" {  # Lägger in lösenordet i behållaren
  secret_id     = aws_secretsmanager_secret.password_secret.id          
  secret_string = random_password.master_password.result  
}