
output "ssm_parameters" {
  value = { for key, param in aws_ssm_parameter.this : key => {
    arn   = param.arn
    name  = param.name
    value = param.value
  } }
}