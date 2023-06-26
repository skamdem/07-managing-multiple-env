# variables definition for "web-app-module"

# General variables
variable "app_name" {
  type        = string
  default     = "webapp"
  description = "Name of the web application"
}

variable "environment_name" {
  type        = string
  default     = "dev"
  description = "Deployment environment (dev/staging/production)"
}

variable "create_db_and_s3" {
  type        = bool
  description = "Decide wether to create s3 bucket and databases"
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
  description = "If true, create new record for $${var.subdomain} in route53 zone of $${var.domain}."
}

# ALB variables
variable "alb_ingress_rules" {
  type = list(object({
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_blocks = string
    description = string
  }))
  default = [
    { from_port   = 80
      to_port     = 80
      protocol    = "tcp"
      cidr_blocks = "0.0.0.0/0"
      description = "ordinary request"
    },
    { from_port   = 443
      to_port     = 443
      protocol    = "tcp"
      cidr_blocks = "0.0.0.0/0"
      description = "encrypted request"
    },
  ]
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

# certificates
variable "certificate_arn" {
  type        = string
  description = "arn of certificate for the ALB listener"
}