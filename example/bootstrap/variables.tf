variable "aws_profile" {
  type        = string
  description = "aws profile name on computer running terraform"
}

variable "aws_region" {
  type        = string
  description = "aws AWS region where Jenkins server will be deployed"
}

variable "state_bucket_name" {
  type = string
  # A random bucket name by default
  default = null
}

variable "state_lock_table_name" {
  type    = string
  default = "tf-serverless-jenkins-lock"
}

variable "state_key_name" {
  type        = string
  description = "Dummy variable to match with reusable '../init.auto.tfvars' file"
}
