
output "ssm_parameters_non_secret" {
  value = { for key, param in aws_ssm_parameter.non_secret_variables : key => {
    arn   = param.arn
    name  = param.name
    value = param.value
  } }
}

output "ssm_parameters_secret" {
  value = { for key, param in aws_ssm_parameter.secret_variables : key => {
    arn   = param.arn
    name  = param.name
    value = param.value
  } }
}