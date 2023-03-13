data "aws_caller_identity" "current" {}
data "aws_region" "current" {}
locals {
  account_id  = data.aws_caller_identity.current.account_id
  region      = data.aws_region.current.name
  name_prefix = "serverless-jenkins"

  tags = {
    team     = "devops"
    solution = "jenkins"
  }
}


resource "null_resource" "publish_env_vars" {

  triggers = {
    always_run = "${timestamp()}"
  }

  provisioner "local-exec" {
    # coming from `modules/network/outputs.tf` file.
    command     = <<-EOT
      echo "#!/bin/bash" > vars.sh
      echo >> vars.sh

      echo "PUBLIC_SUBNETS='[\"${module.network.public_subnet_id_1}\",\"${module.network.public_subnet_id_2}\",\"${module.network.public_subnet_id_3}\"]'" >> vars.sh
      echo "PRIVATE_SUBNETS='[\"${module.network.private_subnet_id_1}\",\"${module.network.private_subnet_id_2}\",\"${module.network.private_subnet_id_3}\"]'" >> vars.sh
      echo >> vars.sh

      echo 'export TF_VAR_vpc_id="${module.network.vpc_id}"' >> vars.sh 
      echo 'export TF_VAR_efs_subnet_ids=$${PRIVATE_SUBNETS}' >> vars.sh 
      echo 'export TF_VAR_jenkins_controller_subnet_ids=$${PRIVATE_SUBNETS}' >> vars.sh 
      echo 'export TF_VAR_alb_subnet_ids=$${PUBLIC_SUBNETS}' >> vars.sh 

      chmod +x vars.sh
      source ./vars.sh
    EOT
    interpreter = ["bash", "-c"]
  }
}

module "network" {
  source                = "../modules/network"
  region                = var.aws_region
  environment           = var.environment
  vpc_cidr              = var.vpc_cidr
  public_subnet_1_cidr  = var.public_subnet_1_cidr
  public_subnet_2_cidr  = var.public_subnet_2_cidr
  public_subnet_3_cidr  = var.public_subnet_3_cidr
  private_subnet_1_cidr = var.private_subnet_1_cidr
  private_subnet_2_cidr = var.private_subnet_2_cidr
  private_subnet_3_cidr = var.private_subnet_3_cidr
}

module "myip" {
  source  = "4ops/myip/http"
  version = "1.0.0"
}

// Bring your own ACM cert for the Application Load Balancer
module "acm" {
  source     = "terraform-aws-modules/acm/aws"
  version    = "~> v2.0"
  depends_on = [module.network, null_resource.publish_env_vars]

  domain_name = "${var.jenkins_dns_alias}.${var.route53_domain_name}"
  zone_id     = var.route53_zone_id

  tags = local.tags
}

// An example of creating a KMS key
resource "aws_kms_key" "efs_kms_key" {
  description = "KMS key used to encrypt Jenkins EFS volume"
}

module "serverless_jenkins" {
  source                        = "../modules/jenkins_platform"
  depends_on                    = [module.network, null_resource.publish_env_vars]
  name_prefix                   = local.name_prefix
  tags                          = local.tags
  efs_kms_key_arn               = aws_kms_key.efs_kms_key.arn
  vpc_id                        = var.vpc_id
  efs_subnet_ids                = var.efs_subnet_ids
  jenkins_controller_subnet_ids = var.jenkins_controller_subnet_ids
  alb_subnet_ids                = var.alb_subnet_ids
  alb_ingress_allow_cidrs       = ["${module.myip.address}/32"]
  alb_acm_certificate_arn       = module.acm.this_acm_certificate_arn
  route53_create_alias          = true
  route53_alias_name            = var.jenkins_dns_alias
  route53_zone_id               = var.route53_zone_id
  # vpc_id                        = module.network.vpc_id             #var.vpc_id
  # efs_subnet_ids                = module.network.private_subnet_ids #var.efs_subnet_ids
  # jenkins_controller_subnet_ids = module.network.private_subnet_ids #var.jenkins_controller_subnet_ids
  # alb_subnet_ids                = module.network.public_subnet_ids  #var.alb_subnet_ids
}

