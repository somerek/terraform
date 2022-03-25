output "my_output" {
  value = {
    vpcs    = data.aws_vpcs.my_vpcs.ids
    subnets = data.aws_subnets.my_subnets.ids
    sg      = data.aws_security_groups.my_sg.ids
  }
}
