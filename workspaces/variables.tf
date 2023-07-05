# variables definition for "web-app" root module 
# in "workspaces" directory

# General variables
variable "region" {
  type        = string
  description = "Default region for provider"
}

variable "app_name" {
  type        = string
  description = "Name of the web application"
}

# Route 53 variables
variable "domain" {
  type        = string
  description = "Domain for website."
}

variable "create_db_and_s3" {
  type        = bool
  description = "Decide wether to create s3 bucket and databases"
}

# EC2 variables
variable "instance_ami" {
  type        = string
  description = "ami to use for each of the instances."
}

variable "instance_type" {
  type        = string
  description = "The type of each of the instances."
}

variable "db_user" {
  type        = string
  description = "Username of DB."
}

variable "db_pass" {
  type        = string
  description = "password for database"
  sensitive   = true // with sensitive value

  validation {
    condition     = length(var.db_pass) >= 8
    error_message = "The db_pass value must be >= 8"
  }
}
