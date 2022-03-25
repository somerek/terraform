data "aws_ami" "aws_ami_selected" {
  owners      = ["amazon"]
  most_recent = true

  filter {
    name   = "name"
    values = ["amzn2-ami-kernel-5.10-hvm-*-x86_64-gp2"]
  }
}
resource "aws_instance" "ec2_server1" {
  ami                    = data.aws_ami.aws_ami_selected.id
  instance_type          = "t2.micro"
  vpc_security_group_ids = [aws_security_group.sg_web.id]
  user_data = <<EOF
  #!/bin/bash
  sudo amazon-linux-extras install nginx1
  sudo systemctl enable --now nginx
  EOF
}
// Get Subnets
# data "aws_instance" "ec2_server1" {}

resource "aws_security_group" "sg_web" {
  name        = "sg_web"
  description = "SG for nginx"
  ingress {
    description = "http"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
