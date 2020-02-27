variable "environment" {
  description = "Application environment for which this network is being created. Preferred values are Development, Integration, PreProduction, Production, QA, Staging, or Test"
  type        = string
  default     = "Development"
}

variable "name" {
  description = "The name to be used for resources provisioned by this module"
  type        = string
}

variable "tags" {
  description = "A map of tags to apply to all resources."
  type        = map(string)
  default     = {}
}

variable "vpc_id" {
  description = "Provide Virtual Private Cloud ID in which security groups will be deployed"
  type        = string
}
