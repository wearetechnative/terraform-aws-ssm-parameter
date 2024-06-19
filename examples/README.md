Create one or more examples here...

## Example configuration
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