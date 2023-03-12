// init
variable "aws_profile" {
  type        = string
  description = "aws profile name on computer running terraform"
}

variable "aws_region" {
  type        = string
  description = "aws AWS region where Jenkins server will be deployed"
}

variable "state_bucket_name" {
  type        = string
  description = "Terraform bakend state bucket name"
}

variable "state_key_name" {
  type        = string
  description = "Terraform bakend state key name"
}

variable "state_lock_table_name" {
  type        = string
  description = "Terraform bakend state lock DynamoDB table name"
}

// for Jenkins
variable "route53_domain_name" {
  type        = string
  description = "The domain"
}

variable "route53_zone_id" {
  type        = string
  description = <<EOF
The route53 zone id where DNS entries will be created. Should be the zone id
for the domain in the var route53_domain_name.
EOF
}

variable "jenkins_dns_alias" {
  type        = string
  description = <<EOF
The DNS alias to be associated with the deployed jenkins instance. Alias will
be created in the given route53 zone
EOF
  default     = "jenkins-controller"
}

// network
variable "environment" {}
variable "vpc_cidr" {}
variable "public_subnet_1_cidr" {}
variable "public_subnet_2_cidr" {}
variable "public_subnet_3_cidr" {}
variable "private_subnet_1_cidr" {}
variable "private_subnet_2_cidr" {}
variable "private_subnet_3_cidr" {}


# variable "vpc_id" {
#   type        = string
#   description = "The vpc id for where jenkins will be deployed"
# }

# variable "efs_subnet_ids" {
#   type        = list(string)
#   description = "A list of subnets to attach to the EFS mountpoint. Should be private"
#   #   default = ["subnet-5d12c221","subnet-2178df6d","subnet-29452043"]
# }

# variable "jenkins_controller_subnet_ids" {
#   type        = list(string)
#   description = "A list of subnets for the jenkins controller fargate service. Should be private"
#   #   default = ["subnet-5d12c221","subnet-2178df6d","subnet-29452043"]
# }

# variable "alb_subnet_ids" {
#   type        = list(string)
#   description = "A list of subnets for the Application Load Balancer"
#   #   default = ["subnet-5d12c221","subnet-2178df6d","subnet-29452043"]
# }
