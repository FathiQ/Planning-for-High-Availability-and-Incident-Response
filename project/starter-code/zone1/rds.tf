# module "project_rds_p" {
#   source = "./modules/rds-p"
#   private_subnet_ids = module.vpc.private_subnet_ids
#   vpc_id = module.vpc.vpc_id
# }

module "project_rds_s" {
  source                  = "./modules/rds-s"
  #primary_db_cluster_arn  = module.project_rds_p.db_cluster_arn
  primary_db_cluster_arn  = "arn:aws:rds:us-east-2:346887697269:cluster:udacity-db-cluster"
  providers = {
    aws = aws.usw1
  }
  private_subnet_ids = module.vpc_west.private_subnet_ids
  vpc_id = module.vpc_west.vpc_id
}