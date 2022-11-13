  module "alb" {
   source             = "./modules/alb"
   name               = local.name
   account            = data.aws_caller_identity.current.account_id
   public_subnet_ids  = data.terraform_remote_state.vpc.outputs.public_subnet_ids
   vpc_id             = data.terraform_remote_state.vpc.outputs.vpc_id
   ec2_sg             = var.ec2_sg

   depends_on = [
     module.project_ec2
   ]
 }