output "name" {
  value = join("-", compact([var.meta.owner, var.meta.basename, var.meta.environment]))
}

output "owner" {
  value = var.meta.owner
}

output "environment" {
  value = var.meta.environment
}

output "basename" {
  value = var.meta.basename
}