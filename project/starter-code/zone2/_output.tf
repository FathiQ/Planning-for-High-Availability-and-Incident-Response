output "account_id" {
   value = data.aws_caller_identity.current.account_id
 }

 output "caller_arn" {
   value = data.aws_caller_identity.current.arn
 }

 output "caller_user" {
   value = data.aws_caller_identity.current.user_id
 }

  output "ec2_sg" {
     value = module.project_ec2.ec2_sg
 }