variable "meta" {                     # Här defineras vilka värden modulen kan ta emot.
  type = object({                     # Om de är default eller inte.
    owner       = string
    basename    = string              # Om jag inte skickar värden från TG.
    environment = string              # Används default värdet som är satta här
  })                                  # Vi kan skriva över dom som är satta genom TG.
}

variable "region" {
  description = "AWS region"
  type        = string
}

variable "public_subnets" {
  description = "List of public subnets CIDR"
  type        = list(string)
  default     = ["10.10.0.0/21", "10.10.8.0/21"]
}

variable "private_subnets" {
  description = "List of private subnets CIDR"
  type        = list(string)
  default     = ["10.10.16.0/21", "10.10.24.0/21"]
}

variable "database_subnets" {
  description = "List of database subnets CIDR"
  type        = list(string)
  default     = ["10.10.32.0/21", "10.10.40.0/21"]
}

variable "cidr" {
  description = "VPC cidr"
  default     = "10.10.0.0/18"
}

variable "enable_nat_gateway" {
  description = "Enable NAT gateway"
  default     = true
}

variable "single_nat_gateway" {
  description = "Single NAT gateway"
  default     = true
}