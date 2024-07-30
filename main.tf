locals {
  parameters = flatten([
    for app_env_key, app_env in var.parameters : [
      for env_variables_key, environment_variables in app_env.parameters : {
        app_env_key       = app_env_key
        env_variables_key = env_variables_key
        env_description   = environment_variables.description
        env_encrypted     = environment_variables.encrypted
        env_value         = environment_variables.value
      }
    ]
  ])
}

resource "aws_ssm_parameter" "non_secret_variables" {
  for_each = tomap({
    for value in local.parameters : "${value.app_env_key}.${value.env_variables_key}" => value if value.env_encrypted == false
  })

  name        = "/${each.value.app_env_key}/${each.value.env_variables_key}"
  description = each.value.env_description

  type   = each.value.env_encrypted ? "SecureString" : "String"
  value  = each.value.env_value == "" ? "insert value" : each.value.env_value
  key_id = each.value.env_encrypted == true ? var.kms_key_arn : null

}

resource "aws_ssm_parameter" "secret_variables" {
  for_each = tomap({
    for value in local.parameters : "${value.app_env_key}.${value.env_variables_key}" => value if value.env_encrypted == true
  })

  name        = "/${each.value.app_env_key}/${each.value.env_variables_key}"
  description = each.value.env_description

  type   = each.value.env_encrypted ? "SecureString" : "String"
  value  = each.value.env_value == "" ? "insert value" : each.value.env_value
  key_id = each.value.env_encrypted == true ? var.kms_key_arn : null

  lifecycle {
    ignore_changes = [value]
  }
}

