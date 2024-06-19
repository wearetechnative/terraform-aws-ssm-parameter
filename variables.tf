variable "parameters" {
  description = "Configuration object indicating required setup for SSM parameters."

  type = map(object({
    parameters : map(object({
      encrypted : bool
      description : string
      value : string
    }))
  }))

}

variable "kms_key_arn" {
  description = "The ARN of the KMS key to use when encrypting the SSM parameter."
  type        = string
}