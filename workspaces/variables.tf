#  variables (with sensitive values) definition

variable "region" {
  type        = string
  default     = "us-east-1"
  description = "Default region for provider"
}

variable "db_pass" {
  type        = string
  description = "password for database"
  sensitive   = true
}
