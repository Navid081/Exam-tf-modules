variable "meta" {
  type = object({
    owner       = string
    basename    = string
    environment = string
  })
}

variable "engine_version" {
  type        = string
  description = "The engine version to use"
  default     = ""
}

variable "allow_major_version_upgrade" {
  type        = bool
  description = "Major version upgrades are allowed"
  default     = false
}

variable "instance_class" {
  type        = string
  description = "The instance type of the RDS instance"
  default     = ""
}

variable "allocated_storage" {
  type        = number
  description = "The allocated storage in gigabytes"
  default     = 5
}

variable "db_name" {
  type        = string
  description = "The DB name to create. If omitted, no database is created initially"
  default     = ""
}

variable "username" {
  type        = string
  description = "Username for the master DB user"
  default     = ""
}

variable "parameters" {
  type        = list(map(any))
  description = "A list of DB parameters to apply"
  default     = []
}

variable "options" {
  type        = list(map(any))
  description = "A list of Options to apply"
  default     = []
}

variable "vpc_id" {
  type        = string
  description = "ID of the VPC where to create security group"
}

variable "cidr_block" {
  type        = string
  description = "Cidr block from which access will be allowed"
}

variable "storage_type" {
  type        = string
  description = "Storage type for the DB instance"
  default     = "gp3"
}

variable "storage_throughput" {
  type        = number
  description = "Storage throughput value for the DB instance"
  default     = 500
}

#variable "iops" {                                        --> Not supported manually by gp2
#  type        = number
#  description = "The amount of provisioned IOPS"
#  default     = 12000
#}

variable "apply_immediately" {
  type        = bool
  description = "Specifies whether any database modifications are applied immediately, or during the next maintenance window"
  default     = true
}

variable "deletion_protection" {
  type        = bool
  description = "Protect database from being deleted"
  default     = false
}


variable "multi_az" {
  type        = bool
  description = "Specifies if the RDS instance is multi-AZ"
  default     = false
}

variable "subnet_ids" {
  type        = list(string)
  description = "A list of VPC subnet IDs"
}

variable "family" {
  type        = string
  description = "The family of the DB parameter group"
  default     = "postgres15"
}

variable "major_engine_version" {
  type        = string
  description = "Major version of the engine that option group should be associated with"
  default     = "15"
}

variable "secret_name" {
  type        = string
  description = "Optional name of secret"
  default     = ""
}

variable "region" {
  type        = string
  description = "AWS region"
}

