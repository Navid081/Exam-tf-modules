variable "meta" {
  type = object({
    owner       = string
    basename    = string
    environment = string
  })
}


variable "secrets_names" {
  description = "List of secrets names"
  type        = list(string)
  default     = []
}


variable "region" {
  description = "AWS region"
  type        = string
}