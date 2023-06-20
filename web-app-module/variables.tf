# General variables
variable "app_name" {
  type        = string
  default     = "web-app"
  description = "Name of the web application"
}

variable "environment_name" {
  type        = string
  default     = "dev"
  description = "Deployment environment (dev/staging/production)"
}

# EC2 variables
variable "instance_ami" {
  type        = string
  default     = "ami-053b0d53c279acc90" # Ubuntu 22.04 LTS
  description = "ami to use for each of the instances."
}

variable "instance_type" {
  type        = string
  default     = "t2.micro"
  description = "The type of each of the instances."
}

# S3 variables
variable "bucket_prefix" {
  type        = string
  description = "The prefix of s3 bucket for app data."
}

# Route 53 variables
variable "domain" {
  type        = string
  description = "Domain for website."
}

variable "subdomain" {
  type        = string
  description = "Subdomain for website."
}

variable "create_dns_record" {
  type        = bool
  default     = false
  description = "If true, create new record for $${var.subdomain} in route53 zone of $${var.domain}."
}

# RDS variables
variable "db_name" {
  type        = string
  description = "Name of DB."
}

variable "db_user" {
  type        = string
  description = "Username of DB."
}

variable "db_pass" {
  type        = string
  description = "Password of DB."
  sensitive   = true
}