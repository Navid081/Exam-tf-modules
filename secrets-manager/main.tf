module "meta" {
  source = "git::https://github.com/Navid081/Exam-tf-modules.git//meta?ref=main"
  meta   = var.meta
}

resource "aws_secretsmanager_secret" "example" {
  for_each = toset(var.secrets_names)
  name     = each.key
}