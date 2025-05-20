variable "meta" {
  type = object({
    owner       = string
    basename    = string
    environment = string
  })
  validation {
    condition     = var.meta.owner != "" && var.meta.basename != "" && var.meta.environment != ""
    error_message = ""
  }
}
