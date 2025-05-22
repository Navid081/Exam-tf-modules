module "meta" {   #  anropar meta-modulen för att generera namn och taggar baserat på värden i var.meta
  source = "git::https://github.com/Navid081/Exam-tf-modules.git//meta?ref=main"
  meta   = var.meta
}

resource "aws_secretsmanager_secret" "example" {      # Skapar en secret för varje namn som
  for_each = toset(var.secrets_names)                 # skickas in i listan "secret_names"
  name     = each.key
}

# Den här modulen skapar hemligheter i AWS Secrets Manager.
# Secrets Manager används för att lagra saker som lösenord, API-nycklar och databasuppgifter.
# Modulen skapar en secret för varje namn som skickas in via variabeln `secrets_names`.
# Namnen kan sedan användas av t.ex. EC2 eller RDS för att hämta lösenord säkert.
