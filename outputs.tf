# data module
output "vpc_id" {
  value = module.vpc.vpc_id
}

output "subnet_private" {
  value = module.vpc.subnet_private
}

# cloudwatch module
output "this_cloudwatch_log_group" {
  value = module.cloudwatch.log_group
}

# network module
output "this_ecs_security_group" {
  value = module.networking.sg_ecs
}

# ecr module
output "this_ecr_repository_urls" {
  value = module.ecr.repository_url
}

# s3 module
output "this_front_s3_name" {
  value = module.s3.front_bucket_name
}

output "this_front_s3_domain_name" {
  value = module.s3.front_bucket_domain_name
}

output "this_front_s3_website_domain" {
  value = module.s3.front_bucket_website_domain
}

output "this_front_s3_website_endpoint" {
  value = module.s3.front_bucket_website_endpoint
}

# nlb module
output "this_network_load_balancer" {
  value = module.nlb.nlb
}

output "this_nlb_dsn_name" {
  value = module.nlb.dns_name
}

output "targetgroup-auth" {
  value = module.nlb.tg_auth
}

output "targetgroup-clientes" {
  value = module.nlb.tg_clientes
}

output "targetgroup-tipologias" {
  value = module.nlb.tg_tipologias
}

output "targetgroup-garantias" {
  value = module.nlb.tg_garantias
}

output "targetgroup-alias" {
  value = module.nlb.tg_alias
}

output "targetgroup-informes" {
  value = module.nlb.tg_informes
}

output "targetgroup-asinc" {
  value = module.nlb.tg_asinc
}

output "targetgroup-cargos-abo" {
  value = module.nlb.tg_cargos_abo
}

output "targetgroup-gar-soli" {
  value = module.nlb.tg_gar_soli
}
