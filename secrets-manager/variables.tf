variable "meta" {         # modulen kräver ett meta-objekt med tre fält.
  type = object({         # används av meta-modulen för att skapa konsekventa namn och taggar
    owner       = string
    basename    = string
    environment = string
  })
}


variable "secrets_names" {                  # en lista av namn på secrets som ska skapas 
  description = "List of secrets names"
  type        = list(string)                # Tom per default. Värden skickas in genom TG
  default     = []                          
}


variable "region" {
  description = "AWS region"
  type        = string
}