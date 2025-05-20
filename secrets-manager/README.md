<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_meta"></a> [meta](#module\_meta) | ../meta | n/a |

## Resources

| Name | Type |
|------|------|
| [aws_secretsmanager_secret.example](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/secretsmanager_secret) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_meta"></a> [meta](#input\_meta) | n/a | <pre>object({<br>    owner       = string<br>    basename    = string<br>    environment = string<br>  })</pre> | n/a | yes |
| <a name="input_secrets_names"></a> [secrets\_names](#input\_secrets\_names) | List of secrets names | `list(string)` | `[]` | no |

## Outputs

No outputs.
<!-- END_TF_DOCS -->