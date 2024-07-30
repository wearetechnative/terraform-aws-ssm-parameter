# Example configuration

```hcl
module "ssm_parameter" {
  source = "../../technative_modules/ssm_parameter"

  parameters = {
      "staging": {
        "environment_variables": {
          "ENV_PRIME": {
            "encrypted" : false
            "description" : "staging non-encrypted data"
            "value": "" #leave open to get filler value or fill in your own value.
          },
          "CRASHLOG": {
            "encrypted": true
            "description": "staging encrypted data"
            "value": "" #leave open to get filler value or fill in your own value.
          } 
        }
    },
     "testing": {
      "environment_variables": {
        "ENV_Test": {
          "encrypted": false
          "description": "dev dev dev"
          "value": "monkey" #leave open to get filler value or fill in your own value.
        }
      }
      }
    }
    
}

```

## Example iteration through outputs

When you need to iterate through the output outside of module in order to reference one or more output variables.

```hcl
locals {
  # This logic will flatten and loop through all the ssm parameter details and make them into a concise local variable in which can be used to
  ssm_parameter_secrets = { for key, value in flatten([for k, val in module.ssm_parameter_secrets : [for v in val.ssm_parameters_secret : {
    ssm_name  = k
    ssm_path  = v.name
    ssm_value = v.value
    ssm_arn   = v.arn
  }]]) : "${value.ssm_name}" => value }

  ssm_parameter_variables = { for key, value in flatten([for k, val in module.ssm_parameter_variables : [for v in val.ssm_parameters : {
    ssm_name  = k
    ssm_path  = v.name
    ssm_value = v.value
    ssm_arn   = v.arn
  }]]) : "${value.ssm_name}" => value }

}
```
