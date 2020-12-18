provider "aws" {
  region  = var.region
  version = "~> 2.5"
}

terraform {
  backend "s3" {
    bucket  = "s3backendterraformsndcaucion"
    region  = "eu-central-1"
    key     = "snd/terraform-aws-snd.tfstate"
    encrypt = true
  }
}

module "vpc" {
  source = "./modules/snd/vpc"
}

module "roles" {
  source = "./modules/snd/global/roles"
}

module "iam" {
  source = "./modules/snd/global/iam"
}

module "cloudwatch" {
  source = "./modules/snd/global/cloudwatch"
}

module "networking" {
  source = "./modules/snd/networking/security_groups"
  vpc_id = module.vpc.vpc_id
}

module "ecr" {
  source = "./modules/snd/containers/repository"
}

module "s3" {
  source      = "./modules/snd/buckets"
  bucket_name = "s3frontsndcaucion"
}

module "nlb" {
  source  = "./modules/snd/compute"
  vpc_id  = module.vpc.vpc_id
  subnets = module.vpc.subnet_private
}

module "api_gateway" {
  source       = "./modules/snd/networking/api"
  nlb_dns_name = module.nlb.dns_name
  target_arns  = [module.nlb.nlb]
}


module "ecs" {
  source             = "./modules/snd/containers/ecs"
  subnets            = module.vpc.subnet_private
  security_groups    = [module.networking.sg_ecs[0]]
  execution_role_arn = module.roles.ecs_role_arn


  #Target groups of each service
  target_group_auth                 = module.nlb.tg_auth
  target_group_alias                = module.nlb.tg_alias
  target_group_asinc                = module.nlb.tg_asinc
  target_group_clientes             = module.nlb.tg_clientes
  target_group_gar_soli             = module.nlb.tg_gar_soli
  target_group_informes             = module.nlb.tg_informes
  target_group_garantias            = module.nlb.tg_garantias
  target_group_tipologias           = module.nlb.tg_tipologias
  target_group_cargos_abo           = module.nlb.tg_cargos_abo
  target_group_gar_usuarios         = module.nlb.tg_gar_usuarios
  target_group_gar_solicit_consu    = module.nlb.tg_gar_solicit_consu
  target_group_gar_info_asinc_consu = module.nlb.tg_gar_info_asinc_consu
}


/*
module "cognito" {
  source          = "./modules/snd/security/cognito"
  email_identity  = "misolunion.caucion@solunion.com"
  domain_identity = "solunion.com"
}

module "ses" {
  source          = "./modules/snd/services"
  email_topic     = "misolunion.caucion@solunion.com"
  domain_identity = "solunion.com"
}
*/

module "cognito" {
  source          = "./modules/snd/security/cognito"
  email_identity  = "vs.sarango@soprasteria.com"
  domain_identity = "solunion.com"
}

module "ses" {
  source          = "./modules/snd/services"
  email_topic     = "vs.sarango@soprasteria.com"
  domain_identity = "solunion.com"
}

