module "meta" {
  source = "../meta"
  meta   = var.meta
}

resource "aws_secretsmanager_secret" "example" {
  for_each = toset(var.secrets_names)
  name     = each.key
}